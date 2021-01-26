//
//  Universe.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation
final class Universe {
  
  let id = "\(String(describing: Universe.self))_\(Universe.limitWeight * Universe.limitRadius)"
  
  static let limitWeight = Double.random(in: Constants.limitWeightRange)
  static let limitRadius = Double.random(in: Constants.limitRadiusRange)
  
  weak var eventsDelegate: UniverseEventsDelegate?
  
  private var timer: TimeTracker?
  
  lazy var galaxies = [Galaxy]()
  
  private var time = 0 {
    willSet {
      self.galaxies.forEach{$0.updateAge()}
      
      if newValue % 10 == 0 {
        self.galaxyBorn()
        self.eventsDelegate?.galaxiesCountDidUpdate()
      }
      if newValue % 30 == 0 {
        self.collapse()
      }
    }
  }
  
  var age = 0
  
  
  init(timer: TimeTracker) {
    self.timer = timer
    timer.timeDidUpdate = { [weak self] time in
      guard let self = self else { return }
      self.time = time
      print("Time: \(time)")
    }
  }
  
  deinit {
    timer?.stop()
  }
  
  private func galaxyBorn() {
    let galaxy = Galaxy()
    self.galaxies.append(galaxy)
  }
  
  private func collapse()  {
    guard galaxies.count > 2 else {return}
    let filteredGalaxies = galaxies.filter{ $0.age > Constants.filterGalaxyAge }
    
    guard filteredGalaxies.count > 2 else { return }
    
    let planetsInRandonOrder = filteredGalaxies.shuffled()
    
    guard let firstGalaxy = planetsInRandonOrder.first else { return }
    guard let secondGalaxy = planetsInRandonOrder.last else { return }
    guard let firstGalaxyIndex = galaxies.firstIndex(of: firstGalaxy) else {return}
    guard let secondGalaxyIndex = galaxies.firstIndex(of: secondGalaxy) else {return}
    
    galaxies.remove(at: firstGalaxyIndex)
    
    let newGalaxy =  mergeGalaxies(firstGalaxy, secondGalaxy)
    galaxies.insert(newGalaxy, at: firstGalaxyIndex)
    galaxies.remove(at: secondGalaxyIndex)
    
  }
  
  private func mergeGalaxies(_ first:  Galaxy, _ second:  Galaxy) -> Galaxy  {
    let allStellarSystems = first.stellarPlanetSystems + second.stellarPlanetSystems
    let newStellarSystems = someStellarSystemsToDestroy(allStellarSystems)
    
    if first.weight > second.weight {
      return Galaxy(type: first.type, age: first.age, stellarPlanetSystems: newStellarSystems)
    } else {
      return Galaxy(type: second.type, age: second.age, stellarPlanetSystems: newStellarSystems)
    }
  }
  
  
  private func someStellarSystemsToDestroy(_ allStellarSystems: [StellarPlanetSystem]) -> [StellarPlanetSystem] {
    
    switch allStellarSystems.count {
    case 0: return [StellarPlanetSystem]()
    case 1: return allStellarSystems
    case 2...10:
      var newSystems = allStellarSystems.shuffled()
      newSystems.removeLast()
      return newSystems
      
    default:
      let numberSystemsToDestroy = Int(((Double(allStellarSystems.count * Constants.percentSystemToDestroy)) / 100.0).rounded())
      var newSystems = allStellarSystems.shuffled()
      for _ in 1...numberSystemsToDestroy {
        newSystems.removeLast()
      }
      
      return newSystems
    }
  }
}







