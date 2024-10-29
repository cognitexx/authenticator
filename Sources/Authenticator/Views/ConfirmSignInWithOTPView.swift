//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import SwiftUI

/// Represents the content being displayed when the ``Authenticator`` is in the ``AuthenticatorStep/confirmSignInWithOTP`` step.
public struct ConfirmSignInWithOTPView<Header: View,
                                       Footer: View>: View {
    @Environment(\.authenticatorState) private var authenticatorState
    @ObservedObject private var state: ConfirmSignInWithCodeState
    private let content: ConfirmSignInWithCodeView<Header, Footer>

    /// Creates a `ConfirmSignInWithOTPView`
    /// - Parameter state: The ``ConfirmSignInWithCodeState`` that is observed by this view
    /// - Parameter headerContent: The content displayed above the fields. Defaults to  ``ConfirmSignInWithOTPHeader``
    /// - Parameter footerContent: The content displayed bellow the fields. Defaults to  ``ConfirmSignInWithOTPFooter``
    public init(
        state: ConfirmSignInWithCodeState,
        @ViewBuilder headerContent: () -> Header = {
            ConfirmSignInWithOTPHeader()
        },
        @ViewBuilder footerContent: () -> Footer = {
            ConfirmSignInWithOTPFooter()
        }
    ) {
        self.state = state
        self.content = ConfirmSignInWithCodeView(
            state: state,
            headerContent: headerContent,
            footerContent: footerContent
        )
    }

    public var body: some View {
        content
            .onAppear {
                state.message = .info(
                    message: state.localizedMessage(for: state.deliveryDetails)
                )
            }
    }

    /// Sets a custom error mapping function for the `AuthError`s that are displayed
    /// - Parameter errorTransform: A closure that takes an `AuthError` and returns a ``AuthenticatorError`` that will be displayed.
    public func errorMap(_ errorTransform: @escaping (AuthError) -> AuthenticatorError?) -> Self {
        state.errorTransform = errorTransform
        return self
    }
}

/// Default header for the ``ConfirmSignInWithOTPView``. It displays the view's title
public struct ConfirmSignInWithOTPHeader: View {
    public init() {}
    public var body: some View {
        DefaultHeader(
            title: "authenticator.confirmSignInWithOTP.title".localized()
        )
    }
}

/// Default footer for the ``ConfirmSignInWithOTPView``. It displays the "Back to Sign In" button
public struct ConfirmSignInWithOTPFooter: View {
    @Environment(\.authenticatorState) private var authenticatorState

    public init() {}
    public var body: some View {
        Button("authenticator.confirmSignInWithCode.button.backToSignIn".localized()) {
            authenticatorState.move(to: .signIn)
        }
        .buttonStyle(.link)
    }
}
