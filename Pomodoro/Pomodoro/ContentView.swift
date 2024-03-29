//
//  ContentView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI
import Neumorphic

struct ContentView: View {
  @EnvironmentObject var timer: TimerService
  @EnvironmentObject var orientation: OrientationManager
  
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
  }
}

extension ContentView {
  private var portraitView: some View {
    HStack {
      Spacer()
      VStack {
        Spacer()
        TextTimerView()
        Spacer()
        CircleTimerView()
        Spacer()
        ButtonView()
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
        CircleTimerView()
          .padding(orientation.screenSize * 0.08)
        Spacer()
        VStack(spacing: 30) {
          TextTimerView()
          ButtonView()
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
  ContentView()
    .environmentObject(TimerService())
    .environmentObject(OrientationManager())
}
