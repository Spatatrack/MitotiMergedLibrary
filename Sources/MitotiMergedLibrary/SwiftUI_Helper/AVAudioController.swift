//
//  AudioController.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 31/10/2020.
//

import SwiftUI
import AVFoundation

struct AVAudioController: View {
    
    var player: AVAudioPlayer?
    
    @State private var playValue: TimeInterval = 0.0
    @State private var isPlaying: Bool = false
    @State private var playerDuration: TimeInterval = 120
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
     
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    if self.isPlaying {
                        self.isPlaying.toggle()
                        self.player?.pause()
                        self.timer.upstream.connect().cancel()
                    }
                    else {
                        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                       
                        if playWAAudio() {
                            self.isPlaying.toggle()
                        }
                    }
                }, label: {
                    Image(systemName: isPlaying ? "pause.fill":"play.fill")
                    .font(Font.system(size: 24))
                    .padding(.leading, CGFloat(20))
                    .padding(.trailing, CGFloat(20))
                    .foregroundColor(.black)
                })
                .offset(y: -2)
                .frame(width: 35)
                .fixedSize()
                Text("")
                .font(.system(size: 11, weight: .light))
            }
            VStack {
                Slider(value: $playValue, in: TimeInterval(0.0)...playerDuration, onEditingChanged: { _ in
                    self.changeSliderValue()
                })
                //.frame(width: 200, height: 10, alignment: Alignment.center)
                .frame(width: 200, height: 10, alignment: Alignment.center)
                HStack {
                    Text(playValue.stringFromTimeInterval())
                    .font(.system(size: 11, weight: .light))
                    .padding(.trailing,68)
                    .offset(y: +3)
                    .onReceive(timer) { _ in
                        if let currentTime = self.player?.currentTime {
                            self.playValue = currentTime
                            // reset playValue, so reset isPlaying if needed
                            if currentTime == TimeInterval(0.0) { // only explicitly
                                self.isPlaying = false
                                self.timer.upstream.connect().cancel()
                            }
                        }
                    }
                    Text(playerDuration.stringFromTimeInterval())
                        .font(.system(size: 11, weight: .light))
                        .padding(.leading,68)
                        .offset(y: +3)
                }
            }
        }
        .onAppear() {
            self.timer.upstream.connect().cancel()
            //self.getSoundAsync()
        }
    }

    func playWAAudio() -> Bool {
        do {
           try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        ///se stavo facendo play su un altro file, allore fai solo resume, altrimenti carica l'altro file
        if player != nil {
            player?.play()
            if player?.isPlaying == true {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    func changeSliderValue() {
        self.player?.currentTime = playValue
    }
}
#if DEBUG
struct AVAudioController_Previews: PreviewProvider {
    static var previews: some View {
        AVAudioController()
    }
}
#endif
