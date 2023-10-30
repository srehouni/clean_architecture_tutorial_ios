//
//  CryptocurrencyPriceRepository.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

class CryptocurrencyPriceRepository: CryptocurrencyPriceHistoryRepositoryType {
    private let apiDataSource: ApiPriceDataSourceType
    private let domainMapper: CryptocurrencyPriceHistoryDomainMapper
    private let errorMapper: CryptocurrencyDomainErrorMapper
    
    init(apiDataSource: ApiPriceDataSourceType, domainMapper: CryptocurrencyPriceHistoryDomainMapper, errorMapper: CryptocurrencyDomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.domainMapper = domainMapper
        self.errorMapper = errorMapper
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrecyDomainError> {
        let result = await apiDataSource.getPriceHistory(id: id, days: days)
        
        guard case .success(let priceHistory) = result else {
            return .failure(errorMapper.map(error: result.failureValue as? HTTPClientError))
        }

        return .success(domainMapper.map(priceHistoryDTO: priceHistory))
    }
}

extension CryptocurrencyPriceRepository: CryptocurrencyPriceInfoRepositoryType {
    func getPriceInfo(id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError> {
        let result = await apiDataSource.getPriceInfoForCryptos(id: [id])
        
        guard case .success(let priceInfoDictionary) = result else {
            return .failure(errorMapper.map(error: result.failureValue as? HTTPClientError))
        }
        
        guard let priceInfo = priceInfoDictionary.values.first else {
            return .failure(.generic)
        }
        
        let priceInfoDomain = CryptocurrencyPriceInfo(price: priceInfo.price,
                                                      price24h: priceInfo.price24h,
                                                      volume24h: priceInfo.volume24h,
                                                      marketCap: priceInfo.marketCap)
        return .success(priceInfoDomain)
    }
}
