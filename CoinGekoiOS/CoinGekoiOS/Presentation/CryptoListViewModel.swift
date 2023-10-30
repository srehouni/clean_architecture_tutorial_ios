//
//  CryptoListViewModel.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

class CryptoListViewModel: ObservableObject {
    private let getCryptoList: GetCryptoListType
    private let searchCryptoList: SearchCryptoListType
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    private let cryptoListItemAdapter: CryptoListItemAdapterType
    @Published var cryptos: [CryptoListBasicInfoPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var cryptoDetail: CryptoListPresentableItem?
    
    init(getCryptoList: GetCryptoListType, searchCryptoList: SearchCryptoListType, errorMapper: CryptocurrencyPresentableErrorMapper, cryptoListItemAdapter: CryptoListItemAdapterType) {
        self.getCryptoList = getCryptoList
        self.searchCryptoList = searchCryptoList
        self.errorMapper = errorMapper
        self.cryptoListItemAdapter = cryptoListItemAdapter
    }
    
    func onAppear() {
        showLoadingSpinner = true
        Task {
            let result = await getCryptoList.execute()
            handleResult(result)
        }
    }
    
    func search(crypto: String) {
        Task {
            let result = await searchCryptoList.execute(crypto: crypto)
            handleResult(result)
        }
    }
    
    func getCrypto(_ crypto: CryptoListBasicInfoPresentableItem) {
        Task {
            let result = await cryptoListItemAdapter.adapt(crypto: crypto)
            Task { @MainActor in
                cryptoDetail = result
            }
        }
    }
    
    private func handleResult(_ result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>) {
        guard case .success(let cryptos) = result else {
            handleError(error: result.failureValue as? CryptocurrecyDomainError)
            return
        }
        
        let cryptosPresentable = cryptos.map { CryptoListBasicInfoPresentableItem(id: $0.id, name: $0.name, symbol: $0.symbol) }
        
        Task { @MainActor in
            showLoadingSpinner = false
            self.cryptos = cryptosPresentable
        }
    }
    
    private func handleError(error: CryptocurrecyDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}
