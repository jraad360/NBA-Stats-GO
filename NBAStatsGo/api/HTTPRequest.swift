//
//  HTTPRequest.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 4/22/21.
//

import Foundation
import SwiftyJSON

class HTTPRequest {
    
    /**
     Function used to call any GET API via HTTP
     - Parameter path: the API path
     - Parameter queryParameters: the query parameters to attach to the GET call
     */
    static func callAPI(path: String, queryParameters: [String: String]) throws -> JSON {
        let url = getURL(path: path, queryParameters: queryParameters)
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: Data? = nil
        
        var httpStatusCode: Int? = nil
        
        session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            result = data
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
        if httpStatusCode == 429 {
            throw APIError.tooManyRequests
        }

        let json = result != nil ? try JSON(data: result!) : JSON()
        
        return json
    }
    
    /**
     Converts a path and query parameters into URL to make an HTTP GET request
     - Parameter path: the API path
     - Parameter queryParameters: the query parameters to attach to the GET call
     - Returns a URL
     */
    static private func getURL(path: String, queryParameters: [String: String]) -> URL {
        let queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents(string: path)!
        
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
