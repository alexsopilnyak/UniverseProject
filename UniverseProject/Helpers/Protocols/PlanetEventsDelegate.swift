//
//  PlanetEventsDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 25.01.2021.
//

import Foundation

protocol PlanetEventsDelegate: AnyObject {
  func planetDestroyed()
  func ageUpdated()
}
