//
//  StellarPlanetSystem.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation


final class StellarPlanetSystem {
  
  weak var delegate: GalaxyDelegate?
  weak var eventsDelegate: EventsDelegate?
  
  var hostStar: Star?
  lazy var planets =  [Planet]()
  let id = "StellarSystem_\(Double.random(in: Constants.idRange))"
  var age = 0 {
    willSet {
      if newValue % 10 == 0 {
        spawnPlanet()
        eventsDelegate?.elementDidUpdate()
        
      }
    }
  }
  
    var weight: Double {
    var totalWeight = hostStar!.weight
    planets.forEach{ totalWeight += $0.weight}
    return totalWeight
  }
  
  
  init(delegate: GalaxyDelegate) {
    self.delegate = delegate
    self.hostStar = createNewStar()
  }
  
  deinit {
    eventsDelegate?.elementDestroyed()
  }
  

  private func spawnPlanet() {
    guard planets.count < Constants.planetsMaxNumber else { return }
    planets.append(Planet(delegate: self, star: hostStar!))
  }
  
  
  private func createNewStar() -> Star {
    Star(delegate: self)
  }
  
  
}

//MARK:- Extensions

extension StellarPlanetSystem: AgeUpdator {
  func updateAge() {
      self.age += 1
      self.planets.forEach{$0.updateAge()}
      self.hostStar?.updateAge()
    
  }
}

extension StellarPlanetSystem: Equatable {
  static func == (lhs: StellarPlanetSystem, rhs: StellarPlanetSystem) -> Bool {
    lhs.id == rhs.id
  }
}

extension StellarPlanetSystem: StellarPlanetSystemDelegate {
  func starBecomeBlackHole() {
    delegate?.blackHoleBornedInStellarSystemWithHostStar(self)
    planets = []
    
  }
}





