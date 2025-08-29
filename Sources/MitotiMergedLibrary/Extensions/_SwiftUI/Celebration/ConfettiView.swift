//
//  Untitled.swift
//  camadonna
//
//  Created by Simone Pistecchia on 26/08/25.
//

import SwiftUI
import UIKit


struct Ping: View {
    @State var isPresented: Bool = false
    var body: some View {
        VStack {
            DemoConfetti()
//            ZStack {
//                Button("Show") {
//                    self.isPresented.toggle()
//                }
//                CelebrationOverlay(isPresented: $isPresented)
//            }
//            ZStack {
//                // ... UI
//            }
//            .ignoresSafeArea()
//            .overlay(
//                ConfettiCannonOverlay(quantity: 300, duration: 0.7) // “boom” + caduta naturale
//            )
        }
    }
}
#Preview { Ping() }
struct DemoConfetti: View {
    @State private var celebrate = false
    @State private var useEmoji = false

    var body: some View {
        ZStack {
            if celebrate {
                ConfettiOverlay(trigger: celebrate,
                                simbolScale: 0.1,
                                useEmoji: useEmoji,
                                quantity: 150,
                                duration: 0)
                .id(UUID())
                .frame(width: 10, height: 10)
                
                
            }
//            ConfettiOverlay(trigger: celebrate,
//                                simbolScale: 0.2,
//                            useEmoji: !useEmoji,
//                            quantity: 500,
//                            duration: 2.2)
//            .id(celebrate)
//                .frame(width: 10, height: 10)
//            }
            VStack(spacing: 20) {
                Button("Confetti Symbols") {
                    useEmoji = false
                    celebrate.toggle()
                }
                .buttonStyle(.borderedProminent)

                Button("Confetti Emoji") {
                    useEmoji = true
                    celebrate.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
        }
//        .overlay {
//            ConfettiOverlay(trigger: celebrate,
//                                simbolScale: 0.1,
//                            useEmoji: useEmoji,
//                            quantity: 50,
//                            duration: 0.1)
////            .frame(width: 10, height: 10)
//        }
    }
}
struct ConfettiOverlay: UIViewRepresentable {
    var trigger: Bool          // ogni volta che passa true → riparte
    var simbolScale: Double = 0.15  //grandezza oggettini
    var useEmoji: Bool = false // true = emoji 🎉⭐️❤️, false = SF Symbols
    var quantity: Int = 300
    var duration: Double = 2.0
    var palette: [UIColor] = [.systemRed, .systemBlue, .systemGreen,
                              .systemOrange, .systemPink, .systemYellow, .systemPurple]

    func makeUIView(context: Context) -> ConfettiView {
        let v = ConfettiView()
        return v
    }
    func updateUIView(_ uiView: ConfettiView, context: Context) {
        if trigger {
            uiView.fire(simbolScale: simbolScale,quantity: quantity, duration: duration,
                        palette: palette, useEmoji: useEmoji)
        }
    }

    // MARK: - Inner UIView
    final class ConfettiView: UIView {
        private var emitter = CAEmitterLayer()

        override init(frame: CGRect) {
            super.init(frame: frame)
            isUserInteractionEnabled = false
            backgroundColor = .clear
            layer.addSublayer(emitter)
            emitter.emitterShape = .line
        }
        required init?(coder: NSCoder) { fatalError() }

        override func layoutSubviews() {
            super.layoutSubviews()
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: -4)
            emitter.emitterSize = CGSize(width: bounds.width, height: 2)
        }

        func fire(simbolScale: Double, quantity: Int, duration: Double,
                  palette: [UIColor], useEmoji: Bool) {

            let perSec = max(1.0, Double(quantity) / max(0.25, duration))
            emitter.birthRate = 1

            var cells: [CAEmitterCell] = []
            let symbols = ["circle.fill","square.fill","triangle.fill","star.fill"]
            let emojis   = ["🎉","⭐️","❤️","💚","💙","🟡"]

            for color in palette {
                let list = useEmoji ? emojis : symbols
                for sym in list {
                    let c = CAEmitterCell()
                    if useEmoji {
                        c.contents = ConfettiView.cgEmoji(sym, size: 22)
                    } else {
                        let cfg = UIImage.SymbolConfiguration(pointSize: 8, weight: .regular)
                        let base = UIImage(systemName: sym, withConfiguration: cfg)!
                        // bianco per poter tintare
                        let img = UIGraphicsImageRenderer(size: base.size).image { _ in
                            base.withTintColor(.white, renderingMode: .alwaysOriginal)
                                .draw(in: CGRect(origin: .zero, size: base.size))
                        }
                        c.contents = img.cgImage
                        c.color = color.cgColor
                    }

                    // --- parametri richiesti ---
                    c.birthRate = Float(perSec) / Float(palette.count * list.count)
                    c.lifetime = 7.5
                    c.lifetimeRange = 1.0
                    c.velocity = 520                   // SPINTA iniziale
                    c.velocityRange = 140
                    c.emissionLongitude = -.pi * 2    // VERSO L’ALTO
                    c.emissionRange = .pi / 6          // cono
                    c.yAcceleration = 420              // “gravità” (giù)
                    c.xAcceleration = 20               // drift laterale
                    c.spin = 3.0
                    c.spinRange = 4.0
                    c.scale = simbolScale * (useEmoji ? 1 : 2)
                    c.scaleRange = 0.2 * (useEmoji ? 1: 2)
                    c.scaleSpeed = 0.01
                    c.alphaSpeed = -0.1
                    cells.append(c)
                }
            }
            emitter.emitterCells = cells

            // Stop emissione dopo durata
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
                self?.emitter.birthRate = 0
            }
        }

        // helper: emoji → CGImage
        static func cgEmoji(_ emoji: String, size: CGFloat) -> CGImage {
            let img = UIGraphicsImageRenderer(size: CGSize(width: size, height: size)).image { _ in
                (emoji as NSString).draw(in: CGRect(x: 0, y: 0, width: size, height: size),
                                         withAttributes: [.font: UIFont.systemFont(ofSize: size)])
            }
            return img.cgImage!
        }
    }
}
struct ConfettiCannonOverlay: UIViewRepresentable {
    var quantity: Int = 400         // pezzi totali
    var duration: Double = 0.8      // quanto “spara” (sec)
    var palette: [UIColor] = [.systemRed, .systemBlue, .systemYellow, .systemGreen, .systemOrange, .systemPink, .systemPurple]

