//
//  CryptoListBasicInfoRepositoryStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import Foundation
@testable import CoinGekoiOS

class CryptoListBasicInfoRepositoryStub: CryptoListBasicInfoRepositoryType {
    private let result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>
    
    init(result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>) {
        self.result = result
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError> {
        return result
    }
}
