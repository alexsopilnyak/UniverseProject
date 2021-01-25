//
//  UniverseEventsDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import Foundation

protocol UniverseEventsDelegate: AnyObject {
  func galaxiesCountDidUpdate(galaxies: [Galaxy])
  func stellarSystemsCountDidUpdate()
  func plantesCountDidUpdate()
  func blackHoleCreated()
}
