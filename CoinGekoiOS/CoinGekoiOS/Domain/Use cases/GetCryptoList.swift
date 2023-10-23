//
//  GetCryptoList.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

protocol GetCryptoListType {
    func execute() async -> Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>
}

class GetCryptoList: GetCryptoListType {
    private let repository: CryptoListBasicInfoRepositoryType
    
    init(repository: CryptoListBasicInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError> {
        let result = await repository.getCryptoList()
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            
            return .failure(error)
        }
        
        return .success(cryptoList.sorted { $0.name < $1.name })
    }
}
