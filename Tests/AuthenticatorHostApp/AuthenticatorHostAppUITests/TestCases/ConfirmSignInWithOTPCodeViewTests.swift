//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest

final class ConfirmSignInWithOTPCodeViewTests: AuthenticatorBaseTestCase {

    func testConfirmSignInWithEmail() throws {
        launchAppAndLogin(with: [
            .hidesSignUpButton(false),
            .initialStep(.signIn),
            .authSignInStep(.confirmSignInWithEmailMFACode)
        ])
        assertSnapshot()
    }

    func testConfirmSignInWithSMS() throws {
        launchAppAndLogin(with: [
            .hidesSignUpButton(false),
            .initialStep(.signIn),
            .authSignInStep(.confirmSignInWithSMSMFACode)
        ])
        assertSnapshot()
    }
}
