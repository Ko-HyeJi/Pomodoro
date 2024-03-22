//
//  CircleTimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI

struct CircleTimerView: View {
  @EnvironmentObject var timer: TimerService
  @EnvironmentObject var orientation: OrientationManager
  let haptic = UISelectionFeedbackGenerator()
  
  var body: some View {
    ZStack {
      backgroundLayer
      ClockProgressView()
      GeometryReader { geometry in
        ClockLabelView(geometry: geometry)
        HandleView(geometry: geometry)
      }
      centerCircle
        .onTapGesture { centerCircleAction() }
    }
    .frame(width: orientation.screenSize * 0.76, height: orientation.screenSize * 0.76)
    .onChange(of: timer.counter) {
      if timer.state != .running {
        haptic.selectionChanged()
        if timer.counter != 0 {
          timer.latestSetTime = timer.counter
        }
      }
    }
  }
}

private extension CircleTimerView {
  private var backgroundLayer: some View {
    Group {
      Circle()
        .foregroundStyle(Color.main)
        .softOuterShadow(darkShadow: .darkShadow, lightShadow: .lightShadow)
      Rectangle()
        .foregroundStyle(Color(UIColor.systemBackground).opacity(0.3))
        .frame(width: 0.5, height: orientation.screenSize * 0.38)
        .offset(y: -orientation.screenSize * 0.18)
        .shadow(color: .darkShadow, radius: -0.5, x: 1.5)
    }
  }

  private var centerCircle: some View {
    Circle()
      .foregroundStyle(Color.main)
      .frame(width: orientation.screenSize * 0.15)
      .shadow(color: .darkShadow, radius: 2, x: 2, y: 2)
  }
  
  private func centerCircleAction() {
    if timer.state != .running {
      withAnimation {
        if timer.counter == 0 {
          timer.set(to: timer.latestSetTime)
        } else {
          timer.set(to: 0)
        }
      }
    }
  }
}

#Preview {
  CircleTimerView()
    .environmentObject(TimerService())
    .environmentObject(OrientationManager())
}
