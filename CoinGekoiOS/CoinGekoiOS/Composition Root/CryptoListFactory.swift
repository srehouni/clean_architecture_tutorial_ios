//
//  CryptoListFactory.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

class CryptoListFactory {
    static func create() -> CryptoListView {
        return CryptoListView(viewModel: createViewModel(), 
                              createCryptoDetailView: CryptoDetailFactory())
    }
    
    private static func createViewModel() -> CryptoListViewModel {
        return CryptoListViewModel(getCryptoList: createGetCryptoListUseCase(),
                                   searchCryptoList: createSearchCryptoListUseCase(),
                                   errorMapper: CryptocurrencyPresentableErrorMapper(), 
                                   cryptoListItemAdapter: createCryptoListItemAdapter())
    }
    
    private static func createCryptoListItemAdapter() -> CryptoListItemAdapterType {
        return CryptoListItemAdapter(getPriceInfo: createGetPriceInfoUseCase())
    }
    
    private static func createGetCryptoListUseCase() -> GetCryptoListType {
        return GetCryptoList(repository: createRepository())
    }
    
    private static func createSearchCryptoListUseCase() -> SearchCryptoListType {
        return SearchCryptoList(repository: createRepository())
    }
    
    private static func createGetPriceInfoUseCase() -> GetPriceInfoType {
        return GetPriceInfo(repository: createPriceInfoRepository())
    }
    
    private static func createRepository() -> CryptocurrencyBasicInfoRepository {
        return CryptocurrencyBasicInfoRepository(apiDatasource: createAPIDataSource(),
                                                 errorMapper: CryptocurrencyDomainErrorMapper(),
                                                 cacheDatasource: createCacheDataSource())
    }
    
    private static func createCacheDataSource() -> CacheCryptocurrencyBasicInfoDataSourceType {
        return StrategyCacheCryptocurrencyBasicInfo(temporalCache: InMemoryCacheCryptocurrencyBasicInfoDataSource.shared,
                                             persistanceCache: createPersistanceCacheDataSource())
    }
    
    private static func createPersistanceCacheDataSource() -> CacheCryptocurrencyBasicInfoDataSourceType {
        return SwiftDataCacheBasicInfoDataSource(container: SwiftDataContainer.shared)
    }
    
    private static func createPriceInfoRepository() -> CryptocurrencyPriceInfoRepositoryType {
        return CryptocurrencyPriceRepository(apiDataSource: createAPIDataSource(),
                                      domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                      errorMapper: CryptocurrencyDomainErrorMapper())
    }
    
    private static func createAPIDataSource() -> APICryptocurrencyBasicInfoDataSourceType {
        return APICryptoDataSource(httpCLient: createHTTPClient())
    }
    
    private static func createAPIDataSource() -> ApiPriceDataSourceType {
        return APIPriceDataSource(httpClient: createHTTPClient())
    }
    
    private static func createHTTPClient() -> HTTPCLient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
