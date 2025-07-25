//
//  SwiftUIView.swift
//  
//
//  Created by Simone Pistecchia on 14/02/21.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct MyTextFieldStyle: TextFieldStyle {
    public init(focused: Bool) {
        self.focused = focused
    }
    public var focused: Bool
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .stroke(focused ? Color.red : Color.gray, lineWidth: 1)
        )
    }
}

