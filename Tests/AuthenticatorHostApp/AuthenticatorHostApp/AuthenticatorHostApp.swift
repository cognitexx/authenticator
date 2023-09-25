//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
@testable import Authenticator
import AWSCognitoAuthPlugin
import SwiftUI

@main
struct AuthenticatorHostApp: App {

    private let factory = AuthCategoryConfigurationFactory.shared
    private var hidesSignUpButton = false
    private var initialStep = AuthenticatorInitialStep.signIn

    var body: some Scene {
        WindowGroup {
            ContentView(
                hidesSignUpButton: hidesSignUpButton,
                initialStep: initialStep)
        }
    }

    init() {
        processUITestLaunchArguments()
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure(AmplifyConfiguration(auth: factory.createConfiguration()))
        } catch {
            print("Unable to configure Amplify \(error)")
        }
    }

    mutating func modifyConfiguration(for argument: ProcessArgument) {
        switch argument {
        case .initialStep(let step):
            self.initialStep = step
        case .hidesSignUpButton(let hidesSignUpButton):
            self.hidesSignUpButton = hidesSignUpButton
        case .userAttributes(let userAttributes):
            factory.setUserAtributes(userAttributes)
        }
    }

    mutating func processUITestLaunchArguments() {
        let uiTestArguments = ProcessInfo.processInfo.arguments
        var arguments: [ProcessArgument] = []
        for (index, argument) in uiTestArguments.enumerated() {
            if argument.isEqual("-uiTestArgsData") {
                arguments = try! JSONDecoder().decode([ProcessArgument].self, from: uiTestArguments[index + 1].data(using: .utf8)!)
                break
            }
        }
        for argument in arguments {
            modifyConfiguration(for: argument)
        }
    }
}
