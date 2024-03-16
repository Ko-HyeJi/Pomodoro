//
//  HandleView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/29/24.
//

import SwiftUI
import Neumorphic

struct HandleView: View {
  @EnvironmentObject var timer: TimerService
  @Binding var showHandle: Bool
  @State private var dragOffset: CGFloat = 0
  @State private var minute: Int = 0
  let geometry: GeometryProxy
  
  var body: some View {
    let percentage: CGFloat = CGFloat(timer.counter) / 3600
    
    let stick = RoundedRectangle(cornerRadius: 100)
      .shadow(color: .darkShadow, radius: 2, x: 2, y: 2)
      .frame(width: geometry.size.width * 0.03, height: geometry.size.width * 0.1)
      .offset(y: -geometry.size.width * 0.14)
      .foregroundStyle(Color.main)
    
    let handle = Circle()
      .foregroundStyle(Color.accentColor)
      .frame(maxWidth: 50)
      .frame(width: geometry.size.width * 0.11)
      .offset(y: -geometry.size.width / 2)
      .shadow(radius: 1)
    
    return Group {
      if showHandle {
        handle
      }
      stick
    }
    .rotationEffect(.degrees(Double(percentage) * 360))
    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    .gesture(DragGesture(minimumDistance: 0)
      .onChanged { value in
        let vector = CGVector(dx: value.location.x - geometry.size.width / 2, dy: value.location.y - geometry.size.height / 2)
        let angle = atan2(vector.dx, vector.dy) * 180 / .pi
        var newDragOffset = 360 - (angle - 180)
        if newDragOffset >= 360 { newDragOffset -= 360 }
        dragOffset = newDragOffset
        minute = Int((newDragOffset / 360 * 60).rounded())
        if timer.state != .running {
          timer.set(to: minute * 60)
        }
      })
  }
}

#Preview {
  GeometryReader { geometry in
    HandleView(showHandle: .constant(true), geometry: geometry)
      .environmentObject(TimerService())
  }
  .background(Circle().foregroundStyle(.green))
  .frame(width: UIScreen.main.bounds.width * 0.76)
}
