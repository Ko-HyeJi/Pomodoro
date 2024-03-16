//
//  OrientationManager.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

final class OrientationManager {
  let screenSize = UIScreen.main.bounds.width
  
  func state(_ geometry: GeometryProxy) -> Orientation {
    if geometry.size.width < geometry.size.height {
      return Orientation.portrait
    } else {
      return Orientation.landscape
    }
  }
  
  enum Orientation {
    case portrait
    case landscape
  }
}
