//
//  StellarSystemEventListener.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import Foundation
protocol StellarSystemEventListener: AnyObject {
  func stellarSystemChangeState()
  func planetsNumberChange()
  func hostStarEvoluteToBlackHole()

  
}
