//
//  StellarPlanetSystem.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation



final class StellarPlanetSystem {
  
  weak var delegate: GalaxyDelegate?
  weak var eventsDelegate: StellarSystemEventsDelegate?
  
  var hostStar: Star?
  lazy var planets =  [Planet]()
  
  var age = 0 {
    willSet {
      if newValue % 10 == 0 {
        spawnPlanet()
        eventsDelegate?.planetsCountDidUpdate()
      }
    }
  }
  
  var weight: Double {
    var totalWeight = hostStar!.weight
    planets.forEach{ totalWeight += $0.weight}
    return totalWeight
  }
  let id = "StellarSystem_\(Int.random(in: 4000...6000)))"
//  var containsBlackHole = false
  
  
  
  
  init(delegate: GalaxyDelegate) {
    self.delegate = delegate
    self.hostStar = createNewStar()
  }
  
  deinit {
   // print("\(id) destroyed")
  }
  

  func spawnPlanet() {
    guard planets.count < Constants.planetsMaxNumber else { return }
    planets.append(Planet(delegate: self, star: hostStar!))
  }
  
  
  private func createNewStar() -> Star {
    Star(delegate: self)
  }
  
//  func starEvolveToBlackHole() {
//    containsBlackHole = true
//    planets = []
//  }
  
}

//MARK:- Extensions

extension StellarPlanetSystem: AgeUpdator {
  func updateAge() {
    age += 1
    hostStar?.updateAge()
    planets.forEach{$0.updateAge()}
  }
}

extension StellarPlanetSystem: Equatable {
  static func == (lhs: StellarPlanetSystem, rhs: StellarPlanetSystem) -> Bool {
    lhs.id == rhs.id
  }
  
  
}

extension StellarPlanetSystem: StellarPlanetSystemDelegate {
  func starBecomeBlackHole() {
    planets = []
    delegate?.blackHoleBornedInStellarSystemWithHostStar(self)
  }
}

//extension StellarPlanetSystem: Destroyable {}



