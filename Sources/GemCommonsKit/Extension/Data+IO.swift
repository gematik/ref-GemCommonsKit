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

extension Data {
    /// Result Tuple/Pair with information about the write action.
    /// Where it was written and what was written.
    public typealias WriteResult = (url: URL, data: Data)

    /**
        Save Data to file and capture response/exception in Result

        - Parameters:
            - file: the URL file/path to write to
            - options: Writing settings. Default: .atomicWrite

        - Returns: Result of the write by returning the URL and self upon success.
     */
    public func save(to file: URL, options: WritingOptions = .atomicWrite) -> Result<WriteResult, Error> {
        return Result {
            try FileManager.default.createDirectory(at: file.deletingLastPathComponent(),
                    withIntermediateDirectories: true)
            try self.write(to: file, options: options)
            return (file, self)
        }
    }
}