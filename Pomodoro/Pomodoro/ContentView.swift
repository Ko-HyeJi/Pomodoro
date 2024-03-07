//
//  ContentView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI

struct ContentView: View {
  let notificationService = NotificationService.shared
  
  var body: some View {
    ClockView()
      .onAppear {
        notificationService.requestAuthorization()
      }
  }
}

#Preview {
  ContentView()
}
