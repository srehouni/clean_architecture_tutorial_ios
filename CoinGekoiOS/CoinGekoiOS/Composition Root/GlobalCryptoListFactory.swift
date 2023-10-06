//
//  GlobalCryptoListFactory.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import Foundation

class GlobalCryptoListFactory {
    static func create() -> GlobalCryptoListView {
        return GlobalCryptoListView(viewModel: createViewModel(),
                                    createCryptoDetailView: CryptoDetailFactory())
    }
    
    private static func createViewModel() -> GlobalCryptoListViewModel {
        return GlobalCryptoListViewModel(getGlobalCryptoList: createUseCase(),
                                         errorMapper: CryptocurrencyPresentableErrorMapper())
    }
    
    private static func createUseCase() -> GetGlobalCryptoListType {
        return GetGlobalCryptoList(repository: createRepository())
    }
    
    private static func createRepository() -> GlobalCryptoListRepositoryType {
        return CryptocurrencyRepository(apiDatasource: createDataSource(),
                                        errorMapper: CryptocurrencyDomainErrorMapper(),
                                        domainMapper: CryptocurrencyDomainMapper())
    }
    
    private static func createDataSource() -> ApiDataSourceType {
        let httpClient = URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                              errorResolver: URLSessionErrorResolver())
        return APICryptoDataSource(httpCLient: httpClient)
    }
    
}
