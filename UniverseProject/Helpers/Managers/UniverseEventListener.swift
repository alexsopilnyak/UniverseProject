//
//  UniverseEventListener.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import Foundation

protocol UniverseEventListener: AnyObject {
  func galaxiesNumberChange()
  func universeChangeState()

  
}
