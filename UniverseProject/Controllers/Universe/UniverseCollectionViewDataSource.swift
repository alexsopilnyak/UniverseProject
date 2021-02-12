//
//  UniverseCollectionViewDataSource.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 09.02.2021.
//

import UIKit

class UniverseCollectionViewDataSource: NSObject, UICollectionViewDataSource {
  
  private weak var universe: Universe?
  weak var dataDelegate: DataPassDelegate?
  
  override init() {}
  
  convenience init(universeData: Universe) {
    self.init()
    universe = universeData
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let galaxies = universe?.galaxies else { return 0 }
    return galaxies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    guard let universe = universe else { return cell }
    dataDelegate?.passData(data: universe)
    return cell
  }
}

