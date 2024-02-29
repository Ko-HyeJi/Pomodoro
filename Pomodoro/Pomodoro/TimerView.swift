//
//  TimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI
import Neumorphic
import AVFoundation

let UIWidth = UIScreen.main.bounds.width

struct CircularProgressView: View {
  var progress: Double
  
  var body: some View {
    Path { path in
      path.move(to: CGPoint(x: 50, y: 50))
      path.addLine(to: CGPoint(x: 50, y: 10))
      path.addArc(center: .init(x: 50, y: 50), radius: UIWidth * 0.38, startAngle: .degrees(-90), endAngle: .degrees(-90 + 360 * progress), clockwise: false)
    }
    .fill(Color.accentColor)
    .frame(width: 100, height: 100)
  }
}

struct TimerView: View {
  @State private var timer: Timer? = nil
  @State private var selectedSecond: Int = 900
  private var progress: Double {
    Double(selectedSecond) * 0.0002777777778
  }
  let haptic = UISelectionFeedbackGenerator()
  
  var body: some View {
    VStack {
      Spacer()
      
      Text("\(minutes(selectedSecond)):\(seconds(selectedSecond))")
        .monospacedDigit()
        .tracking(1.5)
        .foregroundStyle(Color.secondary)
        .font(.largeTitle)
        .bold()
      
      Spacer()
      
      ZStack {
        Circle()
          .frame(width: UIWidth * 0.76)
          .foregroundStyle(Color.main)
          .overlay {
            CircularProgressView(progress: self.progress)
          }
          .softOuterShadow(offset: 3)
        
        GeometryReader { geometry in
          ZStack {
            
            ForEach(0..<60) { tick in
              Group {
                Rectangle()
                  .frame(width: 1, height: UIWidth * (tick % 5 == 0 ? 0.05 : 0.02))
                  .offset(y: -geometry.size.width / 2 + (tick % 5 == 0 ? 10 : 5))
                
                if tick % 5 == 0 {
                  Text("\(tick)")
                    .rotationEffect(.degrees(Double(tick) * -6))
                    .offset(y: -geometry.size.width * 0.55)
                    .font(.caption)
                }
              }
              .foregroundStyle(Color.secondary)
              .rotationEffect(.degrees(Double(tick) * 6))
            }
            
            Handle(geometry: geometry, selectedSecond: $selectedSecond)
              .opacity(timer == nil ? 100 : 0)
          }
        }
        .onChange(of: selectedSecond, {
          if timer == nil {
            haptic.selectionChanged()
          }
        })
        .frame(width: UIWidth * 0.76, height: UIWidth * 0.76)
        
      }
      Spacer()
      if timer == nil {
        Button {
          startTimer()
          haptic.selectionChanged()
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softOuterShadow(offset: 3)
            .foregroundStyle(Color.main)
            .frame(height: 60)
            .overlay {
              Image(systemName: "play.fill")
                .font(.title)
                .foregroundStyle(Color.secondary)
            }
            .padding()
            .padding(.horizontal)
        }
      } else {
        Button {
          stopTimer()
          haptic.selectionChanged()
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softInnerShadow(RoundedRectangle(cornerRadius: 25.0))
            .foregroundStyle(Color.main)
            .frame(height: 60)
            .overlay {
              Image(systemName: "pause.fill")
                .font(.title)
                .foregroundStyle(Color.secondary)
            }
            .padding()
            .padding(.horizontal)
        }
      }
      Spacer()
    }
    .padding()
    .background {
      Color.main
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
