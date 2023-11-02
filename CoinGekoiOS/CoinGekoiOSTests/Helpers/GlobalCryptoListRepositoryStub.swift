//
//  GlobalCryptoListRepositoryStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import Foundation
@testable import CoinGekoiOS

class GlobalCryptoListRepositoryStub: GlobalCryptoListRepositoryType {
    private let result: Result<[Cryptocurrency], CryptocurrecyDomainError>
    
    init(result: Result<[Cryptocurrency], CryptocurrecyDomainError>) {
        self.result = result
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrecyDomainError> {
        return result
    }
}
