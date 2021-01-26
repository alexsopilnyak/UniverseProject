//
//  Planet.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation

final class Planet: CelesticalBody {
  weak var delegate: StellarPlanetSystemDelegate?
  weak var eventsDelegate: PlanetEventsDelegate?
  
  let hostStar: Star
  let id: String
  var type = PlanetType.allCases.randomElement()!
  var satellites: [Satellite]?
  
  var age = 0 {
    willSet{
      guard newValue % 10 == 0 else { return }
        self.eventsDelegate?.ageUpdated()
      }
  }
  
  var weight = Double.random(in: Constants.weightRange)
  var temperature = Double.random(in: Constants.temperatureRange)
  var radius = Double.random(in: Constants.radiusRange)
  
  init(delegate: StellarPlanetSystemDelegate, star: Star) {
    self.delegate = delegate
    self.hostStar = star
    self.id = "Planet_\(type)-\(String(format: "%.3f", weight * radius))"
    spawnSatellites()
  }
  
  deinit {
    eventsDelegate?.planetDestroyed()
  }
  
  private func spawnSatellites() {
    let numberOfSatellites = Int.random(in: 0...Constants.satellitesMaxNumber)
    var satellites = [Satellite]()
    
    guard numberOfSatellites != 0 else { return }
    
    for _ in 1...numberOfSatellites {
      satellites.append(Satellite(hostPlanet: self))
    }
    self.satellites = satellites
  }
  
}

//MARK:- Extensions


extension Planet: AgeUpdator {
  func updateAge() {
    age += 1
    satellites?.forEach{$0.updateAge()}
  }
}




