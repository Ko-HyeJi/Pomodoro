//
//  ButtonView.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

struct ButtonView: View {
  @EnvironmentObject var timer: TimerService
  @Binding var showHandle: Bool
  let haptic = UISelectionFeedbackGenerator()
  
  var body: some View {
    Group {
      if timer.state != .running {
        Button {
          timer.start()
          haptic.selectionChanged()
          withAnimation(.easeOut(duration: 0.2)) { showHandle = false }
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softOuterShadow(darkShadow: .darkShadow, lightShadow: .lightShadow)
            .overlay {
              Image(systemName: "play.fill")
                .font(.title)
                .foregroundStyle(Color.text)
            }
        }
        .disabled(timer.counter == 0)
      } else {
        Button {
          timer.pause()
          haptic.selectionChanged()
          withAnimation(.easeIn(duration: 0.2)) { showHandle = true }
        } label: {
          RoundedRectangle(cornerRadius: 25.0)
            .softInnerShadow(RoundedRectangle(cornerRadius: 25.0), darkShadow: .darkShadow, lightShadow: .lightShadow)
            .overlay {
              Image(systemName: "pause.fill")
                .font(.title)
                .foregroundStyle(Color.text)
            }
        }
      }
    }
    .frame(height: 60)
    .foregroundStyle(Color.main)
  }
}

#Preview {
  ButtonView(showHandle: .constant(true))
    .environmentObject(TimerService())
}
