//
//  GetPriceInfo.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 30/10/23.
//

import Foundation

protocol GetPriceInfoType {
    func execute(id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError>
}

class GetPriceInfo: GetPriceInfoType {
    private let repository: CryptocurrencyPriceInfoRepositoryType
    
    init(repository: CryptocurrencyPriceInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute(id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError> {
        return await repository.getPriceInfo(id: id)
    }
}
