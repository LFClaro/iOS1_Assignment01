//
//  LuizClaro_N01459385_A1App.swift
//  LuizClaro_N01459385_A1
//
//  Created by Luiz Fernando Reis on 2022-03-07.
//

import SwiftUI

@main
struct LuizClaro_N01459385_A1App: App {
    @State private var showLaunchScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    if showLaunchScreen {
                        LaunchView(showLaunch: $showLaunchScreen)
                            .navigationBarHidden(true)
                            .transition(.move(edge: .leading))
                    } else {
                        WalkthroughView()
                    }
                }
            }
            .preferredColorScheme(.light)
        }
    }
}