    func makeUIView(context: Context) -> CannonView { CannonView() }
    func updateUIView(_ uiView: CannonView, context: Context) {
        uiView.fire(quantity: quantity, duration: duration, palette: palette)
    }

    final class CannonView: UIView {
        private let emitter = CAEmitterLayer()
        private var isConfigured = false

        override init(frame: CGRect) {
            super.init(frame: frame)
            layer.addSublayer(emitter)
            emitter.emitterShape = .line
            emitter.birthRate = 0
            isUserInteractionEnabled = false
            backgroundColor = .clear
        }
        required init?(coder: NSCoder) { fatalError() }

        override func layoutSubviews() {
            super.layoutSubviews()
            // linea alla BOTTOM: spara verso l’alto
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY + 4)
            emitter.emitterSize = CGSize(width: bounds.width * 0.8, height: 2)
        }

        func fire(quantity: Int, duration: Double, palette: [UIColor]) {
            // CELLS: forme varie, vel iniziale verso l’alto, gravità in giù
            let perSec = max(1.0, Double(quantity) / max(0.15, duration))
            let symbols = ["circle.fill","square.fill","triangle.fill","star.fill"]
            let cells: [CAEmitterCell] = symbols.flatMap { sym in
                palette.map { color in
                    let c = CAEmitterCell()
                    c.contents = UIImage(systemName: sym)?
                        .withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .bold))
                        .withTintColor(.white, renderingMode: .alwaysTemplate) // usa color sotto
                        .cgImage
                    c.color = color.cgColor
                    c.birthRate = Float(perSec) / Float(symbols.count * max(1, palette.count))
                    c.lifetime = 5.5
                    c.lifetimeRange = 1.0
                    c.velocity = 520                   // SPINTA iniziale
                    c.velocityRange = 140
                    c.emissionLongitude = -.pi * 2    // VERSO L’ALTO
                    c.emissionRange = .pi / 6          // cono
                    c.yAcceleration = 420              // “gravità” (giù)
                    c.xAcceleration = 20               // drift laterale
                    c.spin = 3.0
                    c.spinRange = 4.0
                    c.scale = 0.25
                    c.scaleRange = 0.35
                    c.alphaSpeed = -0.1                // svaniscono un po’
                    return c
                }
            }

            emitter.emitterCells = cells
            emitter.birthRate = 1
            // spara per `duration`, poi lascia che i pezzi cadano e spariscano
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
                self?.emitter.birthRate = 0
            }
        }
    }
}

