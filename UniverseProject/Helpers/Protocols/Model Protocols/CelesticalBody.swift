//
//  CelesticalBody.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import Foundation

protocol CelesticalBody {
  associatedtype CelesticalBodyType
  
  var type: CelesticalBodyType { get }
  var temperature: Double { get }
  var radius: Double { get }
  var age: Int {get set}
  var weight: Double { get }
  
}
