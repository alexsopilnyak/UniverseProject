//
//  Satellite.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 15.01.2021.
//

import Foundation

final class Satellite: CelesticalBody {
  
  weak var hostPlanet: Planet?
  let id: String
  var type = PlanetType.allCases.randomElement()!
  var age = 0
  var weight = Double.random(in: Constants.weightRange)
  var temperature = Double.random(in: Constants.temperatureRange)
  var radius = Double.random(in: Constants.radiusRange)
  
  init(hostPlanet: Planet) {
    self.hostPlanet = hostPlanet
    self.id = "Satellite_\(type)-\(String(format: "%.3f", weight * radius))"
//    print("==============================================================================")
//    print("SATELLITE - \(id), HOST - \(hostPlanet.id), WEIGHT - \(weight), RADIUS - \(radius) == BORN")
  }
  
  deinit {
//    print("________________________________________________________________________________________________________")
//    print("SATELLITE - \(id) == DESTROYED")
  }
}

//MARK:- Extensions


extension Satellite: AgeUpdator {
  func updateAge() {
    age += 1
  }
}
