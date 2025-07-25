//
//  MyAlertButtonView.swift
//  WASP
//
//  Created by Simone Pistecchia on 13/06/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import SwiftUI

public struct MyAlertOneButtonView<Presenting>: View where Presenting: View {

    /// The binding that decides the appropriate drawing in the body.
    @Binding public var isShowing: Bool
    /// The view that will be "presenting" this toast
    public let presenting: () -> Presenting
    
    public var message: String
    public var onAcceptClicked: () -> Void
    
    public var body: some View {
        GeometryReader { geometry in
            self.presenting()
                .blur(radius: self.isShowing ? 4 : 0)
                .disabled(self.isShowing)
            
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Spacer()
                        .frame(width: 0, height: 120)
                    
                    VStack (alignment: .center, spacing: 2){
                        Image(systemName: "person.2.square.stack.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 60)
                            .modifier(fillButtonCircle(foregroundColor: .white, backgroundColor: .blue, dimension: 15))
                            .offset(x: 0, y: 35)
                            .zIndex(1)
                        Text(self.message)
                            .font(.system(size: 21))
                            .padding()
                            .background(Rectangle().foregroundColor(.white).cornerRadius(15).opacity(1))
                            .padding()
                            .shadow(radius: 8)
                        HStack {
                            Button(action: self.accept){
                                Text(NSLocalizedString("Go to settings", comment: "per autorizzazione vai a settings"))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                        }
                        .frame(maxWidth: geometry.size.width * 0.90, maxHeight: 60)
                        .background(Rectangle().foregroundColor(.white).cornerRadius(15).opacity(1))
                        .shadow(radius: 8)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .contentShape(Rectangle())//per far cliccare anche al centro
            //.offset(x: 0, y: -60)
            .opacity(self.isShowing ? 1 : 0)
            .onTapGesture {
                self.isShowing.toggle()
            }
        }
        
    }
    
    public func accept() {
        onAcceptClicked()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            self.isShowing.toggle()
        })
        
    }
}

public extension View {
    ///.toast(isShowing: $showToast, text: Text("Hello toast!"))
    func myAlertOneButtonView(isShowing: Binding<Bool>, message: String, onAcceptClicked: @escaping () -> Void) -> some View {
        MyAlertOneButtonView(isShowing: isShowing,
                                    presenting: { self }, message: message, onAcceptClicked: onAcceptClicked)
    }
}
