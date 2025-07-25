//
//  SwiftUIView.swift
//  
//
//  Created by Simone Pistecchia on 18/03/21.
//

import SwiftUI


//PER IOS 15 USARE QUESTO!!! 10/12/2021
/**
 Text("££").fullBackground(imageName:"pippo")
 */
public extension View {
    func fullBackground(imageName: String, blurred: Bool = false) -> some View {
       return background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: blurred ? 4:0)
       )
    }
    func fullBackground(imageName: String, blurred: CGFloat) -> some View {
       return background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: blurred)
       )
    }
}
 
/**
 BackgroundView(imageName: BackroundImages.appNero.getString()) {
     VStack {
         Text("MitotiM")
             .font(.largeTitle)
             .bold()
         MitotiMView(textColor: .black)
         Spacer()
         UnsplashCredits(people:"Rami Al-zayat, ") //jeshoots-com-unsplash   mitotimBG
     }
     
 }
 */
public struct BackgroundView <Content : View> : View {
    public var content : Content
    public var imageName: String
    public var opacity: Double
    public init(imageName: String, opacity: Double=1,@ViewBuilder content: () -> Content) {
        self.content = content()
        self.imageName = imageName
        self.opacity = opacity
    }
    
    public var body: some View {
        //GeometryReader { geo in
            ZStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    //.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .opacity(opacity)
                content
            }
        //}
    }
}

/* es string
 enum BackroundImages: Int, CaseIterable, Hashable, Codable {
     case dipintoFiori = 0
     case calendario
     case cloudShining
     case pc
     case appNero
     
     
     func getString() -> String {
         return BackroundImages.getString(rawValue: self.rawValue)
     }
     
     static func getString(rawValue: Int) -> String {
         switch BackroundImages(rawValue: rawValue) {
         case .dipintoFiori:
             return "mona-eendra-unsplash"
         case .calendario:
             return "maddi-bazzocco"
         case .cloudShining:
             return "romello-williams-unsplash"
         case .pc:
             return "jeshoots-com"
         case .appNero:
             return "Rami-Al-zayat"
         case .none:
             return "mona-eendra-unsplash"
         }
     }
 }
 */
