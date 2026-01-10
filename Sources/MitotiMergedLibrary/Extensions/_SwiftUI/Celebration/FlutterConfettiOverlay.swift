
//
//  FlutterConfettiOverlay.swift
//  YourModule
//
//  Confetti overlay (flutter-like) via CAEmitterLayer
//

import SwiftUI
import UIKit

/// Coriandoli "flutter" fluttuanti.
/// - trigger: -1 = infinito, 0 = stop, >0 = durata in secondi
public struct FlutterConfettiOverlay: UIViewRepresentable {
    public var trigger: Double
    public var quantity: Int
    public var palette: [UIColor]

    public init(
        trigger: Double,
        quantity: Int = 500,
        palette: [UIColor] = [
            .systemRed, .systemBlue, .systemGreen,
            .systemOrange, .systemPink, .systemYellow, .systemPurple
        ]
    ) {
        self.trigger = trigger
        self.quantity = quantity
        self.palette = palette
    }

    public func makeUIView(context: Context) -> FlutterView {
        FlutterView()
    }

    public func updateUIView(_ uiView: FlutterView, context: Context) {
        uiView.update(trigger: trigger, quantity: quantity, palette: palette)
    }

    // MARK: - UIView backend
    public final class FlutterView: UIView {
        private let emitter = CAEmitterLayer()
        private var stopWorkItem: DispatchWorkItem?

        // cache per evitare rebuild inutili
        private var lastQuantity: Int = -1
        private var lastPaletteKey: UInt64 = 0

        // base card cache (CGImage costoso da rigenerare)
        private static let baseCardCG: CGImage = {
            cgRectCard(size: CGSize(width: 10, height: 16), corner: 2)
        }()

        public override init(frame: CGRect) {
            super.init(frame: frame)

            isUserInteractionEnabled = false
            backgroundColor = .clear

            layer.addSublayer(emitter)
            emitter.emitterShape = .line
            emitter.renderMode = .unordered
            emitter.preservesDepth = true

            // IMPORTANT: evita emissione prima del primo update()
            emitter.birthRate = 0
            emitter.emitterCells = []
        }

        public required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        public override func layoutSubviews() {
            super.layoutSubviews()
            emitter.frame = bounds
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: -6)
            emitter.emitterSize = CGSize(width: bounds.width, height: 2)
        }

        /// Idempotente: può essere chiamato spesso da SwiftUI.
        func update(trigger: Double, quantity: Int, palette: [UIColor]) {
            // rebuild celle solo se palette/quantity cambiano
            let key = Self.paletteHash64(palette)
            if lastQuantity != quantity || lastPaletteKey != key {
                emitter.emitterCells = makeCells(palette: palette, quantity: quantity)
                lastQuantity = quantity
                lastPaletteKey = key
            }

            stopWorkItem?.cancel()
            stopWorkItem = nil

            switch trigger {
            case ..<0: // infinito
                emitter.birthRate = 1
            case 0:    // stop
                emitter.birthRate = 0
            default:   // durata
                emitter.birthRate = 1
                let w = DispatchWorkItem { [weak self] in
                    self?.emitter.birthRate = 0
                }
                stopWorkItem = w
                DispatchQueue.main.asyncAfter(deadline: .now() + trigger, execute: w)
            }
        }

        private func makeCells(palette: [UIColor], quantity: Int) -> [CAEmitterCell] {
            let baseCG = Self.baseCardCG

            let streams = 4
            let perSec  = max(1.0, Double(quantity) / 2.0)

            var out: [CAEmitterCell] = []
            out.reserveCapacity(max(1, palette.count * streams))

            for color in palette {
                for s in 0..<streams {
                    let c = CAEmitterCell()
                    c.contents = baseCG
                    c.color = color.cgColor

                    // emissione
                    c.birthRate = Float(perSec) / Float(max(1, palette.count * streams))
                    c.lifetime = 25.0
                    c.lifetimeRange = 12.0

                    // dinamica "flutter"
                    c.velocity = 30
                    c.velocityRange = 20
                    c.emissionLongitude = .pi / 2      // verso il basso
                    c.emissionRange = .pi              // cono
                    c.yAcceleration = 5                // gravità leggera
                    c.xAcceleration = 0
                    c.zAcceleration = CGFloat([-8, -4, 4, 8][s & 3])

                    // rotazione / flip / fade
                    c.spin = 3.8
                    c.spinRange = 5.0
                    c.scale = 0.9
                    c.scaleRange = 0.2
                    c.scaleSpeed = -0.02
                    c.alphaRange = 0.1
                    c.alphaSpeed = -0.02

                    out.append(c)
                }
            }
            return out
        }

