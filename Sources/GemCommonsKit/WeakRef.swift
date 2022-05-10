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

import Foundation

/// Swift object that holds a weak reference to an Object like its Java counter-part WeakReference.
public class WeakRef<T: AnyObject> {
    /// The weak referenced object
    public private(set) weak var value: T?

    /// Initialize a weak reference.
    /// - Parameter obj: the object to weak reference
    public required init(_ obj: T) {
        self.value = obj
    }
}
