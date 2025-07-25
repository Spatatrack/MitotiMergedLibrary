//
//  SwiftUIView.swift
//  
//
//  Created by Simone Pistecchia on 04/12/2020.
//

import SwiftUI

@available(iOS 13.0, *)
public struct ButtonStrangeEffect: GeometryEffect {

    var offset: Double // 0...1

    public var animatableData: Double {
        get { offset }
        set { offset = newValue }
    }

    
    public func effectValue(size: CGSize) -> ProjectionTransform {

        let effectValue = abs(sin(offset*Double.pi))
        let scaleFactor = 1+0.2*effectValue

        let affineTransform = CGAffineTransform(rotationAngle: CGFloat(effectValue)).translatedBy(x: -size.width/2, y: -size.height/2).scaledBy(x: CGFloat(scaleFactor), y: CGFloat(scaleFactor))

        return ProjectionTransform(affineTransform)
    }
}

@available(iOS 13.0, *)
public struct ViewScaleEffect: GeometryEffect {
    
    var offset: Double // 0...1

    public var animatableData: Double {
        get { offset }
        set { offset = newValue }
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        let reducedValue = offset - floor(offset)
        let value = 1.0-(cos(2*reducedValue*Double.pi)+1)/2

        let scaleFactor  = CGFloat(1+1*value)

        let affineTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

        return ProjectionTransform(affineTransform)
    }
}

@available(iOS 13.0, *)
/// perc positivo aumenta dimensione, negativo diminuisce
public struct ScaleButtonStyle: ButtonStyle {
    public init(percentValue: CGFloat) {
        self.percentValue = percentValue
    }
    public var percentValue: CGFloat = -0.03
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .compositingGroup()
            //.shadow(color: .black, radius: 0.5)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 1.0 + percentValue : 1.0)
    }
}
/**
 Larghezza tutto schermo con padding
 Button("MyOK") {
     print("button pressed!")
 }
 .buttonStyle(RoundedScaleButton(color: .blue))

 */
@available(iOS 13.0, *)
public struct RoundedScaleButton: ButtonStyle {
    public init (color: Color) {
        self.color = color
    }
    public var color: Color = .blue
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        
            configuration.label
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 35, alignment: .center)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 35/2.0).fill(self.color))
                .compositingGroup()
                //.shadow(color: .black, radius: 1)
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .contentShape(Rectangle())
                
    }
}
@available(iOS 13.0, *)
public struct MyPrimitiveButtonStyle: PrimitiveButtonStyle {
    public var color: Color

    public func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
    
    public struct MyButton: View {
        @GestureState private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color

        public var body: some View {
            let longPress = LongPressGesture(minimumDuration: 1.0, maximumDistance: 0.0)
                .updating($pressed) { value, state, _ in state = value }
                .onEnded { _ in
                   self.configuration.trigger()
                 }

            return configuration.label
                .foregroundColor(.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(pressed ? 0.5 : 1.0)
                .scaleEffect(pressed ? 0.8 : 1.0)
                .gesture(longPress)
        }
    }
}
@available(iOS 13.0, *)
public struct fillButtonCircle: ViewModifier {
    public var foregroundColor: Color = .white
    public var backgroundColor: Color = .green
    public var dimension: CGFloat = 10
    public func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .padding(dimension)
            .background(backgroundColor)
            .clipShape(Circle())
    }
}
@available(iOS 13.0, *)
public struct fillButtonSquare: ViewModifier {
    public init(foregroundColor: Color = .white, backgroundColor: Color = .green, dimension: CGFloat = 8) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.dimension = dimension
    }
    public var foregroundColor: Color = .white
    public var backgroundColor: Color = .green
    public var dimension: CGFloat = 8
    public func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .padding(dimension)
            .background(backgroundColor)
            .clipShape(Rectangle())
            .cornerRadius(dimension/2)
            
    }
}
///es Image(systemName: "square.and.pencil")
///  .modifier(fillButtonCircle(foregroundColor: .white, backgroundColor: .blue))
@available(iOS 13.0, *)
public struct fillButtonCircleWide: ViewModifier {
    public var foregroundColor: Color = .white
    public var backgroundColor: Color = .green
    public var dimension: CGFloat = 10
    
    public func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .padding(EdgeInsets(top: dimension, leading: dimension + dimension/2, bottom: dimension, trailing: dimension + dimension/2))
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

///ALTRI ESEMPI CHE ORA NON USO
@available(iOS 13.0, *)
public struct MyButtonStyleConViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.largeTitle)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        VStack(spacing: 20) {
            Button("ScaleButtonStyle") {}
                .buttonStyle(ScaleButtonStyle(percentValue: 0.2))
            Button("RoundedScaleButton") {}
                .buttonStyle(RoundedScaleButton(color: .blue))
            Button("MyPrimitiveButtonStyle") {}
                .buttonStyle(MyPrimitiveButtonStyle(color: .purple))
            HStack(spacing: 16) {
                Image(systemName: "star.fill")
                    .modifier(fillButtonCircle(foregroundColor: .white, backgroundColor: .orange, dimension: 12))
                Image(systemName: "star.fill")
                    .modifier(fillButtonSquare(foregroundColor: .white, backgroundColor: .green, dimension: 12))
                Image(systemName: "star.fill")
                    .modifier(fillButtonCircleWide(foregroundColor: .white, backgroundColor: .blue, dimension: 10))
            }
            Text("MyButtonStyleConViewModifier")
                .modifier(MyButtonStyleConViewModifier())
            // Esempio animazione ButtonStrangeEffect
            Button("Animato") {}
                .modifier(ButtonStrangeEffect(offset: 0.5))
            // Esempio animazione ViewScaleEffect
            Button("ViewScaleEffect") {}
                .modifier(ViewScaleEffect(offset: 0.5))
        }
        .padding()
        .background(.gray.opacity(0.2))
    } else {
        // Fallback on earlier versions
    }
}
