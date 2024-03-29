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

@testable import GemCommonsKit
import Nimble
import XCTest

final class ThreadExtInternalTest: XCTestCase {
    func testThread_didNotStart_start() {
        let thread = Thread {}
        expect(thread.didNotStart).to(beTrue())
        thread.start()
        expect(thread.didNotStart).toEventually(beFalse(), pollInterval: DispatchTimeInterval.milliseconds(1))
    }

    func testThread_didNotStart_cancelled() {
        let thread = Thread {
            Thread.sleep(forTimeInterval: 0.5)
        }
        expect(thread.didNotStart).to(beTrue())
        thread.start()
        Thread.sleep(forTimeInterval: 0.001)
        thread.cancel()
        expect(thread.didNotStart).toEventually(beFalse(), pollInterval: DispatchTimeInterval.milliseconds(1))
        expect(thread.isFinished).toEventually(beFalse(), pollInterval: DispatchTimeInterval.milliseconds(1))
    }

    func testThread_didNotStart_finished() {
        let thread = Thread {

        }
        expect(thread.didNotStart).to(beTrue())
        thread.start()
        expect(thread.didNotStart).toEventually(beFalse(), pollInterval: DispatchTimeInterval.milliseconds(1))
        expect(thread.isFinished).toEventually(beTrue(), pollInterval: DispatchTimeInterval.milliseconds(1))
    }
}
