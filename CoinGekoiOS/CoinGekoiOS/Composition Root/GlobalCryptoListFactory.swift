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
        let apiDataSource = createDataSource()
        return CryptocurrencyRepository(apiDataSourcePriceInfo: apiDataSource,
                                        apiDataSourceSymbol: apiDataSource,
                                        apiDataSourceCrypto: apiDataSource,
                                        errorMapper: CryptocurrencyDomainErrorMapper(),
                                        domainMapper: CryptocurrencyDomainMapper())
    }
    
    private static func createDataSource() -> APICryptoDataSource {
        let httpClient = URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                              errorResolver: URLSessionErrorResolver())
        return APICryptoDataSource(httpCLient: httpClient)
    }
    
}
