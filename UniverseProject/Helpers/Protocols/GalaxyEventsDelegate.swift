//
//  GalaxyEventsDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 23.01.2021.
//

import Foundation

protocol GalaxyEventsDelegate: AnyObject {
  func galaxyElementsCountDidUpdate()
  func galaxyDestroyed()
}
