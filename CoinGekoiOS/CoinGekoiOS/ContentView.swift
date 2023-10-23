//
//  ContentView.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import SwiftUI

struct ContentView: View {
    let globalCryptoList: GlobalCryptoListView
    let cryptoListView: CryptoListView
    
    var body: some View {
        TabView {
            globalCryptoList.tabItem {
                Label("Global", systemImage: "list.dash")
            }
            cryptoListView.tabItem {
                Label("CryptoList", systemImage: "list.dash")
            }
        }
    }
}
