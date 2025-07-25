//
//  AlertLoaderView.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 05/12/2020.
//

import Foundation
import SwiftUI


@available(iOS 14.0, *)
struct AlertLoaderView<Presenting>: View where Presenting: View {
    
    @Binding var isShowing: Bool
    @Binding var isLoading: Bool
    
    var title: String
    var message: String
   
    let presenting: () -> Presenting
    
    var body: some View {
        GeometryReader { geometry in
            self.presenting()
                .blur(radius: self.isShowing ? 4 : 0)
                .disabled(self.isShowing)
            
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Spacer()
                    VStack {
                        
                        Text(title)
                            .fontWeight(.bold)
                            .padding()
                        if message != "" {
                            Text(message)
                                .padding(3)
                        }
                        
                        if isLoading {
                            ProgressView()
                        }
                        Spacer()
                        Divider()
                            .offset(x: 0, y: 10)
                        Button(action: {
                                isShowing.toggle()
                        }){
                            Text("cancel")
                            
                        }
                        .frame(height:50)
                    }
                    .frame(maxWidth: geometry.size.width * 0.70, maxHeight: 180)
                    .background(Rectangle().foregroundColor(.white).cornerRadius(15).opacity(1).shadow(radius: 8))                    
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
}

@available(iOS 14.0, *)
public extension View {
    func alertLoaderView(isShowing: Binding<Bool>, isLoading:Binding<Bool>, title:String, message: String) -> some View {
        AlertLoaderView(isShowing: isShowing, isLoading:isLoading, title:title, message: message, presenting: {self})
           
    }
}

@available(iOS 14.0, *)
struct AlertTestView: View {
            
    @State var isShowing: Bool = false
    
    var body: some View {
                          
        Button("click me") {
            isShowing.toggle()
        }
        .alertLoaderView(isShowing: .constant(true), isLoading: .constant(true), title: "title", message: "")
    }

   
}
#if DEBUG
@available(iOS 14.0, *)
struct AlertTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlertTestView()
    }
}
#endif
