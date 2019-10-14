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

/**
    Thread-Safe variable wrapper.

    Makes sure the get and set are happening synchronously by using
    a Mutex for reader/writing to the wrapped value
 */
public class SynchronizedVar<T> {
    private var _value: T
    private let mutex = NSRecursiveLock()

    /// Canonical constructor
    public init(_ value: T) {
        _value = value
    }

    /**
        Get/Set the value for this SynchronizedVar in a
        thread-safe (blocking) manner
     */
    public var value: T {
        get {
            mutex.lock()
            defer {
                mutex.unlock()
            }
            return _value
        }
        set {
            mutex.lock()
            _value = newValue
            mutex.unlock()
        }
    }
}
