//
//  CryptoListItemAdapter.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 30/10/23.
//

import Foundation

protocol CryptoListItemAdapterType {
    func adapt(crypto: CryptoListBasicInfoPresentableItem) async -> CryptoListPresentableItem?
}

class CryptoListItemAdapter: CryptoListItemAdapterType {
    private let getPriceInfo: GetPriceInfoType
    
    init(getPriceInfo: GetPriceInfoType) {
        self.getPriceInfo = getPriceInfo
    }
    
    func adapt(crypto: CryptoListBasicInfoPresentableItem) async -> CryptoListPresentableItem? {
        let result = await getPriceInfo.execute(id: crypto.id)
        
        guard case .success(let priceInfo) = result else {
            return nil
        }
        
        let domainModel = Cryptocurrency(id: crypto.id,
                                         name: crypto.name,
                                         symbol: crypto.symbol,
                                         price: priceInfo.price,
                                         price24h: priceInfo.price24h,
                                         volume24h: priceInfo.volume24h,
                                         marketCap: priceInfo.marketCap)
        
        
        return CryptoListPresentableItem(domainModel: domainModel)
    }
}
