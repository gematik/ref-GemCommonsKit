//
//  Copyright (c) 2021 gematik GmbH
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

final class DataExtIOTest: XCTestCase {
    private static var file: URL!

    override class func setUp() {
        super.setUp()
        let unique = ProcessInfo.processInfo.globallyUniqueString
        file = URL(fileURLWithPath: NSTemporaryDirectory() + "/\(unique)/intermediate_dir/test_save_data.dat")
    }

    override class func tearDown() {
        super.tearDown()
        do {
            try FileManager.default.removeItem(at: file)
        } catch let error {
            ALog("Error: \(error)")
        }
    }

    func testSavingData() {
        let data = [0x0, 0x1, 0x2, 0x3].data
        guard let result = try? data.save(to: DataExtIOTest.file).get(),
              let writtenData = try? Data(contentsOf: result.url) else {
            Nimble.fail("Data failed to write/read")
            return
        }
        expect(writtenData).to(equal(data))
    }
}
