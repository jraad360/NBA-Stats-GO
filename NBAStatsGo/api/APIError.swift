//
//  APIError.swift
//  NBAStatsGo
//
//  Created by Jorge Alejandro Raad on 3/30/21.
//

import Foundation

enum APIError: Error {
    case notFound
    case tooManyRequests
    case failedConnection
    case unknown
}
