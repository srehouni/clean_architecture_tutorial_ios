//
//  Endpoint.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParameters: [String : Any]
    let method: HTTPMethod
}
