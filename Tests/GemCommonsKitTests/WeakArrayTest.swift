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

protocol TestProtocol: class {
}

class TestClass {
    var text: String

    init(_ text: String) {
        self.text = text
    }
}

extension TestClass: TestProtocol {
}

final class WeakArrayTest: XCTestCase {
    func testWeakArrayAdd() {
        var object = TestClass("Object 1")
        let array = WeakArray<TestClass>()
        array.add(object: object)
        expect(array.count).to(equal(1))
        object = TestClass("Another 1")
        expect(array.count).to(equal(0))
    }

    func testWeakArrayObjectAtIndex() {
        var object = TestClass("Object 1")
        let array = WeakArray<TestClass>()
        array.add(object: object)
        expect(array.count).to(equal(1))
        expect(array.object(at: 0)).notTo(beNil())
        expect(array[0]).notTo(beNil())
        expect(array.object(at: 1)).to(beNil())
        expect(array[1]).to(beNil())
        expect(array.object(at: 0)).to(beIdenticalTo(object))
        expect(array[0]).to(beIdenticalTo(object))
        object = TestClass("Another 1")
        expect(array.object(at: 0)).to(beNil())
        expect(array.count).to(equal(0))
    }

    func testWeakArrayInsert() {
        let object = TestClass("Object 1")
        let array = WeakArray<TestClass>()
        array.add(object: object)
        expect(array.count).to(equal(1))
        var another = TestClass("Another 2")
        array.insert(object: another, at: 0)
        expect(array.count).to(equal(2))
        expect(array.object(at: 0)).to(beIdenticalTo(another))
        expect(array.object(at: 1)).to(beIdenticalTo(object))
        another = TestClass("Another 1")
        expect(array.object(at: 0)).to(beIdenticalTo(object))
        expect(array.object(at: 1)).to(beNil())
        expect(array.count).to(equal(1))
    }

    func testWeakArrayReplace() {
        let array = WeakArray<TestClass>()
        let strongObject = TestClass("Object 1")
        var replacedObject = TestClass("Replaced 1")
        array.add(object: strongObject)
        array.replaceObject(at: 0, with: replacedObject)
        expect(array.count).to(equal(1))
        expect(array[0]).to(beIdenticalTo(replacedObject))
        replacedObject = TestClass("Replaced 2")
        expect(array[0]).to(beNil())
        expect(array.count).to(equal(0))
    }

    func testWeakArrayRemove() {
        let strongObject = TestClass("Object 1")
        let array = WeakArray<TestClass>()
        array.add(object: strongObject)
        expect(array.count).to(equal(1))
        array.removeObject(at: 0)
        expect(array.count).to(equal(0))
    }

    func testWeakArrayCount() {
        var strongObject = TestClass("Object 1")
        let array = WeakArray<TestClass>()
        expect(array.count).to(equal(0))
        array.add(object: strongObject)
        expect(array.count).to(equal(1))
        strongObject = TestClass("Object 2")
        expect(array.count).to(equal(0))
    }

    func testWeakArrayInit() {
        let weakArray = WeakArray<TestClass>()
        var object1 = TestClass("Object 1")
        let object2 = TestClass("Object 2")
        weakArray.add(object: object1)
        weakArray.add(object: object2)
        expect(weakArray.count).to(equal(2))
        object1 = TestClass("Another object")
        expect(weakArray.count).to(equal(1))
    }

    func testWeakArrayToArray() {
        var array = [TestClass("Object 1"), TestClass("Object 2")]
        let weakArray = WeakArray(objects: array)
        var retainedArray = weakArray.array
        expect(retainedArray.count).to(equal(2))
        expect(retainedArray[0]).to(beIdenticalTo(weakArray[0]))
        expect(retainedArray[1]).to(beIdenticalTo(weakArray[1]))
        array = []
        expect(weakArray.count).to(equal(2))
        expect(retainedArray.count).to(equal(2))
        expect(retainedArray[0]).to(beIdenticalTo(weakArray[0]))
        expect(retainedArray[1]).to(beIdenticalTo(weakArray[1]))
        retainedArray = []
        expect(weakArray.count).to(equal(0))
    }

    func testArrayToWeakArray() {
        let weakArray: WeakArray<TestClass>
        var array = [TestClass("Object 1"), TestClass("Object 2")]
        weakArray = array.weakArray
        expect(weakArray.count).to(equal(2))
        array = []
        expect(weakArray.count).to(equal(0))
    }

    func testWeakArrayWithProtocol() {
        let weakArray = WeakArray<TestProtocol>()
        var object = TestClass("Test protocol 1")
        weakArray.add(object: object)
        expect(weakArray[0]).to(beIdenticalTo(object))
        object = TestClass("Another protocol")
        expect(weakArray.count).to(equal(0))
    }

    func testWeakArrayFind() {
        let weakArray: WeakArray<TestClass>
        let object1 = TestClass("Object 1")
        let array = [object1, TestClass("Object 2")]
        weakArray = WeakArray(objects: array)

        expect(weakArray.index(of: object1)).to(equal(0))
        weakArray.removeObject(at: 0)
        expect(weakArray.index(of: object1)).to(beNil())
    }

    static var allTests = [
        ("testWeakArrayAdd", testWeakArrayAdd),
        ("testWeakArrayObjectAtIndex", testWeakArrayObjectAtIndex),
        ("testWeakArrayInsert", testWeakArrayInsert),
        ("testWeakArrayReplace", testWeakArrayReplace),
        ("testWeakArrayRemove", testWeakArrayRemove),
        ("testWeakArrayCount", testWeakArrayCount),
        ("testWeakArrayInit", testWeakArrayInit),
        ("testWeakArrayToArray", testWeakArrayToArray),
        ("testArrayToWeakArray", testArrayToWeakArray),
        ("testWeakArrayWithProtocol", testWeakArrayWithProtocol),
        ("testWeakArrayFind", testWeakArrayFind)
    ]
}
