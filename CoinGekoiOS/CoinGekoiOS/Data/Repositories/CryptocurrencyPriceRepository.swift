//
//  CryptocurrencyPriceRepository.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

class CryptocurrencyPriceHistoryDomainMapper {
    func map(priceHistoryDTO: CryptocurrencyPriceHistoryDTO) -> CryptocurrencyPriceHistory {
        
        let dataPoints: [CryptocurrencyPriceHistory.DataPoint] = priceHistoryDTO.prices.compactMap { dataPoint in
            
            guard dataPoint.count >= 2,
                  let date = timestampToDate(dataPoint[0]),
                    let price = dataPoint[1].toCurrency() else { return nil }
            
            return CryptocurrencyPriceHistory.DataPoint(price: price,
                                                        date: date)
        }
        
        return CryptocurrencyPriceHistory(prices: dataPoints)
    }
    
    private func timestampToDate(_ timestamp: Double) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: Date(timeIntervalSince1970: timestamp / 1000))
        
        guard let date = calendar.date(from: components) else { return nil }
        
        return date
    }
}

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
