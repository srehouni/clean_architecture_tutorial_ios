//
//  GlobalCryptoListRepositoryType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

protocol GlobalCryptoListRepositoryType {
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrecyDomainError>
}
