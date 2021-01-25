//
//  Star.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation

final class Star: CelesticalBody {
  
  weak var delegate: StellarPlanetSystemDelegate?
  
  var age = 0 {
    willSet {
      if newValue % 10 == 0 {
        evolve(currentStage: evolutionStage)
      }
    }
  }
  let id: String
  var evolutionStage = EvolutionStage.youngStar

  var type = StarType.allCases.randomElement()!
  var temperature = Double.random(in: Constants.temperatureRange)
  var radius = Double.random(in: Constants.radiusRange)
  var weight = Double.random(in: Constants.weightRange)
  var luminosity = Double.random(in: Constants.luminosityRange)
  
  
  init(delegate: StellarPlanetSystemDelegate) {
    self.delegate = delegate
    self.id = "Star_\(type)-\(String(format: "%.3f", weight * radius))"
  }
  
  deinit {
//    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
//    print("STAR - \(id),TYPE - \(type), WEIGHT - \(weight), RADIUS - \(radius) == DESTROYED")
  }
  
  private func evolve(currentStage: EvolutionStage) {
    guard evolutionStage != .blackHole else { return }
    
    switch currentStage {
    case .youngStar:
      evolutionStage = .oldStar
    case .oldStar:
      if radius >= Universe.limitRadius && weight >= Universe.limitWeight {
        evolutionStage = .blackHole
        delegate?.starBecomeBlackHole()
      } else {
        evolutionStage = .denseDwarf
      }
    default: break

    }
    
  }
  
}


//MARK:- Extensions


extension Star: AgeUpdator {
  func updateAge() {
    age += 1
  }
  
  
}

