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

/**
    Property wrapper for `SynchronizedVar` wrapper.

    Makes sure the get and set are happening synchronously by using
    `SynchronizedVar` for reader/writing to the wrapped value
 */
@propertyWrapper
public struct Synchronized<T> {
    private let backing: SynchronizedVar<T>

    /// Initialize a Synchronized wrapper
    ///
    /// - Parameter backing: the initial value
    public init(wrappedValue backing: T) {
        self.backing = SynchronizedVar(backing)
    }

    /// Get/Set the backed value
    public var wrappedValue: T {
        get {
            backing.value
        }
        set {
            backing.set { _ in
                newValue
            }
        }
    }

    /// Projected self
    public var projectedValue: Synchronized<T> {
        get {
            return self
        }
        mutating set {
            self = newValue
        }
    }
}
