//
//  Galactic.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation

final class Galaxy {

  weak var eventsDelegate: EventsDelegate?
  
  let id: String
  var type = GalaxyType.allCases.randomElement()!
  var stellarPlanetSystems = [StellarPlanetSystem]()
  
  lazy var blackHoles = [BlackHole]()
  
  var age = 0 {
    willSet {
      if newValue % 10 == 0 {
        stellarSystemBorn()
        eventsDelegate?.elementDidUpdate()
      }
    }
  }
  
  var weight: Double {
    var totalWeight = 0.0
    stellarPlanetSystems.forEach{totalWeight += $0.weight}
    return totalWeight
  }
  
  init() {
    self.id = "Galaxy_\(type)-\(Double.random(in: Constants.idRange))"
  }
  
  init(type: GalaxyType, age: Int, stellarPlanetSystems: [StellarPlanetSystem]) {

    self.type = type
    self.age = age
    self.stellarPlanetSystems = stellarPlanetSystems
    self.id = "Galaxy_\(type)-\(Double.random(in: Constants.idRange)))"
 }
  
  deinit {
    eventsDelegate?.elementDestroyed()
}
  
  private func stellarSystemBorn() {
    let newStellarSystem = StellarPlanetSystem(delegate: self)
    stellarPlanetSystems.append(newStellarSystem)
  }
}


//MARK:- Extensions


extension Galaxy: Equatable {
  static func ==(lhs: Galaxy, rhs: Galaxy) -> Bool {
    return lhs.id == rhs.id
  }
}

extension Galaxy: AgeUpdator {
    func updateAge() {
      
        self.age += 1
        self.stellarPlanetSystems.forEach{$0.updateAge()}
        self.blackHoles.forEach{$0.updateAge()}
      
    }
}

extension Galaxy: GalaxyDelegate {
  func  blackHoleBornedInStellarSystemWithHostStar(_ stellarSystem: StellarPlanetSystem) {
    
    guard let stellarSystemIndex = stellarPlanetSystems.firstIndex(of: stellarSystem) else { return }
    stellarPlanetSystems.remove(at: stellarSystemIndex)
    let blackHole = BlackHole(id: "BlackHole_\(stellarSystem.id)")
    blackHoles.append(blackHole)
    eventsDelegate?.elementDidUpdate()
  }
  
}

