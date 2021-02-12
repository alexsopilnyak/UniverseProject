//
//  PlanetsCollectionViewDataSource.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 12.02.2021.
//

import UIKit

class PlanetCollectionViewDataSource: NSObject, UICollectionViewDataSource {
  
  private weak var planet: Planet?
  weak var dataDelegate: DataPassDelegate?
  
  override init() {}
  
  convenience init(planet: Planet) {
    self.init()
    self.planet = planet
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let planet = planet else { return 0 }
    return planet.satellites?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    guard let planet = planet else { return cell }
    dataDelegate?.passData(data: planet)
    return cell
  }
  
}

