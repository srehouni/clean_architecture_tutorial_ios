//
//  CryptoListPresentableItem.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import Foundation

struct CryptoListPresentableItem {
    let id: String
    let name: String
    let symbol: String
    let price: String
    let price24h: String
    let volume24h: String
    let marketCap: String
    let isPriceChangePositive: Bool
    
    init(domainModel: Cryptocurrency) {
        self.id = domainModel.id
        self.name = domainModel.name
        self.symbol = domainModel.symbol
        self.price = domainModel.price.toCurrency() ?? "-"
        self.price24h = domainModel.price24h != nil ? String(format: "%.2f", domainModel.price24h!) + " %" : "-"
        self.volume24h = domainModel.volume24h != nil ? (domainModel.volume24h?.toCurrency() ?? "-") : "-"
        self.marketCap = domainModel.marketCap.toCurrency() ?? "-"
        self.isPriceChangePositive = (domainModel.price24h ?? 0) >= 0
    }
}

extension CryptoListPresentableItem: Hashable {
    
}
