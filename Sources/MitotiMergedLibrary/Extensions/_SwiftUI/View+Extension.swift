//
//  View+Extansion.swift
//  WAR
//
//  Created by Simone Pistecchia on 23/01/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
    
   
}
@available(iOS 13.0, *)
extension View {
    ///Text("Hello World").addBorder(Color.blue, width: 3, cornerRadius: 5)
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
    // Apply trueModifier if condition is met, or falseModifier if not.
   public func conditionalModifier<M1, M2>(_ condition: Bool, _ trueModifier: M1, _ falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
       Group {
           if condition {
               self.modifier(trueModifier)
           } else {
               self.modifier(falseModifier)
           }
       }
   }
}
@available(iOS 13.0, *)
extension View {
    ///.toast(isShowing: $showToast, text: Text("Hello toast!"))
    func toast(isShowing: Binding<Bool>, view: AnyView) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              view: view)
    }
    func myPopup(isShowing: Binding<Bool>, size:CGSize, view: AnyView) -> some View {
        MyPOPUP(isShowing: isShowing,
              presenting: { self },
              size: size, view: view)
    }
}
@available(iOS 13.0, *)
struct Toast<Presenting>: View where Presenting: View {

    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    /// The text to show
    let view: AnyView

    var body: some View {

        GeometryReader { geometry in

            ZStack(alignment: .center) {

                self.presenting()
                    .blur(radius: self.isShowing ? 2 : 0)
                    .disabled(self.isShowing)

                VStack {
                    self.view
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.clear)
                .foregroundColor(Color.clear)
                .cornerRadius(20)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
                .onTapGesture {
                    self.isShowing.toggle()
                }
            }

        }

    }

}
@available(iOS 13.0, *)
struct MyPOPUP<Presenting>: View where Presenting: View {

    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    
    let size: CGSize
    
    /// The text to show
    let view: AnyView

    var body: some View {

        GeometryReader { geometry in

            self.presenting()
                .blur(radius: self.isShowing ? 2 : 0)
                .disabled(self.isShowing)
            
            ZStack(alignment: .center) {
                
                //VStack {
                    
                    Rectangle()
                        .frame(width: self.size.width,
                               height: self.size.height)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        self.view
                    )
                //}
            
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
            .background(Color.secondary.colorInvert())
            .transition(.slide)
            .opacity(self.isShowing ? 1 : 0)
            .onTapGesture {
                self.isShowing.toggle()
            }
        }

    }

}
@available(iOS 13.0, *)
extension View {

