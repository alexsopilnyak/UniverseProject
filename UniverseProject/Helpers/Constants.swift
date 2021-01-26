//
//  Constants.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation

struct Constants {
  static let temperatureRange = 1.0...100.0
  static let radiusRange = 1.0...100.0
  static let weightRange = 1.0...100.0
  static let luminosityRange = 1.0...100.0
  
  static let limitWeightRange = 90.0...100.0
  static let limitRadiusRange = 80.0...100.0
  
  static let satellitesMaxNumber = 5
  static let planetsMaxNumber = 9
  
  static let filterGalaxyAge = 180
  static let idRange = 1.0...500000.0
  static let percentSystemToDestroy = 10
  
  static let cellID = "ItemCollectionViewCell"
  
  static let galaxyVCid = "GalaxyViewController"
  static let stellarSystemsVCid = "StellarSystemViewController"
  static let planetVCid = "PlanetViewController"
  
  static let storyboardName = "Main"
}
