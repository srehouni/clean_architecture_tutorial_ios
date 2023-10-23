//
//  CryptoListFactory.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

class CryptoListFactory {
    static func create() -> CryptoListView {
        return CryptoListView(viewModel: createViewModel())
    }
    
    private static func createViewModel() -> CryptoListViewModel {
        return CryptoListViewModel(getCryptoList: createGetCryptoListUseCase(),
                                   searchCryptoList: createSearchCryptoListUseCase(),
                                   errorMapper: CryptocurrencyPresentableErrorMapper())
    }
    
    private static func createGetCryptoListUseCase() -> GetCryptoListType {
        return GetCryptoList(repository: createRepository())
    }
    
    private static func createSearchCryptoListUseCase() -> SearchCryptoListType {
        return SearchCryptoList(repository: createRepository())
    }
    
    private static func createRepository() -> CryptocurrencyBasicInfoRepository {
        return CryptocurrencyBasicInfoRepository(apiDatasource: createAPIDataSource(),
                                                 errorMapper: CryptocurrencyDomainErrorMapper(),
                                                 cacheDatasource: InMemoryCacheCryptocurrencyBasicInfoDataSource.shared)
    }
    
    private static func createAPIDataSource() -> APICryptocurrencyBasicInfoDataSourceType {
        return APICryptoDataSource(httpCLient: createHTTPClient())
    }
    
    private static func createHTTPClient() -> HTTPCLient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
