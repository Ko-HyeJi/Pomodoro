//
//  TimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/29/24.
//

import SwiftUI
import Neumorphic

struct TimerView: View {
  let geometry: GeometryProxy
  @Binding var selectedSecond: Int
  @State private var dragOffset: CGFloat = 0
  @Binding var showHandle: Bool
  
  var body: some View {
    let percentage: CGFloat = CGFloat(selectedSecond) / 3600
    
    let stick = RoundedRectangle(cornerRadius: 100)
      .shadow(color: .darkShadow, radius: 2, x: 2, y: 2)
      .frame(width: geometry.size.width * 0.015, height: geometry.size.width * 0.1)
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
        let minute = (newDragOffset / 360 * 60).rounded()
        if abs(newDragOffset - dragOffset) <= 180 {
          dragOffset = newDragOffset
          selectedSecond = Int(minute * 60)
        }
      })
  }
}
