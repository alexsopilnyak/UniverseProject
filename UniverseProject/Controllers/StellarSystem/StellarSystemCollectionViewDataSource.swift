//
//  StellarSystemCollectionViewDataSource.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 12.02.2021.
//

import UIKit

class StellarSystemCollectionViewDataSource: NSObject, UICollectionViewDataSource {
  private weak var stellarSystem: StellarPlanetSystem?
  weak var dataDelegate: DataPassDelegate?
  
  override init() {}
  
  convenience init(stellarSystem: StellarPlanetSystem) {
    self.init()
    self.stellarSystem = stellarSystem
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let stellarSystem = stellarSystem else { return 0}
    return stellarSystem.planets.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    guard let stellarSystem = stellarSystem else { return cell }
    dataDelegate?.passData(data: stellarSystem)
    return cell
  }
  
}
