//
//  Copyright (c) 2022 gematik GmbH
//  
//  Licensed under the Apache License, Version 2.0 (the License);
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//      http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an 'AS IS' BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
@testable import GemCommonsKit
import Nimble
import XCTest

final class BlockingVarTest: XCTestCase {
    func testBlockingVar() {
        let blockingVar = BlockingVar<String>()

        var value: String?
        var consecutiveValue: String?
        let thread = Thread {
            value = blockingVar.value
            consecutiveValue = blockingVar.value
        }
        thread.start()

        expect(blockingVar.isFulfilled).to(beFalse())
        Thread.sleep(forTimeInterval: 0.01)
        expect(thread.isExecuting).to(beTrue())
        expect(value).to(beNil())
        expect(consecutiveValue).to(beNil())
        Thread {
            // Verify the non-blocking character of `.isFulfilled`
            expect(blockingVar.isFulfilled).to(beFalse())
            Thread.sleep(forTimeInterval: 0.1)
            blockingVar.value = "hurray!"
        }.start()
        expect(value).to(beNil())
        expect(consecutiveValue).to(beNil())
        expect(value).toEventually(equal("hurray!"))
        expect(consecutiveValue).toEventually(equal("hurray!"))
        expect(blockingVar.isFulfilled).to(beTrue())
    }

    func testBlockingVarOnMainThread() {
        let blockingVar = BlockingVar<String>()

        let thread = Thread {
            DispatchQueue.main.sync {
                blockingVar.value = "Set"
            }
        }
        thread.start()

        expect(blockingVar.value) == "Set"
    }

    func testBlockingVarOnMainThreadSetFromDifferentThread() {
        let blockingVar = BlockingVar<String>()

        let thread = Thread {
            DispatchQueue.global().sync {
                blockingVar.value = "Set"
            }
        }
        thread.start()

        expect(blockingVar.value) == "Set"
    }
}