// MARK: - Public API
struct CelebrationOverlay: View {
    @Binding var isPresented: Bool
    var quantity: Int = 300       // pezzi totali (confetti + sparks)
    var duration: Double = 3.0    // secondi di emissione
    var showConfetti: Bool = true
    var showFireworks: Bool = true

    var body: some View {
        ZStack {
            if isPresented {
                if showConfetti {
                    ConfettiEmitter(isActive: isPresented, quantity: quantity, duration: duration)
                        .allowsHitTesting(false)
                        .ignoresSafeArea()
                }
                if showFireworks {
                    FireworksEmitter(isActive: isPresented, quantity: max(1, quantity/3), duration: duration)
                        .allowsHitTesting(false)
                        .ignoresSafeArea()
                }
            }
        }
    }
}

// MARK: - Confetti (CAEmitterLayer)
private struct ConfettiEmitter: UIViewRepresentable {
    var isActive: Bool
    var quantity: Int
    var duration: Double

    func makeUIView(context: Context) -> ConfettiView { ConfettiView() }
    func updateUIView(_ uiView: ConfettiView, context: Context) {
        if isActive { uiView.start(quantity: quantity, duration: duration) }
    }

    final class ConfettiView: UIView {
        private var emitter: CAEmitterLayer?

        override func layoutSubviews() {
            super.layoutSubviews()
            if let e = emitter {
                e.emitterPosition = CGPoint(x: bounds.midX, y: -4)
                e.emitterSize = CGSize(width: bounds.width, height: 2)
            }
        }

        func start(quantity: Int, duration: Double) {
            layer.sublayers?.removeAll(where: { $0 is CAEmitterLayer })
            let e = CAEmitterLayer()
            e.emitterShape = .line
            e.emitterPosition = CGPoint(x: bounds.midX, y: -4)
            e.emitterSize = CGSize(width: bounds.width, height: 2)

            let perSec = max(1.0, Double(quantity) / max(0.25, duration))
            let colors: [UIColor] = [.systemPink, .systemYellow, .systemGreen, .systemBlue, .systemOrange, .systemPurple]
            let symbols = ["circle.fill", "square.fill", "triangle.fill"]

            var cells: [CAEmitterCell] = []
            for color in colors {
                for sym in symbols {
                    let c = CAEmitterCell()
                    c.contents = UIImage(systemName: sym)?
                        .withConfiguration(UIImage.SymbolConfiguration(pointSize: 8, weight: .regular))
                        .cgImage
                    c.birthRate = Float(perSec) / Float(colors.count * symbols.count)
                    c.lifetime = 6
                    c.velocity = 180
                    c.velocityRange = 80
                    c.emissionLongitude = .pi                 // verso il basso
                    c.emissionRange = .pi / 6
                    c.spin = 3.5
                    c.spinRange = 3
                    c.scale = 0.6
                    c.scaleRange = 0.3
                    c.yAcceleration = 200
                    c.xAcceleration = 12
                    c.color = color.cgColor
                    cells.append(c)
                }
            }
            e.emitterCells = cells
            layer.addSublayer(e)
            emitter = e

            // Stop dopo duration, rimuovi quando i pezzi hanno finito la vita
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
                self?.emitter?.birthRate = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self?.emitter?.removeFromSuperlayer()
                }
            }
        }
    }
}

