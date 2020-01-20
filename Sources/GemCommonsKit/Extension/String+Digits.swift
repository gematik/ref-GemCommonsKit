//
//  Copyright (c) 2020 gematik GmbH
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

extension String {
    private static let numericalRegex = try? NSRegularExpression(pattern: "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$")
    private static let digitsRegex = try? NSRegularExpression(pattern: "^(?:|0|[1-9]\\d*)$")

    /**
        Check if the provided string is a number representation

        E.g.
        1234 -> true
        1234.5678 -> true
        0 -> true
        0.0 -> true
        x50 -> false
        .1 -> true
        Any word/char -> false
     */
    public var isNumerical: Bool {
        if let regex = String.numericalRegex {
            let matches = regex.matches(in: self, options: [], range: self.fullRange)
            return !matches.isEmpty
        }
        return false
    }

    /**
        Check if the provided string holds only digits [0-9]

        E.g.
        1234 -> true
        1234.5678 -> false
        0 -> true
        0.0 -> false
        x50 -> false
        .1 -> false
        Any word/char -> false
     */
    public var isDigitsOnly: Bool {
        if let regex = String.digitsRegex {
            let matches = regex.matches(in: self, options: [], range: self.fullRange)
            return !matches.isEmpty
        }
        return false
    }

    /// NSRange with full range of `self`
    public var fullRange: NSRange {
        return NSRange(location: 0, length: self.count)
    }
}

extension String {
    /**
        Find the first group in the matching suffix string and return that substring in group.
     */
    @available(*, deprecated)
    public func hasSuffix(pattern: String = "\\[(\\d*)\\]") -> String? {
        return self.match(pattern: "^.*\(pattern)$")
    }
}

extension String {
    /**
        Returns the nth found group by the pattern matched as a string.
    */
    public func match(pattern: String, group number: Int = 1) -> String? {
        guard let regex = try? NSRegularExpression(pattern: "\(pattern)") else {
            return nil
        }
        let result = regex.matches(in: self, options: [], range: self.fullRange)
        guard !result.isEmpty, result[0].numberOfRanges > 1, result[0].numberOfRanges > number else {
            return nil
        }

        return (self as NSString).substring(with: result[0].range(at: number))
    }
}
