//
//  TimeTracker.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import Foundation

 final class TimeTracker {
  var time = 0 {
    didSet {
      timeDidUpdate?(oldValue)
    }
  }
  var timer: Timer?
  var timeDidUpdate: ((Int) -> Void)?
  
  private var timeInterval: TimeInterval
  
  func start() {
    timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] _ in
      guard let self = self else {return}
      self.time += 1
    })
  }
  
  init(withTimeInterval timeInterval: TimeInterval) {
    self.timeInterval = timeInterval
    start()
  }
  
  func stop() {
    timer?.invalidate()
    timer = nil
  }
}
