//
//  GalaxyCollectionViewDataSource.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 11.02.2021.
//

import UIKit

class GalaxyCollectionViewDataSource: NSObject, UICollectionViewDataSource {
  
  private weak var galaxy: Galaxy?
  weak var dataDelegate: DataPassDelegate?
  
  override init() {}
  
  convenience init(galaxyData: Galaxy) {
    self.init()
    galaxy = galaxyData
  }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
     2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let galaxy = galaxy else { return 0 }
    
    switch section {
    case 0:
      return galaxy.blackHoles.count
    default:
      return galaxy.stellarPlanetSystems.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    guard let galaxy = galaxy else { return cell }
    dataDelegate?.passData(data: galaxy)
    return cell
  }
  
}
