//
//  ButtonStyle.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 31/10/2020.
//

import SwiftUI



struct BStyleView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .imageIconModifier()
            Button("MyOK") {
                print("button pressed!")
            }
            Button("MyOK") {
                print("button pressed!")
            }
            .frame(width: 150, height: 33)
            .buttonStyle(RoundedScaleButton(color: .blue))
            
            
            Button(action: {
                withAnimation() {
                    print("button pressed!")
                }
            }) {
                Text("OKww")
                
            }
            
            
            Button("Tap Me!") {
                print("button pressed!")
            }.buttonStyle(RoundedScaleButton(color: .blue))
            
            Image(systemName: "bolt.fill")
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .clipShape(Circle())
            Image(systemName: "bolt.fill")
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.green)
            .clipShape(Capsule())
        }
        .background(Color.yellow)
    }
}

struct BStyleView_Preview: PreviewProvider {
    static var previews: some View {
        BStyleView()
    }
}


@available(iOS 13.0, *)
struct ButtonStrangeEffect: GeometryEffect {

    var offset: Double // 0...1

    var animatableData: Double {
        get { offset }
        set { offset = newValue }
    }

    
    func effectValue(size: CGSize) -> ProjectionTransform {

        let effectValue = abs(sin(offset*Double.pi))
        let scaleFactor = 1+0.2*effectValue

        let affineTransform = CGAffineTransform(rotationAngle: CGFloat(effectValue)).translatedBy(x: -size.width/2, y: -size.height/2).scaledBy(x: CGFloat(scaleFactor), y: CGFloat(scaleFactor))

        return ProjectionTransform(affineTransform)
    }
}

@available(iOS 13.0, *)
struct ViewScaleEffect: GeometryEffect {
    
    var offset: Double // 0...1

    var animatableData: Double {
        get { offset }
        set { offset = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let reducedValue = offset - floor(offset)
        let value = 1.0-(cos(2*reducedValue*Double.pi)+1)/2

        let scaleFactor  = CGFloat(1+1*value)

        let affineTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

        return ProjectionTransform(affineTransform)
    }
}

@available(iOS 13.0, *)
/// perc positivo aumenta dimensione, negativo diminuisce
struct ScaleButtonStyle: ButtonStyle {
    var percentValue: CGFloat = -0.03
    func makeBody(configuration: Self.Configuration) -> some View {
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
 .buttonStyle(MyButtonStyleWhatsapp(color: .blue))

 */
@available(iOS 13.0, *)
struct RoundedScaleButton: ButtonStyle {
    var color: Color = .blue
    
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
struct MyPrimitiveButtonStyle: PrimitiveButtonStyle {
    var color: Color

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
    
    struct MyButton: View {
        @GestureState private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color

        var body: some View {
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
struct fillButtonCircle: ViewModifier {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .green
    var dimension: CGFloat = 10
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .padding(dimension)
            .background(backgroundColor)
            .clipShape(Circle())
    }
}
@available(iOS 13.0, *)
struct fillButtonSquare: ViewModifier {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .green
    var dimension: CGFloat = 8
    func body(content: Content) -> some View {
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
struct fillButtonCircleWide: ViewModifier {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .green
    var dimension: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .padding(EdgeInsets(top: dimension, leading: dimension + dimension/2, bottom: dimension, trailing: dimension + dimension/2))
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

///ALTRI ESEMPI CHE ORA NON USO
@available(iOS 13.0, *)
struct MyButtonStyleConViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.largeTitle)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
}
