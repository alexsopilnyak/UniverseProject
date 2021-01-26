//
//  StellarSystemEventsDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 23.01.2021.
//

import Foundation

protocol StellarSystemEventsDelegate: AnyObject {
  func planetsCountDidUpdate()
  func stellarSystemDestroyed()
  
}
