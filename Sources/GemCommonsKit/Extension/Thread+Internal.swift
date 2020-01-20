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

extension Thread {
    /**
        Tells whether the Thread has not been started.
        E.g. nor running, nor cancelled nor finished

        - Returns: true when not yet started.
    */
    public var didNotStart: Bool {
        return !self.isExecuting && !self.isCancelled && !self.isFinished
    }
}

extension Thread {
    /// Internal extension
    var threadName: String {
        let tName: String
        if let name = Thread.current.name, !name.isEmpty {
            tName = name
        } else if Thread.isMainThread {
            tName = "main"
        } else {
            tName = "no-name"
        }
        return tName
    }
}
