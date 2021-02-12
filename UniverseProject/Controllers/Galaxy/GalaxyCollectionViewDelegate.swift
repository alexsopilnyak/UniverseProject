//
//  GalaxyCollectionViewDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 11.02.2021.
//

import UIKit

class GalaxyCollectionViewDelegate: NSObject, UICollectionViewDelegate {
  
  private weak var galaxy: Galaxy?
  private var galaxyDataSource: GalaxyCollectionViewDataSource?
  private var navigationController: UINavigationController?
  
  override init() {}
  
  convenience init(dataSource: GalaxyCollectionViewDataSource, navigationController: UINavigationController) {
    self.init()
    galaxyDataSource = dataSource
    galaxyDataSource?.dataDelegate = self
    self.navigationController = navigationController
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let galaxy = galaxy else { return }
    let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: Constants.stellarSystemsVCid) as! StellarSystemViewController
    destination.stellarSystem = galaxy.stellarPlanetSystems[indexPath.row]
    self.navigationController?.pushViewController(destination, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    guard let cell = cell as? ItemCollectionViewCell else { return }
    guard let galaxy = galaxy else { return }
    
    switch indexPath.section {
    case 0:
      let blackHoleItem = galaxy.blackHoles[indexPath.row]
      cell.configureCell(id: blackHoleItem.id, age: blackHoleItem.age.description, elementsNumber: 0)
      cell.isUserInteractionEnabled = false
    default:
      let stellarSystemItem = galaxy.stellarPlanetSystems[indexPath.row]
      cell.configureCell(id: stellarSystemItem.id, age: stellarSystemItem.age.description, elementsNumber: (stellarSystemItem.planets.count + 1))
    }
  }
}


// MARK:- Extention - DataPassDelegate
extension GalaxyCollectionViewDelegate: DataPassDelegate {
  func passData(data: Any) {
    galaxy = data as? Galaxy
  }
}


