//
//  GalaxyEventListener.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import Foundation
protocol GalaxyEventListener: AnyObject {
  func stellarSystemNumberChange()
  func galaxyStateChange()

  
}
