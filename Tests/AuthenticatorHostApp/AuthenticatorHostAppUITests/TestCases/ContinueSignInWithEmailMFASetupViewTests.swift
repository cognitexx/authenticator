//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest

final class ContinueSignInWithEmailMFASetupViewTests: AuthenticatorBaseTestCase {

    func testContinueSignInWithEmailMFASetupView() throws {
        launchAppAndLogin(with: [
            .hidesSignUpButton(false),
            .initialStep(.signIn),
            .authSignInStep(.continueSignInWithEmailMFASetup)
        ])
        assertSnapshot()
    }
}
