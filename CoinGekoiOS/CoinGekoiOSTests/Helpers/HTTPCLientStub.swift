//
//  HTTPCLientStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 9/3/24.
//

import Foundation
@testable import CoinGekoiOS

class HTTPCLientStub: HTTPCLient {
    private let result: Result<Data, HTTPClientError>
    
    init(result: Result<Data, HTTPClientError>) {
        self.result = result
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        return result
    }
}
