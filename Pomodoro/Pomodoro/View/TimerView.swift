//
//  TimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI
import Neumorphic
import AVFoundation
import AudioToolbox

struct TimerView: View {
  @State private var timer: Timer? = nil
  @State private var selectedSecond: Int = 0
  private var progress: Double { Double(selectedSecond) * 0.0002777777778 }
  let haptic = UISelectionFeedbackGenerator()
  @Environment(\.scenePhase) private var scenePhase
  @State var saveDate: Date?
  @State var saveTime: Int?
  @State var UIWidth = UIScreen.main.bounds.width
  
  var body: some View {
    GeometryReader { geometry in
      if geometry.size.height > geometry.size.width {
        HStack {
          Spacer()
          VStack {
            Spacer()
            textTimer
            Spacer()
            circleTimer
            Spacer()
            button
              .frame(width: UIWidth * 0.76)
            Spacer()
          }
          Spacer()
        }
        .ignoresSafeArea()
        .onAppear {
          UIWidth = UIScreen.main.bounds.width
        }
      } else {
        VStack {
          Spacer()
          HStack {
            Spacer()
            circleTimer
            Spacer()
            VStack(spacing: 30) {
              textTimer
              button
                .frame(width: UIWidth * 0.4)
            }
            Spacer()
          }
          Spacer()
        }
        .ignoresSafeArea()
        .onAppear {
          UIWidth = UIScreen.main.bounds.height
        }
      }
    }
    .background {
      Color.main
        .ignoresSafeArea()
    }
    .onChange(of: scenePhase) { newScenePhase in
      switch newScenePhase {
      case .active:
        if let saveDate = saveDate, let saveTime = saveTime {
          selectedSecond = saveTime - Int(Date().timeIntervalSince(saveDate))
          if selectedSecond < 0 {
            self.stopTimer()
            selectedSecond = 0
          }
          self.saveDate = nil
          self.saveTime = nil
        }
      case .background:
        if timer != nil {
          saveDate = Date()
          saveTime = selectedSecond
        }
      default:
        return
      }
    }
  }
  
  var textTimer: some View {
    Text("\(minutes(selectedSecond)):\(seconds(selectedSecond))")
      .monospacedDigit()
      .tracking(1.5)
      .foregroundStyle(Color.label)
      .font(.largeTitle.bold())
  }
  
  var circleTimer: some View {
    ZStack {
      Circle()
        .frame(width: UIWidth * 0.76)
        .foregroundStyle(Color.main)
        .softOuterShadow(darkShadow: .darkShadow, lightShadow: .lightShadow)
      
      progressView
      
      GeometryReader { geometry in
        ZStack {
          ForEach(0..<60) { tick in
            Group {
              let length = UIWidth * (tick % 5 == 0 ? 0.05 : 0.02)
              Rectangle()
                .frame(width: 1, height: length)
                .offset(y: (-geometry.size.width / 2) + (length / 2))
              
              if tick % 5 == 0 {
                Text("\(tick)")
                  .rotationEffect(.degrees(Double(tick) * -6))
                  .offset(y: -geometry.size.width * 0.55)
                  .font(.caption)
              }
            }
            .foregroundStyle(Color.label)
            .rotationEffect(.degrees(Double(tick) * 6))
          }
          
          Handle(geometry: geometry, selectedSecond: $selectedSecond)
            .opacity(timer == nil ? 100 : 0)
          
          Circle()
            .foregroundStyle(Color.main)
            .frame(width: UIWidth * 0.15)
            .shadow(color: .darkShadow, radius: 3, x: 3, y: 3)
        }
      }
      .onChange(of: selectedSecond) { _ in
        if timer == nil {
          haptic.selectionChanged()
        }
      }
      .frame(width: UIWidth * 0.76, height: UIWidth * 0.76)
      
    }
  }
  
  var button: some View {
    Group {
      if timer == nil {
        Button {
          startTimer()
          haptic.selectionChanged()
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softOuterShadow(darkShadow: .darkShadow, lightShadow: .lightShadow)
            .overlay {
              Image(systemName: "play.fill")
                .font(.title)
                .foregroundStyle(Color.label)
            }
        }
      } else {
        Button {
          stopTimer()
          haptic.selectionChanged()
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softInnerShadow(RoundedRectangle(cornerRadius: 25.0), darkShadow: .darkShadow, lightShadow: .lightShadow)
            .overlay {
              Image(systemName: "pause.fill")
                .font(.title)
                .foregroundStyle(Color.label)
            }
        }
      }
    }
    .frame(height: 60)
    .foregroundStyle(Color.main)
  }
  
  var progressView: some View {
    Path { path in
      path.move(to: CGPoint(x: 50, y: 50))
      path.addLine(to: CGPoint(x: 50, y: 10))
      path.addArc(center: .init(x: 50, y: 50), radius: UIWidth * 0.38, startAngle: .degrees(-90), endAngle: .degrees(-90 + 360 * progress), clockwise: false)
    }
    .fill(Color.accentColor)
    .frame(width: 100, height: 100)
  }
  
  
  func startTimer() {
    self.timer?.invalidate()
    UIApplication.shared.isIdleTimerDisabled = true
    
    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      if self.selectedSecond > 0 {
        self.selectedSecond -= 1
      } else {
        stopTimer()
        playSystemSound()
      }
    }
  }
  
  func stopTimer() {
    self.timer?.invalidate()
    self.timer = nil
    UIApplication.shared.isIdleTimerDisabled = false
  }
  
  private func minutes(_ seconds: Int) -> String {
    return String(format: "%02d", seconds / 60)
  }
  
  private func seconds(_ seconds: Int) -> String {
    return String(format: "%02d", seconds % 60)
  }
  
  func playSystemSound() {
    AudioServicesPlaySystemSound(1005)
  }
}

#Preview {
  TimerView()
}

//extension ScenePhase {
//  func handleScenePhase() {
//    switch self {
//    case .active:
//      
//    case .background:
//      
//    default:
//      return
//    }
//  }
//}
