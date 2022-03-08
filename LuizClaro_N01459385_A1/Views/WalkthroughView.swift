//
//  WalkthroughView.swift
//  LuizClaro_N01459385_A1
//
//  Created by Luiz Fernando Reis on 2022-03-07.
//

import SwiftUI

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .delay(0.3 * Double(index))
    }
}

struct WalkthroughView: View {
    let sf = ScaleFactor()
    
    let mainText: [String] = ["best", "travel", "app"]
    
    // 1 - Cursor text Animation
    @State private var writing: Bool = false
    @State private var movingCursor: Bool = false
    @State private var blinkingCursor: Bool = false
    
    // 2 - Main text Animation
    @State private var textAppear: Bool = false
    
    // 3 - "Ever" Animation
    @State private var spinning: Bool = false
    
    // 4 - Button hover Animation
    @State private var buttonAnimate: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(){
                // 5 - Background Animation
                AnimatedBackground().edgesIgnoringSafeArea(.all)
                    .blur(radius: 50)
                VStack(spacing: 0){
                    ZStack(alignment: .leading){
                        Text("Welcome to the")
                            .font(Font.largeTitle.bold())
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .mask(Rectangle().offset(x: writing ? 0 : -300))
                        Rectangle()
                            .fill(.white)
                            .opacity(blinkingCursor ? 0 : 1)
                            .frame(width: 2, height: 24)
                            .offset(x: movingCursor ? 250 : 0)
                    }
                    
                    ForEach(mainText.indices, id: \.self) { i in
                        Image(mainText[i]).resizable().scaledToFit()
                            .scaleEffect(textAppear ? 1 : 0.01)
                            .animation(.ripple(index: i).delay(0.5), value: textAppear)
                    }
                    Image("ever").resizable().scaledToFill()
                        .rotationEffect(.degrees(spinning ? 1425 : 0))
                        .scaleEffect(spinning ? 1 : 0.01)
                        .offset(y: sf.h * -0.08)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Let's Go!")
                            .frame(width: sf.w * 0.5, height: sf.h * 0.1)
                            .background(buttonAnimate ? .blue : .red)
                            .animation(.default.repeatForever().delay(1), value: buttonAnimate)
                            .foregroundColor(.white)
                            .font(Font.largeTitle.italic())
                            .clipShape(RoundedRectangle(cornerRadius: buttonAnimate ? 30 : 10))
                            .scaleEffect(buttonAnimate ? 1.2 : 1)
                            .animation(.spring().repeatForever(), value: buttonAnimate)
                            .scaleEffect(buttonAnimate ? 1 : 0)
                            .animation(.easeInOut.delay(2), value: buttonAnimate)
                    }
                    Spacer()
                }
                .frame(maxHeight: sf.h * 0.6)
                
            }.onAppear {
                // Writing Animation
                withAnimation(.easeOut(duration: 0.5)) {
                    writing = true
                    movingCursor = true
                }
                // Cursor Blinking Animation
                withAnimation(.easeInOut(duration: 0.6).repeatForever()) {
                    blinkingCursor = true
                }
                // Rest of the text animation
                withAnimation(.spring().delay(1.5)){
                    spinning = true
                }
                textAppear = true
                // Button Animation
                buttonAnimate = true
            }
        }.navigationBarHidden(true)
    }
        
}

struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color.blue, Color.red, Color.purple, Color.pink, Color.yellow, Color.green, Color.orange]
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .onReceive(timer, perform: { _ in
                withAnimation(.easeInOut(duration: 6).repeatForever()) {
                    self.start = UnitPoint(x: 4, y: 0)
                    self.end = UnitPoint(x: 0, y: 2)
                    self.start = UnitPoint(x: -4, y: 20)
                    self.start = UnitPoint(x: 4, y: 0)
                }
            })
    }
}

struct WalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughView()
    }
}
