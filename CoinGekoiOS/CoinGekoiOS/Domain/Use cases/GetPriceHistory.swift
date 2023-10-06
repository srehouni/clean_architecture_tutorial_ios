//
//  GetPriceHistory.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

class GetPriceHistory {
    private let repository: CryptocurrencyPriceHistoryRepositoryType
    
    init(repository: CryptocurrencyPriceHistoryRepositoryType) {
        self.repository = repository
    }
    
    func execute(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrecyDomainError> {
        return await repository.getPriceHistory(id: id, days: days)
    }
}
