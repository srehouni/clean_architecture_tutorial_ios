//
//  SwiftDataContainer.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 30/10/23.
//

import Foundation
import SwiftData

class SwiftDataContainer: SwiftDataContainerType {
    static let shared = SwiftDataContainer()
    
    private let container: ModelContainer
    private let context: ModelContext
    
    private init() {
        let scheme = Schema([CryptocurrencyBasicInfoData.self])
        container = try! ModelContainer(for: scheme, configurations: [])
        context = ModelContext(container)
    }
    
    func fetchCryptos() -> [CryptocurrencyBasicInfoData] {
        let descriptor = FetchDescriptor<CryptocurrencyBasicInfoData>()
        
        guard let cryptos = try? context.fetch(descriptor) else {
            return []
        }
        
        return cryptos
    }
    
    func insert(_ cryptoList: [CryptocurrencyBasicInfoData]) async {
        cryptoList.forEach { crypto in
            context.insert(crypto)
        }
        
        try? context.save()
    }
}
