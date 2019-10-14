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

import Foundation

/// Common error(s)
public enum CommonError: Error {
    /// Indicate a function was not (yet) implemented
    case notImplementedError
}

/// Indicate a method is not supposed to be called but overridden by its subtypes
public func abstractError(file: StaticString = #file, line: UInt = #line) -> Swift.Never {
    //swiftlint:disable:previous unavailable_function
    fatalError("Non-overwritten abstract method", file: file, line: line)
}
