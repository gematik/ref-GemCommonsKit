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

final class SynchronizedVarTest: XCTestCase {

    func testSynchronizedVar() {
        let syncedVar = SynchronizedVar<String>("initial")
        var oldVar: String?
        let thread = Thread {
            oldVar = syncedVar.value
            syncedVar.set { _ in "closure" }
        }
        syncedVar.set { _ in "test" }
        thread.start()
        expect(syncedVar.value).toEventually(equal("closure"))
        expect(oldVar).to(equal("test"))
    }

    @Synchronized var synchronizedString: String = "initial"

    func testSynchronizedString() {
        var oldVar: String?
        let thread = Thread {
            oldVar = self.synchronizedString
            self.synchronizedString = "closure"
        }
        synchronizedString = "test"
        thread.start()
        expect(self.synchronizedString).toEventually(equal("closure"))
        expect(oldVar).to(equal("test"))
    }

    @Synchronized var synchronizedOptionalString: String?

    func testSynchronizedOptionalString() {
        expect(self.synchronizedOptionalString).to(beNil())
        var oldVar: String?
        let thread = Thread {
            oldVar = self.synchronizedOptionalString
            self.synchronizedOptionalString = "closure"
        }
        synchronizedOptionalString = "test"
        thread.start()
        expect(self.synchronizedOptionalString).toEventually(equal("closure"))
        expect(oldVar).to(equal("test"))
    }
}
