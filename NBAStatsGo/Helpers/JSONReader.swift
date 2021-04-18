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
    
    func read<T: Codable>(from fileName: String, structType: T.Type) throws -> T {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(fileName)

        let data = try Data(contentsOf: fileURL)
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    /**
     Retrieves JSON from local file
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
