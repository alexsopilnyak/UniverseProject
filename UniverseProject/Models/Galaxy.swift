//
//  Galactic.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation

final class Galaxy {
  
 // typealias GalaxyObjects = NonDestroyable & Destroyable
  
  weak var delegate: UniverseDelegate?
  weak var eventsDelegate: GalaxyEventsDelegate?
  
  let id: String
  var type = GalaxyType.allCases.randomElement()!
  var stellarPlanetSystems = [StellarPlanetSystem]()
  
  
  //lazy var galaxyObjects = [GalaxyCompatible]()
 
  
  lazy var blackHoles = [BlackHole]()
  var age = 0 {
    willSet {
      if newValue % 10 == 0 {
        stellarSystemBorn()
        eventsDelegate?.stellarSystemsCountDidUpdate()
        //print("Somet")
      }
    }
  }
  var weight: Double {
    var totalWeight = 0.0
    stellarPlanetSystems.forEach{totalWeight += $0.weight}
    return totalWeight
  }
  
  init(delegate: UniverseDelegate) {
    self.delegate = delegate
    self.id = "Galaxy_\(type)-\(Int.random(in: 1000...50000)))"
//    print("{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}")
//    print("GALAXY - \(id), TYPE - \(type) == BORN")
  }
  
  init(delegate: UniverseDelegate, type: GalaxyType, age: Int, stellarPlanetSystems: [StellarPlanetSystem]) {
    self.delegate = delegate
    self.type = type
    self.age = age
    self.stellarPlanetSystems = stellarPlanetSystems
    self.id = "Galaxy_\(type)-\(Int.random(in: 1000...50000)))"
//    print("{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}")
//    print("GALAXY - \(id), TYPE - \(type) == BORN")
//    print("==============================================================================")
 }
  
  deinit {
    print("==============================================================================")
    print("GALAXY - \(id), TYPE - \(type), == DESTROYED")
    print("STELLAR SYSTEMS: ")
    eventsDelegate?.galaxyDestroyed()
}
  
  func stellarSystemBorn() {
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
      age += 1
      stellarPlanetSystems.forEach{$0.updateAge()}
      blackHoles.forEach{$0.updateAge()}
    }
}

extension Galaxy: GalaxyDelegate {
  func  blackHoleBornedInStellarSystemWithHostStar(_ stellarSystem: StellarPlanetSystem) {
    
    guard let stellarSystemIndex = stellarPlanetSystems.firstIndex(of: stellarSystem) else { return }
    stellarPlanetSystems.remove(at: stellarSystemIndex)
    let blackHole = BlackHole(id: "BlackHole_\(stellarSystem.id)")
    blackHoles.append(blackHole)
    eventsDelegate?.blackHolesCountDidUpdate()
  }
  
}

