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
        self.price = "\(domainModel.price) $"
        self.price24h = domainModel.price24h != nil ? "\(domainModel.price24h!) %" : "-"
        self.volume24h = domainModel.volume24h != nil ? "\(domainModel.volume24h!) $" : "-"
        self.marketCap = "\(domainModel.marketCap) $"
        self.isPriceChangePositive = (domainModel.price24h ?? 0) >= 0
    }
}
