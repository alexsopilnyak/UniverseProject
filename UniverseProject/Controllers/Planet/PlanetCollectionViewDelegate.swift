//
//  PlanetCollectionViewDelegate.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 12.02.2021.
//

import UIKit

class PlanetCollectionViewDelegate: NSObject, UICollectionViewDelegate {
  private weak var planet: Planet?
  
  private var planetDataSource: PlanetCollectionViewDataSource?
  private var navigationController: UINavigationController?
  
  override init() {}
  
  convenience init(dataSource: PlanetCollectionViewDataSource, navigationController: UINavigationController) {
    self.init()
    planetDataSource = dataSource
    planetDataSource?.dataDelegate = self
    self.navigationController = navigationController
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? ItemCollectionViewCell else { return }
    guard let satellite = planet?.satellites?[indexPath.row] else {
      cell.configureCell(id: "Satelistes is absent", age: "", elementsNumber: 0)
      return
    }
    cell.configureCell(id: satellite.id, age: satellite.age.description, elementsNumber: 0)
  }
}


//MARK:- Extension - UICollectionViewDelegateFlowLayout
extension PlanetCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
}

//MARK:- Extension - DataPassDelegate
extension PlanetCollectionViewDelegate: DataPassDelegate {
  
  func passData(data: Any) {
    planet = data as? Planet
  }
}
