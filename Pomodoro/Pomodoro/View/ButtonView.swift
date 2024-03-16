//
//  ButtonView.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

struct ButtonView: View {
  @EnvironmentObject var timer: TimerService
  
  var body: some View {
    if timer.state != .running {
      Button {
        action { timer.start() }
      } label: {
        startLabel
      }
      .disabled(timer.counter == 0)
    } else {
      Button {
        action { timer.pause() }
      } label: {
        pauseLabel
      }
    }
  }
}

extension ButtonView {
  private var startLabel: some View {
    RoundedRectangle(cornerRadius: 25.0)
      .softOuterShadow(darkShadow: .darkShadow, lightShadow: .lightShadow)
      .overlay {
        Image(systemName: "play.fill")
          .font(.title)
          .foregroundStyle(Color.text)
      }
      .frame(height: 60)
      .foregroundStyle(Color.main)
  }
  
  private var pauseLabel: some View {
    RoundedRectangle(cornerRadius: 25.0)
      .softInnerShadow(RoundedRectangle(cornerRadius: 25.0), darkShadow: .darkShadow, lightShadow: .lightShadow)
      .overlay {
        Image(systemName: "pause.fill")
          .font(.title)
          .foregroundStyle(Color.text)
      }
      .frame(height: 60)
      .foregroundStyle(Color.main)
  }
  
  private func action(_ action: () -> ()) {
    let haptic = UISelectionFeedbackGenerator()
    return withAnimation(.easeIn(duration: 0.2)) {
      action()
      haptic.selectionChanged()
    }
  }
}

#Preview {
  ButtonView()
    .environmentObject(TimerService())
}
