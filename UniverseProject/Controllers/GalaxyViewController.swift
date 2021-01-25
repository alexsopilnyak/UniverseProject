//
//  ViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 14.01.2021.
//

import UIKit

class GalaxyViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  weak var galaxy: Galaxy?
  var sections: [Int: [AnyObject]] = [:]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    galaxy!.eventsDelegate = self
   navigationItem.title = galaxy!.id

    collectionView.dataSource = self
    collectionView.delegate = self
    sections[0] = galaxy!.blackHoles
    sections[1] = galaxy!.stellarPlanetSystems
    
    
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.collectionViewLayout = createCompositionalLayout()
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
   
    
    
    collectionView.backgroundColor = .systemTeal
    
  }
  
  func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout {  (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      let section = self.sections[sectionIndex]
      
      switch section {
      default:
         return self.createSection()
      }
    }
    
    return layout
  }
  
  
  func createSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(1))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 20, bottom: 0, trailing: 20)
    return section
  }
  
  
}


extension GalaxyViewController: GalaxyEventsDelegate {
  func galaxyDestroyed() {
  
      collectionView.backgroundColor = .black
    navigationController?.popViewController(animated: true)
    
  }
  
  func stellarSystemsCountDidUpdate() {
   
    
    self.sections[0] = self.galaxy!.blackHoles
    self.sections[1] = self.galaxy!.stellarPlanetSystems
    
    DispatchQueue.main.async {
self.collectionView.reloadData()
    }
    
  }
  
  func blackHolesCountDidUpdate() {
  
  }
  
}

extension GalaxyViewController: UICollectionViewDelegate {
  
  
}



extension GalaxyViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sections[section]!.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    
    let section = sections[indexPath.section]
    let item = section![indexPath.row]
    
    switch item {
    case is BlackHole:
    
      let blackHoleItem = item as! BlackHole
      cell.label.text = blackHoleItem.id
      cell.count.text = blackHoleItem.age.description
      cell.isUserInteractionEnabled = false
    default:
      let stellarSystem = item as! StellarPlanetSystem
      cell.label.text = stellarSystem.id
      cell.count.text = stellarSystem.age.description
    }
    
    return cell
  }

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: "StellarSystemViewController") as! StellarSystemViewController
    destination.stellarSystem = galaxy?.stellarPlanetSystems[indexPath.row]
    self.navigationController?.pushViewController(destination, animated: true)
   
  }
    
  }




  
