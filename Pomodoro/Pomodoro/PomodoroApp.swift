//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/23/24.
//

import SwiftUI

@main
struct PomodoroApp: App {
  @StateObject var timer = TimerService.shared
  @Environment(\.scenePhase) private var scenePhase
  let scenePhaseManager = ScenePhaseManager()
  let notification = NotificationService.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear { notification.requestAuthorization() }
    }
    .environmentObject(timer)
    .onChange(of: scenePhase) {
      scenePhaseManager.action(scenePhase)
    }
  }
}
