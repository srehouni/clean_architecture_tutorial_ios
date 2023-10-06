//
//  CryptocurrencyDomainErrorMapper.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

class CryptocurrencyDomainErrorMapper {
    func map(error: HTTPClientError?) -> CryptocurrecyDomainError {
        guard error == .tooManyRequests else {
            return .generic
        }
        
        return .tooManyRequests
    }
}
