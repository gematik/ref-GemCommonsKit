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

@testable import GemCommonsKit
import Nimble
import XCTest

final class StringExtDigitsTest: XCTestCase {

    func testString_isNumerical() {
        expect("1234".isNumerical).to(beTrue())
        expect("12 34".isNumerical).to(beFalse())
        expect("1234.5678".isNumerical).to(beTrue())
        expect("0".isNumerical).to(beTrue())
        expect("0.0".isNumerical).to(beTrue())
        expect("x50".isNumerical).to(beFalse())
        expect(".1".isNumerical).to(beTrue())
        expect("Any word/char".isNumerical).to(beFalse(), description: "Anywordchar whaaaat?")
    }

    func testString_isDigitsOnly() {
        expect("1234".isDigitsOnly).to(beTrue())
        expect("12 34".isDigitsOnly).to(beFalse())
        expect("1234.5678".isDigitsOnly).to(beFalse())
        expect("0".isDigitsOnly).to(beTrue())
        expect("0.0".isDigitsOnly).to(beFalse())
        expect("x50".isDigitsOnly).to(beFalse())
        expect(".1".isDigitsOnly).to(beFalse())
        expect("Any word/char".isDigitsOnly).to(beFalse(), description: "Anywordchar whaaaat?")
    }

    func testString_hasSuffixPattern() {
        expect("something[34]".hasSuffix()).to(equal("34"))
        expect("something{34}".hasSuffix(pattern: "\\{(\\d*)\\}")).to(equal("34"))
        expect("[34]something".hasSuffix()).to(beNil())
        expect("somet[34]hing".hasSuffix()).to(beNil())
    }

    func testString_match() {
        expect("something{33}".match(pattern: "\\{(\\d*)\\}$")).to(equal("33"))
        expect("something{33}{44}".match(pattern: "\\{(\\d*)\\}", group: 1)).to(equal("33"))
        expect("something{33}{44}".match(pattern: "\\{(\\d*)\\}\\{(\\d*)\\}", group: 1)).to(equal("33"))
        expect("something{33}{44}".match(pattern: "\\{(\\d*)\\}\\{(\\d*)\\}", group: 2)).to(equal("44"))
        expect("something{33}{44}".match(pattern: "\\{(\\d*)\\}\\{(\\d*)\\}", group: 3)).to(beNil())
    }

    static var allTests = [
        ("testString_isNumerical", testString_isNumerical),
        ("testString_isDigitsOnly", testString_isDigitsOnly),
        ("testString_hasSuffixPattern", testString_hasSuffixPattern),
        ("testString_match", testString_match)
    ]
}
