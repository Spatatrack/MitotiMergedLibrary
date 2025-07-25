//
//  UnsplashCredits.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 31/12/20.
//

import SwiftUI

public struct UnsplashCredits: View {
    public init (people: String = "Hutomo Abrianto, Element Digital, Anant Jain, Roland Losslein, Imani, Sean 0") {
        self.people = people
    }
    public var people: String 
    public var body: some View {
        Text(NSLocalizedString("Photos by", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
            .offset(x: 0, y: 12)
            .foregroundColor(.gray)
        Divider()
        Text("Unsplash: \(people)")
            .font(.caption)
            .foregroundColor(.gray)
    }
}

struct UnsplashCredits_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashCredits()
    }
}
