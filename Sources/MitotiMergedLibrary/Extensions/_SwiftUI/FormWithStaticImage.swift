//
//  FormWithImage.swift
//  Nonno Lotto
//
//  Created by Simone Pistecchia on 18/02/21.
//

import SwiftUI


///FormWithImageView(image: $imagePicked) {
///ButtonRowView(text: "prova", imageSystemName: "square.and.pencil", imageColor: .blue, action: {})
    ///.padding()
///}
public struct FormWithStaticImage<Content: View>: View {
    
    public var imageName: String = ""

    private var content: () -> Content
    
    public init(imageName: String, @ViewBuilder content: @escaping () -> Content) {
        self.imageName = imageName
        self.content = content
    }
    
    public var body: some View {
        VStack {
            
            Image(imageName)// ?? UIImage(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .clipped()
                .contentShape(Rectangle())//per far cliccare anche al centro
            self.content()
        }       
    }
    
}