        // MARK: - Helpers

        /// Hash stabile 64-bit della palette (basato su RGBA).
        private static func paletteHash64(_ palette: [UIColor]) -> UInt64 {
            // FNV-1a 64
            var h: UInt64 = 1469598103934665603
            let prime: UInt64 = 1099511628211

            for u in palette {
                var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
                // getRed fallisce per pattern colors: fallback a cgColor components
                if u.getRed(&r, green: &g, blue: &b, alpha: &a) == false,
                   let comps = u.cgColor.components {
                    if comps.count >= 3 {
                        r = comps[0]; g = comps[1]; b = comps[2]
                        a = comps.count >= 4 ? comps[3] : 1
                    }
                }

                let bytes: [UInt8] = [
                    UInt8(max(0, min(255, Int(r * 255)))),
                    UInt8(max(0, min(255, Int(g * 255)))),
                    UInt8(max(0, min(255, Int(b * 255)))),
                    UInt8(max(0, min(255, Int(a * 255))))
                ]

                for b in bytes {
                    h ^= UInt64(b)
                    h &*= prime
                }
            }
            return h
        }

        /// Rettangolino bianco arrotondato (tintabile via c.color).
        private static func cgRectCard(size: CGSize, corner: CGFloat) -> CGImage {
            let r = UIGraphicsImageRenderer(size: size)
            let img = r.image { ctx in
                UIColor.clear.setFill()
                ctx.fill(CGRect(origin: .zero, size: size))

                let rect = CGRect(origin: .zero, size: size)
                let path = UIBezierPath(roundedRect: rect, cornerRadius: corner)
                UIColor.white.setFill()
                path.fill()

                // shading centrale per suggerire "flip"
                let g = CGGradient(
                    colorsSpace: CGColorSpaceCreateDeviceRGB(),
                    colors: [
                        UIColor(white: 1, alpha: 1).cgColor,
                        UIColor(white: 0.88, alpha: 1).cgColor,
                        UIColor(white: 1, alpha: 1).cgColor
                    ] as CFArray,
                    locations: [0, 0.5, 1]
                )!

                let midX = size.width / 2
                ctx.cgContext.saveGState()
                ctx.cgContext.addPath(path.cgPath)
                ctx.cgContext.clip()
                ctx.cgContext.drawLinearGradient(
                    g,
                    start: CGPoint(x: midX - 2, y: 0),
                    end:   CGPoint(x: midX + 2, y: size.height),
                    options: []
                )
                ctx.cgContext.restoreGState()
            }
            return img.cgImage!
        }
    }
}

// MARK: - Demo

struct DemoFlutter: View {
    @State private var mode: Double = -1 // start subito in infinito

    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                ZStack(alignment: .bottom) {
                    Text("🏆")
                        .font(.system(size: 140, weight: .bold))
                        .foregroundStyle(.black)

                    Image(systemName: "person.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.black)
                        .shadow(radius: 12)
                        .offset(y: 25)
                }

                Text("Coppia Vincente")
                    .font(.title.bold())
                    .foregroundStyle(.black)
            }
            .padding(.bottom, 60)

            VStack(spacing: 16) {
                FlutterConfettiOverlay(
                    trigger: mode,
                    quantity: 30,
                    palette: [.systemPink, .systemTeal, .systemYellow, .systemPurple, .systemGreen]
                )
                .ignoresSafeArea()
                .allowsHitTesting(false)
                .zIndex(2)

                HStack {
                    Button("Start ∞") { mode = -1 }
                    Button("Stop")    { mode = 0 }
                    Button("Burst 2s"){ mode = 2 }
                }
                .buttonStyle(.borderedProminent)
                .zIndex(1)

                Spacer()
            }
        }
    }
}

