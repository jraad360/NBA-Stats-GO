//
//  JSONReader.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 4/17/21.
//

import Foundation
import SwiftyJSON

class JSONReader {
    
    let jsonEncoder: JSONEncoder = JSONEncoder()
    let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // MARK: Writing Function
    
    /**
     Writes a serializable object to storage as JSON
     - Parameter object: the object to be stored
     - Parameter fileName: the path and name of the file to which the object will be saved
     */
    func write<T: Codable>(object: T, to fileName: String) throws {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
            try jsonEncoder.encode(object).write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    // MARK: Reading Functions
    
    /**
     Retrieves an object from storage and decodes and returns it
     - Parameter fileName: the path and name of the file storing the object to be decoded
     - Parameter structType: the kind of struct that the data is to be converted to
     */
    func read<T: Codable>(from fileName: String, structType: T.Type) throws -> T {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(fileName)

        let data = try Data(contentsOf: fileURL)
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    /**
     Retrieves JSON from local bundled file
     - Parameter name: the path and name of the file storing the object to be decoded
     */
    func readBundledFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
