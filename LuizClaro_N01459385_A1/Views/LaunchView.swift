//
//  LaunchView.swift
//  LuizClaro_N01459385_A1
//
//  Created by Luiz Fernando Reis on 2022-03-07.
//

import SwiftUI

struct LaunchView: View {
    let sf = ScaleFactor()
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @State private var isCounting: Bool = false
    @Binding var showLaunch: Bool
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            Image("assign01logo")
                .resizable()
                .scaledToFit()
                .scaleEffect(isCounting ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 2), value: isCounting)
                .onAppear {
                    isCounting.toggle()
                }
                .position(x: sf.w * 0.5, y: sf.h * 0.4)
            
        }.onReceive(timer , perform: { _ in
            withAnimation(.default){
                let lastIndex = 10
                if counter == lastIndex{
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunch = false
                    }
                }else{
                    counter += 1
                }
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunch: .constant(true))
    }
}