#Preview {
    DemoFlutter()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}

////
////  FlutterConfettiOverlay.swift
////  camadonna
////
////  Created by Simone Pistecchia on 29/08/25.
////
//
//import SwiftUI
//import UIKit
//
/////Coriandoli confetti fluttuanti sullo schermo
//public struct FlutterConfettiOverlay: UIViewRepresentable {
//    public var trigger: Double
//    public var quantity: Int
//    public var palette: [UIColor]
//
//    /// Crea un overlay di coriandoli flutter.
//    /// - Parameters:
//    ///   - trigger: -1 = infinito, 0 = stop, >0 = durata in secondi
//    ///   - quantity: quantità indicativa di coriandoli emessi
//    ///   - palette: colori dei coriandoli
//    public init(
//        trigger: Double,
//        quantity: Int = 500,
//        palette: [UIColor] = [.systemRed, .systemBlue, .systemGreen,
//                               .systemOrange, .systemPink, .systemYellow, .systemPurple]
//    ) {
//        self.trigger = trigger
//        self.quantity = quantity
//        self.palette = palette
//    }
//
//    public func makeUIView(context: Context) -> FlutterView { FlutterView() }
//
//    public func updateUIView(_ uiView: FlutterView, context: Context) {
//        uiView.update(trigger: trigger, quantity: quantity, palette: palette)
//    }
//
//    // MARK: - UIView backend
//    final public class FlutterView: UIView {
//        private let emitter = CAEmitterLayer()
//        private var isConfigured = false
//        private var stopWorkItem: DispatchWorkItem?
//
//        public override init(frame: CGRect) {
//            super.init(frame: frame)
//            isUserInteractionEnabled = false
//            backgroundColor = .clear
//            layer.addSublayer(emitter)
//            emitter.emitterShape = .line
//            emitter.renderMode = .unordered
//            emitter.preservesDepth = true     // abilita Z per “3D-like”
//        }
//        public required init?(coder: NSCoder) { fatalError() }
//
//        public override func layoutSubviews() {
//            super.layoutSubviews()
//            // “Pioggia dal soffitto”: linea in alto, verso il basso
//            emitter.emitterPosition = CGPoint(x: bounds.midX, y: -6)
//            emitter.emitterSize     = CGSize(width: bounds.width, height: 2)
////            if !isConfigured {
////                emitter.emitterCells = makeCells(palette: [.white]) // placeholder
////                isConfigured = true
////            }
//        }
//
//        func update(trigger: Double, quantity: Int, palette: [UIColor]) {
//            // (Re)config cells con quantità/palette
//            emitter.emitterCells = makeCells(palette: palette, quantity: quantity)
//
//            stopWorkItem?.cancel(); stopWorkItem = nil
//            switch trigger {
//            case ..<0:   // infinito
//                emitter.birthRate = 1
//            case 0:      // stop
//                emitter.birthRate = 0
//            default:     // durata specifica
//                emitter.birthRate = 1
//                let w = DispatchWorkItem { [weak self] in self?.emitter.birthRate = 0 }
//                stopWorkItem = w
//                DispatchQueue.main.asyncAfter(deadline: .now() + trigger, execute: w)
//            }
//        }
//
//        private func makeCells(palette: [UIColor], quantity: Int = 500) -> [CAEmitterCell] {
//            // confetti rettangolari “card” bianchi (tint via .color)
//            let baseCG = Self.cgRectCard(size: CGSize(width: 10, height: 16), corner: 2)
//
//            // distribuisci la portata tra colori e “correnti” di vento
//            let streams = 4                                    // correnti diverse = x/z accel diverse
//            let perSec  = max(1.0, Double(quantity) / 2.0)     // caduta lenta → emettere “costante”
//
//            var out: [CAEmitterCell] = []
//            for color in palette {
//                for s in 0..<streams {
//                    let c = CAEmitterCell()
//                    c.contents = baseCG                         // bianco → tintabile
//                    c.color = color.cgColor
//
//                    // --- parametri “flutter” (lenti, aria, caduta dolce) ---
//                    c.birthRate = Float(perSec) / Float(palette.count * streams)
//                    c.lifetime = 25.0
//                    c.lifetimeRange = 12.0
//                    c.velocity = 30
//                    c.velocityRange = 20
//                    c.emissionLongitude = .pi/2                // verso il basso
//                    c.emissionRange = .pi                    // cono stretto
//                    c.yAcceleration = 5                       // gravità leggera
//                    // “vento” laterale diverso per stream
////                    let xDrift: CGFloat = [ -25, -10, 10, 25 ][s % 4]
//                    c.xAcceleration = 0 //xDrift
//                    // “profondità” per effetto 3D e parallax
//                    c.zAcceleration = CGFloat([-8, -4, 4, 8][s % 4])
//
//                    // rotazione ampia (flip) + scale breathing
//                    c.spin = 3.8
//                    c.spinRange = 5.0
//                    c.scale = 0.9
//                    c.scaleRange = 0.2
//                    c.scaleSpeed = -0.02
//                    c.alphaRange = 0.1
//                    c.alphaSpeed = -0.02
//                    // --------------------------------------------------------
//
//                    out.append(c)
//                }
//            }
//            return out
//        }
//
//        // rettangolino bianco arrotondato (tintabile via c.color)
//        static func cgRectCard(size: CGSize, corner: CGFloat) -> CGImage {
//            let r = UIGraphicsImageRenderer(size: size)
//            let img = r.image { ctx in
//                UIColor.clear.setFill()
//                ctx.fill(CGRect(origin: .zero, size: size))
//                let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: corner)
//                UIColor.white.setFill()
//                path.fill()
//
//                // leggera banda centrale per suggerire “flip” (shading finto)
//                let g = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
//                                   colors: [UIColor(white: 1, alpha: 1).cgColor,
//                                            UIColor(white: 0.88, alpha: 1).cgColor,
//                                            UIColor(white: 1, alpha: 1).cgColor] as CFArray,
//                                   locations: [0, 0.5, 1])!
//                let midX = size.width/2
//                ctx.cgContext.saveGState()
//                ctx.cgContext.addPath(path.cgPath)
//                ctx.cgContext.clip()
//                ctx.cgContext.drawLinearGradient(g,
//                                                 start: CGPoint(x: midX-2, y: 0),
//                                                 end:   CGPoint(x: midX+2, y: size.height),
//                                                 options: [])
//                ctx.cgContext.restoreGState()
//            }
//            return img.cgImage!
//        }
//    }
//}
//
//struct DemoFlutter: View {
//    @State private var mode: Double = 0   // -1 infinito all’avvio
//
//    var body: some View {
//        ZStack {
//            VStack(spacing: 12) {
//                ZStack (alignment: .bottom) {
//                    Text("🏆")
//                        .font(.system(size: 140, weight: .bold, design: .default))
//                        .foregroundStyle(.black)
//                    Image(systemName: "person.2.fill")
//                        .resizable().scaledToFit()
//                        .frame(width: 120, height: 120)
//                        .foregroundStyle(.black)
//                        .shadow(radius: 12)
//                        .offset(y: 25)
//                }
//                
//                Text("Coppia Vincente")
//                    .font(.title.bold())
//                    .foregroundStyle(.black)
//                
//            }
//            .padding(.bottom, 60)
//            
//            VStack(spacing: 16) {
//                FlutterConfettiOverlay(trigger: mode,
//                                       quantity: 30,
//                                       palette: [.systemPink,.systemTeal,.systemYellow,.systemPurple,.systemGreen])
//                .ignoresSafeArea()
//                .allowsHitTesting(false)
//                .zIndex(2)
//                HStack {
//                    Button("Start ∞") { mode = -1 }
//                    Button("Stop")    { mode = 0 }
//                    Button("Burst 2s"){ mode = 2 }
//                }
//                .buttonStyle(.borderedProminent)
//                .zIndex(1)
//                Spacer()
//            }
//        }
//        .task {
//            mode = -1
//        }
//        .background {
//            
//        }
//        .overlay(
//            EmptyView()
//        )
//    }
//}
//
//#Preview {
//    DemoFlutter()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//}
