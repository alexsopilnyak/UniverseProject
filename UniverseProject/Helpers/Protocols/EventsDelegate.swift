//
//  EventsDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 11.02.2021.
//

import Foundation


protocol EventsDelegate: AnyObject {
  func elementDidUpdate()
  func elementDestroyed()
}
