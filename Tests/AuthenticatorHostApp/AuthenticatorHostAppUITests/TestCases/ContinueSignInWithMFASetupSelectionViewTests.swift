//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest

final class ContinueSignInWithMFASetupSelectionViewTests: AuthenticatorBaseTestCase {

    func testContinueSignInWithMFASetupSelectionView() throws {
        launchAppAndLogin(with: [
            .hidesSignUpButton(false),
            .initialStep(.signIn),
            .authSignInStep(.continueSignInWithMFASetupSelection)
        ])
        assertSnapshot()
    }
}
