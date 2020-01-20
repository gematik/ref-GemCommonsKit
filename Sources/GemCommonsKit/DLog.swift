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

extension FileManager {
    /**
        generate a logfile (absolute) path in the users .documentDirectory with specified filename or default

        Note: this function does not check for previous existence of any file.

        - Parameter filename: the name for the logfile or default: 'logfile.txt'

        - Returns: The absolute path for a logfile
    */
    public static func logfilePath(_ filename: String = "logfile.txt") -> String {
        // get path to Documents/somefile.txt
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return (documentsDirectory as NSString).appendingPathComponent(filename)
    }
}

extension Date {
    var logTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd H:m:ss.SSSS"

        return formatter.string(from: self) // -> "2016-11-17 17:51:15.1720"
    }
}

/**
    DLog and ALog macros to abbreviate NSLog.

    Example:
    ```
    DLog("Log this!")
    ```
*/
public func DLog(_ message: @autoclosure () -> String,
                 filename: String = #file,
                 function: String = #function,
                 line: Int = #line) {
#if DEBUG
#if os(iOS)
    let txt = "[Thread: \(Thread.current.threadName)]:[\(Date().logTime)]:[D]" +
            "[\(URL(fileURLWithPath: filename).lastPathComponent):\(line)] \(function) - \(message()) \n"

    if let message = txt.data(using: .utf8) {
        print(message)
    }

    let path = FileManager.logfilePath()
    // create if needed
    let fman = FileManager.default
    if !fman.fileExists(atPath: path) {
        fman.createFile(atPath: path, contents: Data.empty)
    }
    // append
    if let handle = FileHandle(forWritingAtPath: path) {
        handle.truncateFile(atOffset: handle.seekToEndOfFile())
        if let messageData = txt.data(using: .utf8) {
            handle.write(messageData)
        }
        handle.closeFile()
    } else {
        ALog("Could not log to file: [\(path)]")
    }

#endif // iOS
    NSLog("[Thread: \(Thread.current.threadName)]:[D]" +
            "[\(URL(fileURLWithPath: filename).lastPathComponent):\(line)] \(function) - %@", message())
#endif // DEBUG
}

/**
    Always log a message to Console
 */
public func ALog(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    NSLog("[A][\(URL(fileURLWithPath: filename).lastPathComponent):\(line)] \(function) - %@", message)
}
