//
//  ClockView.swift
//  Pomodoro
//
//  Created by 고혜지 on 2/29/24.
//

import SwiftUI
import Neumorphic

struct ClockView: View {
  @State private var selectedSecond: Int = 0
  
  var body: some View {
    VStack {
      Text("Selected second: \(selectedSecond)")
      Spacer()
      GeometryReader { geometry in
        Hand(geometry: geometry, selectedSecond: $selectedSecond)
      }
      Spacer()
    }
  }
}

struct Hand: View {
  let geometry: GeometryProxy
  @Binding var selectedSecond: Int
  @State private var dragOffset: CGFloat = 0
  
  var body: some View {
    let percentage: CGFloat = CGFloat(selectedSecond) / 3600
    let color: Color = Color.Neumorphic.main
    
    Circle()
      .fill(color)
      .softInnerShadow(Circle())
      .frame(width: 30, height: 30)
      .offset(y: -geometry.size.width / 2)
      .rotationEffect(.degrees(Double(percentage) * 360))
      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
      .gesture(DragGesture(minimumDistance: 0)
        .onChanged { value in
          let vector = CGVector(dx: value.location.x - geometry.size.width / 2, dy: value.location.y - geometry.size.height / 2)
          let angle = atan2(vector.dx, vector.dy) * 180 / .pi
          dragOffset = 360 - (angle - 180)
          if dragOffset >= 360 { dragOffset -= 360 }
          let minute = (dragOffset / 360 * 60).rounded()
          selectedSecond = Int(minute * 60)
        })
  }
}

#Preview {
  ClockView()
}
