//
//  SwiftUIView.swift
//  camadonna
//
//  Created by Simone Pistecchia on 26/08/25.
//

import SwiftUI
import AudioToolbox

/// Container: Sunshine dietro, Content al centro, Confetti sopra.
/// confettiTrigger: -1 = infinito, 0 = stop, >0 = durata in secondi
struct CelebrationContainer<Content: View>: View {
    // Confetti
   
    var confettiQuantity: Int = 30
    var confettiPalette: [UIColor] = [.systemPink, .systemYellow, .systemGreen, .systemTeal, .systemPurple, .systemOrange]

    // Sunshine
    var sunRays: Int = 36
    var sunDuty: Double = 0.48
    var sunInner: Color = .white
    var sunOuter: Color = .yellow
    var sunOuterOpacity: Double = 0.75
    var sunGlowRadius: CGFloat = 0.18
    var sunRotates: Bool = true
    var sunPeriod: Double = 40
   
    // Content
    @ViewBuilder var content: () -> Content
    @State private var mode: Double = 0
    var body: some View {
        GeometryReader { geo in
            let max = max(geo.size.width, geo.size.height) * 1.3
            ZStack {
                // BACKGROUND: Sunshine
                
                
                ConfettiOverlay(trigger: true,
                                simbolScale: 0.1,
                                useEmoji: true,
                                quantity: 1550,
                                duration: 2)
                .id(UUID())
                .frame(width: 10, height: 10)
                .zIndex(0)
                // CONTENT
                content()
                    .zIndex(1)
                
                
                // OVERLAY: Confetti sopra tutto
                FlutterConfettiOverlay(trigger: mode,
                                       quantity: confettiQuantity,
                                       palette: confettiPalette)
                .ignoresSafeArea()
                .allowsHitTesting(false)
                .zIndex(2)
            }
            .task {
                mode = -1
                AudioServicesPlaySystemSound(SystemSoundID(1322)) 
            }
            .background {
                SunshineBurstView(
                    rays: sunRays,
                    duty: sunDuty,
                    innerColor: sunInner,
                    outerColor: sunOuter,
                    outerOpacity: sunOuterOpacity,
                    centerGlowRadius: sunGlowRadius,
                    rotates: sunRotates,
                    period: sunPeriod
                )
                .frame(width: max, height: max)
                .ignoresSafeArea()
                .zIndex(0)
            }
        }
    }
}
struct CelebrationView: View {
    @State private var mode: Double = 0
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                ZStack (alignment: .bottom) {
                    Text("🏆")
                        .font(.system(size: 140, weight: .bold, design: .default))
                        .foregroundStyle(.black)
                    Image(systemName: "person.2.fill")
                        .resizable().scaledToFit()
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
                FlutterConfettiOverlay(trigger: mode,
                                       quantity: 30,
                                       palette: [.systemPink,.systemTeal,.systemYellow,.systemPurple,.systemGreen])
                .ignoresSafeArea()
                .allowsHitTesting(false)
                .zIndex(2)
                
            }
        }
        .task {
            mode = -1
        }
        
    }
}

#Preview {
    CelebrationContainer {
        VStack(spacing: 12) {
            ZStack (alignment: .bottom) {
                Text("🏆")
                    .font(.system(size: 140, weight: .bold, design: .default))
                    .foregroundStyle(.black)
                Image(systemName: "person.2.fill")
                    .resizable().scaledToFit()
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
    }
}
