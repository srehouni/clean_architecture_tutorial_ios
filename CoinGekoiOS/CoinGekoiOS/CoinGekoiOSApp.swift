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
            GlobalCryptoListFactory.create()
        }
    }
}
