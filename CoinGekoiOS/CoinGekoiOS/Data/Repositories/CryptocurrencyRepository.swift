//
//  CryptocurrencyRepository.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

class CryptocurrencyRepository: GlobalCryptoListRepositoryType {
    private let apiDataSourcePriceInfo: ApiDataSourcePriceInfoType
    private let apiDataSourceSymbol: ApiDataSourceSymbolType
    private let apiDataSourceCrypto: ApiDataSourceCryptoType
    private let errorMapper: CryptocurrencyDomainErrorMapper
    private let domainMapper: CryptocurrencyDomainMapper
    
    init(apiDataSourcePriceInfo: ApiDataSourcePriceInfoType, apiDataSourceSymbol: ApiDataSourceSymbolType, apiDataSourceCrypto: ApiDataSourceCryptoType, errorMapper: CryptocurrencyDomainErrorMapper, domainMapper: CryptocurrencyDomainMapper) {
        self.apiDataSourcePriceInfo = apiDataSourcePriceInfo
        self.apiDataSourceSymbol = apiDataSourceSymbol
        self.apiDataSourceCrypto = apiDataSourceCrypto
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrecyDomainError> {
        let symbolListResult = await apiDataSourceSymbol.getGlobalCryptoSymbolList()
        let cryptoListResult = await apiDataSourceCrypto.getCryptoList()
        
        guard case .success(let symbolList) = symbolListResult else {
            return .failure(errorMapper.map(error: symbolListResult.failureValue as? HTTPClientError))
        }
        
        guard case .success(let cryptoList) = cryptoListResult else {
            return .failure(errorMapper.map(error: cryptoListResult.failureValue as? HTTPClientError))
        }
        
        let cryptocurrencyBuilderList = domainMapper.getCryptocurrencyBuilderList(symbolList: symbolList, cryptoList: cryptoList.filter { !$0.id.contains("-") } )
        
        let priceInfoResult = await apiDataSourcePriceInfo.getPriceInfoForCryptos(id: cryptocurrencyBuilderList.map { $0.id })
        
        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: priceInfoResult.failureValue as? HTTPClientError))
        }
        
        let cryptocurency = domainMapper.map(cryptocurrencyBuilderList: cryptocurrencyBuilderList,
                                             priceInfo: priceInfo)
        
        return .success(cryptocurency)
    }
}
