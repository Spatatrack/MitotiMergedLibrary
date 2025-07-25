//
//  SwiftUIView.swift
//  
//
//  Created by Simone Pistecchia on 04/12/2020.
//

import SwiftUI


@available(iOS 13.0, *)
public extension Image {
    func imageIconModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
    
    func imageIconModifierBig() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            //.overlay(Circle().stroke(Color.black, lineWidth: 1))
    }
    func imageIconModifierSystem() -> some View {
        self
            .resizable()
            .scaleEffect(1)
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
    func imageIconModifierSystemBig() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
    }
    /*
    func normalSize() -> some View {
        self
        .frame(width: 40, height: 40)
    }
    func mediumSize() -> some View {
        self
        .frame(width: 60, height: 60)
    }*/
}

// 4-12-2020
@available(iOS 13.0, *)
public extension Image {
    ///mette immagine in un box così anche se le immagini hanno grandezze diverse, vengono adattate
    func fixedBox(height: CGFloat, cornerRadius: CGFloat, shadowColor: Color) -> some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(.clear)
            .overlay(
                self
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .clipShape(Rectangle())
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: 12, x: 5, y: 5)
    }
    func fixedBoxFit(width: CGFloat, height: CGFloat, cornerRadius: CGFloat, shadowColor: Color) -> some View {
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor(.clear)
            .overlay(
                self
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
            .clipShape(Rectangle())
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: 12, x: 5, y: 5)
    }
}

// 14-02-2021
@available(iOS 13.0, *)
public extension Image {
    ///ritorna l'immagine da data png se vuoto ritorna immagine vuota
    init(data: Data?) {
        guard let data = data else {
            self =  Image(uiImage: UIImage())
            return
        }
        let uiimage = UIImage(data: data) ?? UIImage()
        self =  Image(uiImage: uiimage)
    }
}
