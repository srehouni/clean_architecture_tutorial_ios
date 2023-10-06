//
//  CryptocurrencyPresentableErrorMapper.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import Foundation

class CryptocurrencyPresentableErrorMapper {
    func map(error: CryptocurrecyDomainError?) -> String {
        guard error == .tooManyRequests else {
            return "Something went wrong"
        }
        
        return "You have exceeded the limit. Try again later"
    }
}
