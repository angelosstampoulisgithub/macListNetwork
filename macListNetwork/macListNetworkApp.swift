//
//  macListNetworkApp.swift
//  macListNetwork
//
//  Created by Angelos Staboulis on 24/6/25.
//

import SwiftUI

@main
struct macListNetworkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(listWifi: .init()).frame(width:650,height:400,alignment: .center)
        }.windowResizability(.contentSize)
    }
}
