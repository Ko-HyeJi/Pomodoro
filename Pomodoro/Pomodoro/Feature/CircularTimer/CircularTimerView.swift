//
//  CircularTimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI

struct CircularTimerView: View {
  @EnvironmentObject private var timer: TimerService
  @EnvironmentObject private var orientation: OrientationManager
  private var viewModel = CircularTimerViewModel()
  
  var body: some View {
    ZStack {
      backgroundLayer
      ProgressView()
      GeometryReader { geometry in
        ScaleView(geometry: geometry)
        HandleView(geometry: geometry)
      }
      centerCircle
        .onTapGesture { viewModel.centerCircleAction() }
    }
    .frame(width: orientation.screenSize * 0.76, height: orientation.screenSize * 0.76)
    .onChange(of: timer.counter) { viewModel.saveTimeAndGenerateHaptic() }
  }
}

private extension CircularTimerView {
  private var backgroundLayer: some View {
    Group {
      Circle()
        .foregroundStyle(Color.main)
        .outerShadow()
//        .softOuterShadow(
//          darkShadow: .darkShadow,
//          lightShadow: .lightShadow
//        )
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
}

#Preview {
  CircularTimerView()
    .environmentObject(TimerService())
    .environmentObject(OrientationManager())
}
