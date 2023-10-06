//
//  CryptoDetailFactory.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

class CryptoDetailFactory: CreateCryptoDetailView {
    func create(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailView {
        return CryptoDetailView(viewModel: createViewModel(cryptocurrency: cryptocurrency))
    }
    
    private func createViewModel(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailViewModel {
        return CryptoDetailViewModel(getPriceHistory: createUseCase(),
                                     errorMapper: CryptocurrencyPresentableErrorMapper(),
                                     cryptocurrency: cryptocurrency)
    }
    
    private func createUseCase() -> GetPriceHistory {
        return GetPriceHistory(repository: createRepository())
    }
    
    private func createRepository() -> CryptocurrencyPriceHistoryRepositoryType {
        return CryptocurrencyPriceRepository(apiDataSource: createDataSource(),
                                             domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                             errorMapper: CryptocurrencyDomainErrorMapper())
    }
        
    private func createDataSource() -> ApiPriceDataSourceType {
        return APIPriceDataSource(httpClient: createHTTPClient())
    }
        
    private func createHTTPClient() -> HTTPCLient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
