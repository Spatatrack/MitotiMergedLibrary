//
//  SunshineEffectView.swift
//  camadonna
//
//  Created by Simone Pistecchia on 29/08/25.
//

import SwiftUI
import CoreGraphics
import UIKit

public struct SunshineBurstView: View {
    public var rays: Int = 32
    public var duty: Double = 0.22            // 0…1: quanto è stretto il raggio nel suo settore
    public var innerColor: Color = .white
    public var outerColor: Color = .yellow
    public var outerOpacity: Double = 0.65
    public var centerGlowRadius: CGFloat = 0.20
    public var rotates: Bool = true
    public var period: Double = 10            // s per un giro

    @State private var angle: Angle = .degrees(0)

    public init(
        rays: Int = 32,
        duty: Double = 0.22,
        innerColor: Color = .white,
        outerColor: Color = .yellow,
        outerOpacity: Double = 0.65,
        centerGlowRadius: CGFloat = 0.20,
        rotates: Bool = true,
        period: Double = 10
    ) {
        self.rays = rays
        self.duty = duty
        self.innerColor = innerColor
        self.outerColor = outerColor
        self.outerOpacity = outerOpacity
        self.centerGlowRadius = centerGlowRadius
        self.rotates = rotates
        self.period = period
    }

    public var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let center = CGPoint(x: size.width/2, y: size.height/2)
            let R = hypot(size.width, size.height)

            Canvas { ctx, _ in
                // ---- Base wash radiale (soft) ----
                ctx.withCGContext { cg in
                    drawRadialGradient(
                        in: cg,
                        center: center,
                        startRadius: 0,
                        endRadius: R,   // già abbastanza grande
                        colors: [
                            UIColor(innerColor).withAlphaComponent(0.10).cgColor,
                            UIColor(outerColor).withAlphaComponent(outerOpacity * 0.25).cgColor
                        ],
                        locations: [0.0, 1.0]
                    )
                }

                // ---- Raggi sottili ----
                let n = max(1, rays)
                let sector = 2 * .pi / Double(n)
                let beam = sector * min(max(duty, 0), 1)

                for i in 0..<n {
                    let aMid = Double(i) * sector
                    let a0 = aMid - beam/2
                    let a1 = aMid + beam/2

                    var p = Path()
                    p.move(to: center)
                    p.addArc(center: center, radius: R,
                             startAngle: .radians(a0),
                             endAngle: .radians(a1),
                             clockwise: false)
                    p.closeSubpath()

                    let end = CGPoint(x: center.x + CGFloat(cos(aMid)) * R,
                                      y: center.y + CGFloat(sin(aMid)) * R)

                    // Clip allo spicchio e disegna gradiente lineare lungo il raggio
                    ctx.withCGContext { cg in
                        cg.saveGState()
                        cg.addPath(p.cgPath)
                        cg.clip()
                        drawLinearGradient(in: cg, start: center, end: end,
                            colors: [
                                UIColor(innerColor).withAlphaComponent(0.95).cgColor,
                                UIColor(outerColor).withAlphaComponent(outerOpacity).cgColor,
                                UIColor(outerColor).withAlphaComponent(0.0).cgColor
                            ],
                            locations: [0.0, 0.55, 1.0]
                        )
                        cg.restoreGState()
                    }
                    
                }

                // ---- Glow centrale forte ----
                let gr = min(size.width, size.height) * centerGlowRadius
                ctx.withCGContext { cg in
                    drawRadialGradient(
                        in: cg,
                        center: center,
                        startRadius: 0,
                        endRadius: gr,
                        colors: [
                            UIColor(innerColor).withAlphaComponent(1.0).cgColor,
                            UIColor(innerColor).withAlphaComponent(0.0).cgColor
                        ],
                        locations: [0.0, 1.0]
                    )
                }
            }
            .rotationEffect(angle)
            .blendMode(.screen)
            .blur(radius: 0.6)
            .onAppear {
                guard rotates else { return }
                angle = .degrees(0)
                withAnimation(.linear(duration: period).repeatForever(autoreverses: false)) {
                    angle = .degrees(360)
                }
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

// MARK: - CoreGraphics helpers
@inline(__always)
private func makeGradient(colors: [CGColor], locations: [CGFloat]) -> CGGradient {
    CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
               colors: colors as CFArray,
               locations: locations)!
}

@inline(__always)
private func drawLinearGradient(in cg: CGContext,
                                start: CGPoint,
                                end: CGPoint,
                                colors: [CGColor],
                                locations: [CGFloat]) {
    let g = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                       colors: colors as CFArray,
                       locations: locations)!
    cg.drawLinearGradient(g, start: start, end: end, options: [])
}
@inline(__always)
private func drawRadialGradient(in cg: CGContext,
                                center: CGPoint,
                                startRadius: CGFloat,
                                endRadius: CGFloat,
                                colors: [CGColor],
                                locations: [CGFloat]) {
    let g = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                       colors: colors as CFArray,
                       locations: locations)!
    // NIENTE clip al rect: così non si vede il rettangolo che gira
    cg.drawRadialGradient(g,
                          startCenter: center, startRadius: startRadius,
                          endCenter: center,   endRadius: endRadius,
                          options: [])
}


// MARK: - Preview
#Preview {
    ZStack {
        Color.white.ignoresSafeArea()

//        SunshineEffectView()
        VStack(spacing: 12) {
            Image(systemName: "person.2.fill")
                .resizable().scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(.black)
                .shadow(radius: 12)
            Text("Coppia Vincente 🏆")
                .font(.title.bold())
                .foregroundStyle(.black)
        }
        .padding(.bottom, 60)
        VStack(spacing: 12) {
            Image(systemName: "person.2.fill")
                .resizable().scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(.white)
                .shadow(radius: 12)
            Text("Coppia Vincente 🏆")
                .font(.title.bold())
                .foregroundStyle(.white)
        }
        .padding(.bottom, 60)
        
    }
}
