//
//  ContentView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var timer: TimerService
  @State var showHandle = true
  @State var UIWidth = UIScreen.main.bounds.width
  let orientation = OrientationManager()
  
  var body: some View {
    GeometryReader { geometry in
      switch orientation.state(geometry) {
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
        CircleTimerView(showHandle: $showHandle, UIWidth: $UIWidth)
        Spacer()
        ButtonView(showHandle: $showHandle)
          .frame(maxWidth: 500)
          .frame(width: UIWidth * 0.76)
        Spacer()
      }
      Spacer()
    }
    .onAppear { UIWidth = UIScreen.main.bounds.width }
  }
  
  private var landscapeView: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        CircleTimerView(showHandle: $showHandle, UIWidth: $UIWidth)
          .padding(UIWidth * 0.08)
        Spacer()
        VStack(spacing: 30) {
          TextTimerView()
          ButtonView(showHandle: $showHandle)
            .frame(maxWidth: 300)
            .frame(width: UIWidth * 0.4)
        }
        Spacer()
      }
      Spacer()
    }
    .ignoresSafeArea()
    .onAppear { UIWidth = UIScreen.main.bounds.height }
  }
}

#Preview {
  ContentView()
    .environmentObject(TimerService())
}
