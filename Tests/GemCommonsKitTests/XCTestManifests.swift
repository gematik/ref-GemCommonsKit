//
//  Copyright (c) 2019 gematik - Gesellschaft für Telematikanwendungen der Gesundheitskarte mbH
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//     http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import XCTest

#if !os(macOS) && !os(iOS)
/// Run all tests in GemCommonsKit
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ThreadExtInternalTest.allTests),
        testCase(MutexTest.allTests),
        testCase(SynchronizedVarTest.allTests),
        testCase(BlockingVarTest.allTests),
        testCase(ResultTest.allTests),
        testCase(StringExtDigitsTest.allTests),
        testCase(ResourceLoaderTests.allTests),
        testCase(DataExtIOTest.allTests),
        testCase(WeakRefTest.allTests),
        testCase(WeakArrayTest.allTests)
    ]
}
#endif
