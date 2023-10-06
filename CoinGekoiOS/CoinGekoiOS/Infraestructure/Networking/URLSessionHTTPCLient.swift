//
//  URLSessionHTTPCLient.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import Foundation

class URLSessionHTTPCLient: HTTPCLient {
    private let session: URLSession
    private let requestMaker: URLSessionRequestMaker
    private let errorResolver: URLSessionErrorResolver
    
    init(session: URLSession = .shared, requestMaker: URLSessionRequestMaker, errorResolver: URLSessionErrorResolver) {
        self.session = session
        self.requestMaker = requestMaker
        self.errorResolver = errorResolver
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        guard let url = requestMaker.url(endpoint: endpoint, baseUrl: baseUrl) else {
            return .failure(.badURL)
        }
        
        do {
            let result = try await session.data(from: url)
            
            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.responseError)
            }
            
            guard response.statusCode == 200 else {
                return .failure(errorResolver.resolve(statusCode: response.statusCode))
            }
            
            return .success(result.0)
            
        } catch {
            return .failure(errorResolver.resolve(error: error))
        }
    }
}
