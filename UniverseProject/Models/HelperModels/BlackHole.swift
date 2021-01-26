//
//  BlackHole.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 21.01.2021.
//

import Foundation

final class BlackHole: Identifiable {
  let id: String
  var age = 0
  
  init(id: String) {
    self.id = id
  }
}


extension BlackHole: AgeUpdator {
  func updateAge() {
      self.age += 1
  }
}

