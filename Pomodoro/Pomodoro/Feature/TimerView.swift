//
//  TimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI
import Neumorphic

struct TimerView: View {
  @EnvironmentObject private var timer: TimerService
  @EnvironmentObject private var orientation: OrientationManager
  @FocusState private var focusedField: UUID?
  
  var body: some View {
    GeometryReader { geometry in
      switch orientation.currentState(geometry) {
      case .portrait:
        portraitView
      case .landscape:
        landscapeView
      }
    }
    .ignoresSafeArea()
    .background { Color.main.ignoresSafeArea() }
    .overlay {
      if focusedField != nil {
        Color.white.opacity(0.001)
          .onTapGesture { focusedField = nil }
      }
    }
  }
}

extension TimerView {
  private var portraitView: some View {
    HStack {
      Spacer()
      VStack {
        Spacer()
        TextTimerView(focusedField: _focusedField)
        Spacer()
        CircularTimerView()
        Spacer()
        ControlButtonView()
          .frame(maxWidth: 500)
          .frame(width: orientation.screenSize * 0.76)
        Spacer()
      }
      Spacer()
    }
  }
  
  private var landscapeView: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        CircularTimerView()
          .padding(orientation.screenSize * 0.08)
        Spacer()
        VStack(spacing: 30) {
          TextTimerView(focusedField: _focusedField)
          ControlButtonView()
            .frame(maxWidth: 300)
            .frame(width: orientation.screenSize * 0.4)
        }
        Spacer()
      }
      Spacer()
    }
  }
}

#Preview {
  TimerView()
    .environmentObject(TimerService())
    .environmentObject(OrientationManager())
}
