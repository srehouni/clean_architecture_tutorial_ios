//
//  CoinGekoiOSApp.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import SwiftUI

@main
struct CoinGekoiOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(globalCryptoList: GlobalCryptoListFactory.create(),
                        cryptoListView: CryptoListFactory.create())
        }
    }
}