// MARK: - Fireworks (CAEmitterLayer)
private struct FireworksEmitter: UIViewRepresentable {
    var isActive: Bool
    var quantity: Int
    var duration: Double

    func makeUIView(context: Context) -> FireworksView { FireworksView() }
    func updateUIView(_ uiView: FireworksView, context: Context) {
        if isActive { uiView.start(quantity: quantity, duration: duration) }
    }

    final class FireworksView: UIView {
        private var emitter: CAEmitterLayer?

        override func layoutSubviews() {
            super.layoutSubviews()
            if let e = emitter {
                e.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY + 10)
                e.emitterSize = CGSize(width: bounds.width, height: 2)
            }
        }

        func start(quantity: Int, duration: Double) {
            layer.sublayers?.removeAll(where: { $0 is CAEmitterLayer })
            let e = CAEmitterLayer()
            e.emitterShape = .line
            e.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY + 10)
            e.emitterSize = CGSize(width: bounds.width, height: 2)

            let rocketsPerSec = max(1.0, Double(quantity) / max(0.25, duration)) / 8.0

            // Rocket
            let rocket = CAEmitterCell()
            rocket.contents = UIImage(systemName: "circle.fill")?
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 4, weight: .regular))
                .cgImage
            rocket.birthRate = Float(rocketsPerSec)
            rocket.emissionRange = .pi / 6
            rocket.emissionLongitude = -.pi / 2      // su
            rocket.velocity = 320
            rocket.velocityRange = 120
            rocket.yAcceleration = -80
            rocket.lifetime = 1.6
            rocket.scale = 0.25
            rocket.spinRange = 1
            rocket.redRange = 1; rocket.greenRange = 1; rocket.blueRange = 1

            // Burst (al picco)
            let burst = CAEmitterCell()
            burst.birthRate = 1
            burst.scale = 2.5
            burst.lifetime = 0.35
            burst.velocity = 0
            burst.redSpeed = -1.5
            burst.greenSpeed = 1.0
            burst.blueSpeed = 1.5

            // Sparks
            let spark = CAEmitterCell()
            spark.contents = UIImage(systemName: "star.fill")?
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 5, weight: .regular))
                .cgImage
            spark.birthRate = 320
            spark.lifetime = 3.2
            spark.velocity = 140
            spark.velocityRange = 60
            spark.emissionRange = 2 * .pi
            spark.yAcceleration = 90
            spark.scale = 0.15
            spark.scaleSpeed = -0.05
            spark.alphaSpeed = -0.35
            spark.spin = 2
            spark.spinRange = 3
            spark.redRange = 1; spark.greenRange = 1; spark.blueRange = 1

            rocket.emitterCells = [burst]
            burst.emitterCells = [spark]
            e.emitterCells = [rocket]

            layer.addSublayer(e)
            emitter = e

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
                self?.emitter?.birthRate = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self?.emitter?.removeFromSuperlayer()
                }
            }
        }
    }
}

// MARK: - Demo usage
struct CelebrationDemoView: View {
    @State private var celebrate = false
    @State private var qty = 400
    @State private var dur = 3.0

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Vittoria! 🏆").font(.largeTitle.bold())
                HStack {
                    Text("Quantità: \(qty)")
                    Slider(value: Binding(get: { Double(qty) }, set: { qty = Int($0) }),
                           in: 50...1200, step: 50)
                }
                HStack {
                    Text("Durata: \(dur, specifier: "%.1f")s")
                    Slider(value: $dur, in: 0.5...6.0, step: 0.5)
                }
                Button("Celebrate!") {
                    celebrate = false
                    // rilancia l’overlay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        celebrate = true
                        // auto-hide flag dopo fine animazione (opzionale)
                        DispatchQueue.main.asyncAfter(deadline: .now() + dur + 0.2) {
                            celebrate = false
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .overlay(
            CelebrationOverlay(isPresented: $celebrate,
                               quantity: qty,
                               duration: dur,
                               showConfetti: true,
                               showFireworks: true)
        )
    }
}
