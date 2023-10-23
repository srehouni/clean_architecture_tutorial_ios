//
//  SearchCryptoList.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

protocol SearchCryptoListType {
    func execute(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>
}

class SearchCryptoList: SearchCryptoListType {
    private let repository: SearchCryptoListBasicInfoRepositoryType
    
    init(repository: SearchCryptoListBasicInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError> {
        let result = await repository.search(crypto: crypto)
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            
            return .failure(error)
        }
        
        return .success(cryptoList.sorted { $0.name < $1.name })
    }
}
