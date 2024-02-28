//
//  TimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI
import Neumorphic

let UIWidth = UIScreen.main.bounds.width

struct CircularProgressView: View {
  var progress: Double
  
  var body: some View {
    Path { path in
      path.move(to: CGPoint(x: 50, y: 50))
      path.addLine(to: CGPoint(x: 50, y: 10))
      path.addArc(center: .init(x: 50, y: 50), radius: UIWidth * 0.38, startAngle: .degrees(-90), endAngle: .degrees(-90 + 360 * progress), clockwise: false)
    }
    .fill(Color.accentColor.opacity(0.85))
    .frame(width: 100, height: 100)
  }
}

struct TimerView: View {
  @State private var timer: Timer? = nil
  @State private var selectedSecond: Int = 600
  private var progress: Double {
    Double(selectedSecond) * 0.0002777777778
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      Text("\(minutes(selectedSecond)):\(seconds(selectedSecond))")
        .monospacedDigit()
        .tracking(1.5)
        .foregroundStyle(Color.Neumorphic.secondary)
        .font(.title)
        .bold()
      
      Spacer()
      
      ZStack {
        Circle()
          .frame(width: UIWidth * 0.76)
          .foregroundStyle(Color.Neumorphic.main)
          .overlay {
            CircularProgressView(progress: self.progress)
          }
          .softOuterShadow()
        
        GeometryReader { geometry in
          Hand(geometry: geometry, selectedSecond: $selectedSecond)
        }
        .frame(height: 300)
        .disabled(timer != nil)
      }
      Spacer()
      if timer == nil {
        Button {
          startTimer()
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softOuterShadow()
            .foregroundStyle(Color.Neumorphic.main)
            .frame(height: 60)
            .overlay {
              Image(systemName: "play.fill")
                .font(.title)
                .foregroundStyle(Color.Neumorphic.secondary)
            }
            .padding()
        }
      } else {
        Button {
          stopTimer()
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softInnerShadow(RoundedRectangle(cornerRadius: 25.0))
            .foregroundStyle(Color.Neumorphic.main)
            .frame(height: 60)
            .overlay {
              Image(systemName: "pause.fill")
                .font(.title)
                .foregroundStyle(Color.Neumorphic.secondary)
            }
            .padding()
        }
      }
      Spacer()
    }
    .padding()
    .background {
      Color.Neumorphic.main
        .ignoresSafeArea()
    }
  }
  
  func startTimer() {
    self.timer?.invalidate()
    
    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      if self.selectedSecond > 0 {
        self.selectedSecond -= 1
      } else {
        self.timer?.invalidate()
        self.timer = nil
      }
    }
  }
  
  func stopTimer() {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  private func minutes(_ seconds: Int) -> String {
    return String(format: "%02d", seconds / 60)
  }
  
  private func seconds(_ seconds: Int) -> String {
    return String(format: "%02d", seconds % 60)
  }
}

#Preview {
  TimerView()
}
