//
//  CryptocurrencyPriceInfoRepositoryStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import Foundation
@testable import CoinGekoiOS

class CryptocurrencyPriceInfoRepositoryStub: CryptocurrencyPriceInfoRepositoryType {
    private let result: Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError>
    
    init(result: Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError>) {
        self.result = result
    }
    
    func getPriceInfo(id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError> {
        return result
    }
}
