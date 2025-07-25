//
//  ToggleStyle.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 13/11/2020.
//

import Foundation
import SwiftUI

struct ToggleSystemImageStyle: ToggleStyle {
    
    var imageOn: String = "checkmark.circle.fill"
    var imageOff: String = "circle"
    
    var buttonColorOn: Color = .green
    var buttonColorOff: Color = .gray
    
    var backgroundColorOn: Color = .blue
    var backgroundColorOff: Color = Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.2)
//
    //
//    func makeBody(configuration: Configuration) -> some View {
//        GeometryReader { dim in
//            HStack {
//                configuration.label
//                Spacer()
//                Rectangle()
//                    .foregroundColor(configuration.isOn ? backgroundColorOn:backgroundColorOff)
//                    //.frame(width: 250, height: 50, alignment: .center)
//                    .overlay(
//                        Circle()
//                            .foregroundColor(.white)
//                            .padding(.all, 3)
//                            .overlay(
//                                Image(systemName: configuration.isOn ? imageOn:imageOff)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .font(Font.title.weight(.black))
//                                    //.frame(width: 25, height: 25, alignment: .center)
//                                    .foregroundColor(configuration.isOn ? buttonColorOn:buttonColorOff)
//                            )
//                            .offset(x: configuration.isOn ? dim.size.width/3.3:-dim.size.width/3.3, y: 0)
//                            .animation(.linear(duration:0.1))
//                    )
//                    .cornerRadius(dim.size.height/2)
//                    .onTapGesture {
//                        configuration.isOn.toggle()
//                    }
//            }
//        }
//    }
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { dim in
            HStack {
                configuration.label
                Spacer()
                ZStack (alignment: Alignment(horizontal: configuration.isOn ?.trailing:.leading, vertical: .center)){
                    Rectangle()
                        .foregroundColor(configuration.isOn ? backgroundColorOn:backgroundColorOff)
                        .cornerRadius(dim.size.height/2)
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? imageOn:imageOff)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .foregroundColor(configuration.isOn ? buttonColorOn:buttonColorOff)
                                .padding(8)
                        )
                        .frame(width: dim.size.height, height: dim.size.height, alignment: .center)
                        .animation(.linear(duration:0.1))
                }
            }
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
    }
}

@available(iOS 14.0, *)
struct ToggleTestView: View {
    
    @State var isOn: Bool = true
    
    var body: some View {
        VStack {
            
            Toggle(isOn: $isOn, label: {
                Text("Label")
            })
            .toggleStyle(ToggleSystemImageStyle())
            .frame(width: 350, height: 50, alignment: .center)
            
            Toggle(isOn: $isOn, label: {
                Text("Label")
            })
            .toggleStyle(ToggleSystemImageStyle())
            .frame(width: 250, height: 50, alignment: .center)
            
            Toggle(isOn: $isOn, label: {
                Text("Label mui lungoooooojjjkk")
            })
            .toggleStyle(ToggleSystemImageStyle())
            .frame(width: 250, height: 50, alignment: .center)
            
            Toggle(isOn: $isOn, label: {
                Text("Label")
            })
            .toggleStyle(SwitchToggleStyle(tint: .orange))
            .frame(width: 250, height: 100, alignment: .center)
            
            Toggle(isOn: $isOn, label: {
                Text("Label mui lungoooooojjjkk")
            })
            .toggleStyle(ToggleSystemImageStyle())
            .frame(width: 250, height: 100, alignment: .center)
            
            
        
            
            Toggle(isOn: $isOn, label: {
                Rectangle()
                    .frame(width: 100, height: 50, alignment: .center)
            })
            .toggleStyle(ToggleSystemImageStyle(imageOn: "bell.fill", imageOff: "bell.slash.fill", buttonColorOn: .black, buttonColorOff: .gray, backgroundColorOn: .red, backgroundColorOff: .gray))
            //.toggleStyle(SwitchToggleStyle(tint: Color(AppSetting.rosaAcceso)))
            .frame(width: 245,height: 40, alignment: .center)
        }
    }
}

@available(iOS 14.0, *)
struct ToggleTestView_Preview: PreviewProvider {
    static var previews: some View {
        ToggleTestView()
    }
}
