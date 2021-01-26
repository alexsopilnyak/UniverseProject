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
    timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerUpdates), userInfo: nil, repeats: true)
    RunLoop.main.add(timer!, forMode: .common)
  }
  
  init(withTimeInterval timeInterval: TimeInterval) {
    self.timeInterval = timeInterval
    start()
  }
  
  func stop() {
    timer?.invalidate()
    timer = nil
  }
  
  @objc func timerUpdates() {
    time += 1
  }
}
