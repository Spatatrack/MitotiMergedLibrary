//
//  PopUpView.swift
//  WASAPP
//
//  Created by Simone Pistecchia on 28/06/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import SwiftUI

public struct PopUpView: View {
    
    public var title: String
    public var message: String
    public var imageSystemName: String
    public var boxColor: Color
    public var boxOpacity: Double
    public var sxButtonTitle: String
    public var dxButtonTitle: String
    public var onSxClicked: () -> Void
    public var onDxClicked: () -> Void
    
    //altrimenti non la riconosce public
    public init(title: String, message: String, imageSystemName: String, boxColor: Color
                ,boxOpacity: Double
                ,sxButtonTitle: String
                ,dxButtonTitle: String
                ,onSxClicked: @escaping () -> Void
                ,onDxClicked: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.imageSystemName = imageSystemName
        self.boxColor = boxColor
        self.boxOpacity = boxOpacity
        self.sxButtonTitle = sxButtonTitle
        self.dxButtonTitle = dxButtonTitle
        self.onSxClicked = onSxClicked
        self.onDxClicked = onDxClicked
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center) {
                Spacer()
                    .frame(width: 0, height: 120)
                                
                Image(systemName: self.imageSystemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .modifier(fillButtonCircle(foregroundColor: .white, backgroundColor: .blue, dimension: 11))
                    .offset(x: 0, y: 38)
                    .zIndex(1)
                VStack {
                    Text(self.title)
                        .font(.largeTitle)
                        .padding()
                    Text(self.message)
                        .font(.body)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .background(Rectangle().foregroundColor(self.boxColor).cornerRadius(15).opacity(self.boxOpacity))
                .padding()
                .shadow(radius: 30)
                
                HStack {
                    Button(action: self.onSxClicked){
                        Text(self.sxButtonTitle)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                    Divider()
                    Button(action: self.onDxClicked){
                        Text(self.dxButtonTitle)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                }
                .frame(maxWidth: geometry.size.width * 0.90, maxHeight: 60)
                .background(Rectangle().foregroundColor(self.boxColor).cornerRadius(15).opacity(self.boxOpacity))
                .shadow(radius: 30)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
}


//struct PopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Rectangle()
//                //.frame(width: 400, height: 900)
//                .foregroundColor(.green)
//            PopUpView(title: "title", message: "message\nmm\nkk", imageSystemName: "book", boxColor: .white, boxOpacity: 0.8, sxButtonTitle: "sx button", dxButtonTitle: "dx button", onSxClicked: {}, onDxClicked: {})
//        }
//    }
//}
///usato ad esempio per Istruzioni per come fare l'export etc pagina per pagina
public struct PopUpImageView: View {
    
    public var message: String
    public var imageName: String
    public var imageSystemIconName: String
    public var boxColor: Color
    public var boxOpacity: Double
    public var buttonTitle: String
    public var onClicked: () -> Void
    
    //altrimenti non la riconosce public
    public init(message: String, imageName: String, imageSystemIconName: String
                ,boxColor: Color
                ,boxOpacity: Double
                ,buttonTitle: String
                ,onClicked: @escaping () -> Void
                ) {
        self.message =  message
        self.imageName = imageName
        self.imageSystemIconName = imageSystemIconName
        self.boxColor = boxColor
        self.boxOpacity = boxOpacity
        self.buttonTitle = buttonTitle
        self.onClicked = onClicked
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .bottom) {
                ZStack (alignment: .top) {
                    VStack (spacing: 0){
                        Image(systemName: self.imageSystemIconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .modifier(fillButtonCircle(foregroundColor: .white, backgroundColor: .blue, dimension: 11))
                            .offset(x: 0, y: -5)
                            .zIndex(3)
                        Text(self.message)
                            .font(.body)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                                .padding()
                            .background(Rectangle().foregroundColor(self.boxColor).cornerRadius(15).opacity(self.boxOpacity))
                            .offset(x: 0, y: -20)
                            .zIndex(2)
                            .shadow(radius: 30)
                        Image(self.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.frame(maxWidth: geometry.size.width * 0.90, maxHeight: geometry.size.height * 0.60)
                            .zIndex(1)
                            .offset(x: 0, y: -40)
                            
                    }
                    .zIndex(1)
                    Rectangle()
                        .foregroundColor(.clear)
                    
                }
                Button(action: self.onClicked){
                    Text(self.buttonTitle)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                .frame(maxWidth: geometry.size.width * 0.90, maxHeight: 60)
                .background(Rectangle().foregroundColor(self.boxColor).cornerRadius(15).opacity(self.boxOpacity))
                .shadow(radius: 30)
                .padding()
                
            }
            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
        }
    }
}

//struct PopUpImageView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        PopUpImageView(message: "swipe left and click export", imageName: "spazio", imageSystemIconName: "book", boxColor: .white, boxOpacity: 0.8, buttonTitle: "next", onClicked: {})
//
//    }
//}
