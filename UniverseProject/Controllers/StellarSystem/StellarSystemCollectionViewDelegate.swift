//
//  StellarSystemCollectionViewDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 12.02.2021.
//

import UIKit

class StellarSystemCollectionViewDelegate: NSObject, UICollectionViewDelegate {
  private weak var stellarSystem: StellarPlanetSystem?
  
  private var stellarSystemDataSource: StellarSystemCollectionViewDataSource?
  private var navigationController: UINavigationController?
  
  override init() {}
  
  convenience init(dataSource: StellarSystemCollectionViewDataSource, navigationController: UINavigationController) {
    self.init()
    
    stellarSystemDataSource = dataSource
    stellarSystemDataSource?.dataDelegate = self
    self.navigationController = navigationController
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let stellarSystem = stellarSystem else { return }
    
    let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: Constants.planetVCid) as! PlanetViewController
    
    destination.planet = stellarSystem.planets[indexPath.row]
    navigationController?.pushViewController(destination, animated: true)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? ItemCollectionViewCell else { return }
    guard let stellarSystem = stellarSystem else { return }
    let planet = stellarSystem.planets[indexPath.row]
    
    cell.configureCell(id: planet.id, age: planet.age.description, elementsNumber: planet.satellites?.count ?? 0)
  }
  
}


// MARK:- Extention - UICollectionViewDelegateFlowLayout
extension StellarSystemCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
}

// MARK:- Extention - DataPassDelegate
extension StellarSystemCollectionViewDelegate: DataPassDelegate {
  func passData(data: Any) {
    stellarSystem = data as? StellarPlanetSystem
  }
}