    /**
     .textFieldAlert(isShowing: self.$showingChangeChatName, text: self.$chatNameTextInput, title: NSLocalizedString("Chat name", comment: ""), grayText: self.chatNameTextInput, onReturnPressed: {
                if let chat = self.myChat {
                    self.userData.overrideChatName(chat: chat, newName: self.chatNameTextInput)
                }
            })
     */
    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String, grayText: String, onReturnPressed: @escaping () -> Void) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: { self },
                       title: title, grayText: grayText, onReturnPressed: onReturnPressed)
    }

}
@available(iOS 13.0, *)
struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: () -> Presenting
    let title: String
    var grayText:String
    
    let onReturnPressed: () -> Void
    
    func returnFunction() {//quando l'utenti schiaccia ok o invio}
        self.isShowing = false
        self.onReturnPressed()
    }
    
    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                
                    //.edgesIgnoringSafeArea(.all)
                if self.isShowing {
                    self.presenting()
                    .blur(radius: 3).offset(y:1)
                    .disabled(self.isShowing)
                }
                else {
                    self.presenting()
                    .disabled(self.isShowing)
                }
                    //.offset(y: 50)
                //ZStack {
                    VStack {
                        Spacer()
                        .frame(height: 8)
                        Text(self.title)
                        Divider()
                        TextField(self.grayText, text: self.$text, onCommit: {
                            self.returnFunction()
                        })
                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                        //.shadow(radius: CGFloat(1.0))
                        Divider()
                        Spacer()
                        .frame(height: 10)
                        HStack {
                            Button(action: {
                                withAnimation {
                                    self.returnFunction()
                                }
                            }) {
                                Text("OK")
                                
                                 .frame(width: 150, height: 30)
                                 .background(Color.white)
                                 //.foregroundColor(.white)
                                 .cornerRadius(15)
                                 
                            }
                            //.frame(width: deviceSize.size.width*0.4)
                            //.buttonStyle(MyButtonStyleWhatsapp())
                        }
                       
                        
                    }
                    .padding()
                    .background(Color.white)
                    //.addBorder(Color.blue, width: 3, cornerRadius: 15)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(
                        width: 250,//deviceSize.size.width*0.6,
                        height: 220//deviceSize.size.height*0.6
                    )
                    .offset(y: -100)
                    .shadow(radius: 20)
                    .opacity(self.isShowing ? 1 : 0)
                    //.keyboardResponsive()
                
                    ZStack {
                        Circle().frame(width: 40, height: 40)
                        .foregroundColor(Color.white)
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .foregroundColor(Color.blue)
                             
                    }
                    .offset(x:0, y: -220/3 - 110)//-deviceSize.size.height*0.6/6 - 110)
                    .opacity(self.isShowing ? 1 : 0)
                    //.keyboardResponsive()
                }
                //.keyboardResponsive()
            //}
            
            //
        }
        
    }

}
/*
extension View {

    /// Presents a sheet.
    ///
    /// - Parameters:
    ///     - isPresented: A `Binding` to whether the sheet is presented.
    ///     - onDismiss: A closure executed when the sheet dismisses.
    ///     - content: A closure returning the content of the sheet.
    public func myPopup<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        
        return EmptyView()
    }
}*/

import SwiftUI

//SERVE PER FAR ANDARE SU LO SCHERMO SE é COPERTO DALLA KEYBOARD
//@available(iOS 13.0, *)
//struct KeyboardResponsiveModifier: ViewModifier {
//  @State private var offset: CGFloat = 0
//
//  func body(content: Content) -> some View {
//    content
//      .padding(.bottom, offset)
//      .onAppear {
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
//          let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//          let height = value.height
//          let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
//          self.offset = height - (bottomInset ?? 0)
//        }
//
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
//          self.offset = 0
//        }
//    }
//  }
//}
//
//@available(iOS 13.0, *)
//extension View {
//  func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
//    return modifier(KeyboardResponsiveModifier())
//  }
//}



//ANIMAZIONE PIU SEMPLICE
@available(iOS 13.0, *)
public extension View {
    func animate(using animation: Animation = Animation.easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}
@available(iOS 13.0, *)
public extension View {
    func animateForever(using animation: Animation = Animation.easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)

        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}


@available(iOS 13.0, *)
public extension View {
    ///mette immagine in un box così anche se le immagini hanno grandezze diverse, vengono adattate
    func fixedBox(height: CGFloat, cornerRadius: CGFloat, shadowColor: Color) -> some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(.clear)
            .overlay(
                self
            )
            .clipShape(Rectangle())
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: 12, x: 5, y: 5)
    }
    func fixedBox(width: CGFloat, height: CGFloat, cornerRadius: CGFloat, shadowColor: Color) -> some View {
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor(.clear)
            .overlay(
                self                   
            )
            .clipShape(Rectangle())
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: 12, x: 5, y: 5)
    }
}

//16-02-2021
@available(iOS 13.0, *)
/// es ProgressView().isHidden(isHidden)
public extension View {
    ///Nascondi ma mantiene le dimensioni
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
    ///nascondi e ritorna frame a 0
    @ViewBuilder func isHiddenTotal(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
                .frame(width: 0, height: 0, alignment: .center)
        } else {
            self
        }
    }
}

/// 18-01-2022
/// Usato per fare qualcosa sulla fine di una animazione
public extension View {

    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}
