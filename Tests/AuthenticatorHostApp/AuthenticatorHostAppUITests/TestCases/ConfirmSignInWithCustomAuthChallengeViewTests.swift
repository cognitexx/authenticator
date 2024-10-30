//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest

final class ConfirmSignInWithCustomAuthChallengeViewTests: AuthenticatorBaseTestCase {

    func testConfirmSignInWithCustomAuthChallenge() throws {
        launchAppAndLogin(with: [
            .hidesSignUpButton(false),
            .initialStep(.signIn),
            .authSignInStep(.confirmSignInWithCustomChallenge)
        ])
        assertSnapshot()
    }

}
