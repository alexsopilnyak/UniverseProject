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
      if newValue % 60 == 0 {
        self.evolve(currentStage: self.evolutionStage)
      }
    }
  }
  
  let id: String
  private var evolutionStage = EvolutionStage.youngStar
  private var luminosity = Double.random(in: Constants.luminosityRange)
  var type = StarType.allCases.randomElement()!
  var temperature = Double.random(in: Constants.temperatureRange)
  var radius = Double.random(in: Constants.radiusRange)
  var weight = Double.random(in: Constants.weightRange)
 
  
  
  init(delegate: StellarPlanetSystemDelegate) {
    self.delegate = delegate
    self.id = "Star_\(type)-\(String(format: "%.3f", weight * radius))"
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

