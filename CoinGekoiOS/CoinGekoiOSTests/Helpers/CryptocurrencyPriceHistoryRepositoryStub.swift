//
//  CryptocurrencyPriceHistoryRepositoryStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import Foundation
@testable import CoinGekoiOS

class CryptocurrencyPriceHistoryRepositoryStub: CryptocurrencyPriceHistoryRepositoryType {
    private let result: Result<CryptocurrencyPriceHistory, CryptocurrecyDomainError>
    
    init(result: Result<CryptocurrencyPriceHistory, CryptocurrecyDomainError>) {
        self.result = result
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrecyDomainError> {
        return result
    }
}
