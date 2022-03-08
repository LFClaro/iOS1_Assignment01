//
//  LoginView.swift
//  LuizClaro_N01459385_A1
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>
    let type: String
    
    // 1 - Textfield placeholder animation
    @State var enterText: Bool = false

    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : .blue)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.75, anchor: .leading)
            if type.lowercased() == "password" {
                SecureField("", text: text)
            } else {
                TextField("", text: text)
            }
        }
        .padding(.top, 15)
        .padding(.horizontal)
        .animation(.spring(response: 0.4, dampingFraction: 0.3))
    }
}

struct LoginView: View {
    let sf = ScaleFactor()
    let labels = ["Username", "Password"]
    @State private var values = Array(repeating: "", count: 5)
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // 2 - Show Background and back button
    @State private var isBGShowing: Bool = false
    
    // 3 - Button animation
    @State var buttonAnimate: Bool = false
    
    var btnBack : some View {
        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
            HStack {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .opacity(isBGShowing ? 1 : 0)
                    .rotationEffect(.degrees(isBGShowing ? 0 : 90))
                    .animation(.spring().delay(0.8), value: isBGShowing)
            }
        }
    }
    
    var body: some View {
        ZStack{
            Image("loginBg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(isBGShowing ? 1 : 0)
                .animation(.default.delay(0.5), value: isBGShowing)
            
            // 4 - Airplane Animation
            Image("airplane").resizable().scaledToFit()
                .frame(maxWidth: sf.w * 0.3)
                .rotationEffect(.degrees(isBGShowing ? 0 : 45))
                .position(x: isBGShowing ? sf.w * 1.2 : sf.w * -0.5, y: isBGShowing ? sf.h * 0.05 : sf.h * 0.5)
                .animation(.easeInOut.delay(0.5).speed(0.15).repeatForever(autoreverses: false), value: isBGShowing)
            
            VStack(spacing: 0){
                Image("yourDestiny").resizable().scaledToFit().padding(.horizontal).opacity(isBGShowing ? 1 : 0)
                    .animation(.default.delay(0.5), value: isBGShowing)
                Image("awaits").resizable().scaledToFit().padding(.horizontal).offset(y: sf.h * -0.05)
                    .opacity(isBGShowing ? 1 : 0)
                    .animation(.default.delay(0.5), value: isBGShowing)
                    .scaleEffect(isBGShowing ? 1.2 : 1)
                    .animation(.easeInOut.delay(1.5).repeatForever(), value: isBGShowing)
                
                ForEach(labels.indices, id:\.self) { index in
                    FloatingTextField(title: self.labels[index], text: self.$values[index], type: self.labels[index])
                        .frame(maxHeight: sf.h * 0.08)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .opacity(0.9)
                        .padding()
                        .position(x: isBGShowing ? sf.w * 0.5 : sf.w * 2)
                        .animation(.spring().delay(0.3 * Double(index+1)), value: isBGShowing)
                }
                
                Text("Login")
                    .frame(maxWidth: sf.w * 0.5, maxHeight: sf.h * 0.06)
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(Font.largeTitle)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaleEffect(buttonAnimate ? 1 : 0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.3).delay(2), value: buttonAnimate)
                
                Spacer().padding()
                
                ZStack{
                    // 5 - Circle animation
                    Image("circleBg").resizable().scaledToFill()
                        .position(x: sf.w * 0.5, y: isBGShowing ? sf.h * 0.23 : sf.h * 2)
                        .animation(.spring(dampingFraction: 0.8).delay(1.5), value: isBGShowing)
                    Image("car").resizable().scaledToFill()
                        .scaleEffect(buttonAnimate ? 1 : 0)
                        .animation(.spring(response: 0.4, dampingFraction: 0.3).delay(2), value: buttonAnimate)
                }.frame(maxHeight: sf.h * 0.3)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .frame(alignment: .top)
        .onAppear {
            isBGShowing.toggle()
            buttonAnimate.toggle()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
