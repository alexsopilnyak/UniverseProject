//
//  UniverseCollectionViewDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 09.02.2021.
//

import UIKit

class UniverseCollectionViewDelegate: NSObject, UICollectionViewDelegate {
  private weak var universe: Universe?
  private var universeDataSource: UniverseCollectionViewDataSource?
  private var navigationController: UINavigationController?
  
  override init() {}
  
  convenience init(dataSource: UniverseCollectionViewDataSource, navigationController: UINavigationController) {
    self.init()
    
    self.navigationController = navigationController
    universeDataSource = dataSource
    universeDataSource?.dataDelegate = self
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let galaxies = universe?.galaxies else { return }
    let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: Constants.galaxyVCid) as! GalaxyViewController
   
    destination.galaxy = galaxies[indexPath.row]
    self.navigationController?.pushViewController(destination, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? ItemCollectionViewCell else { return }
    guard let galaxy = universe?.galaxies[indexPath.row] else { return }
    cell.configureCell(id: galaxy.id, age: galaxy.age.description, elementsNumber: galaxy.stellarPlanetSystems.count + galaxy.blackHoles.count)
  }
}


// MARK:- Extention - DataPassDelegate
extension UniverseCollectionViewDelegate: DataPassDelegate {
  func passData(data: Any) {
    universe = data as? Universe
  }
}

// MARK:- Extention - UICollectionViewDelegateFlowLayout
extension UniverseCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
}
