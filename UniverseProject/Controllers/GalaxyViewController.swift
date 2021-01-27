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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTitles()
    setupDelegates()
    setupCell()
    
  }
 
  private func setupTitles() {
    guard let galaxy = galaxy else { return }
    navigationItem.title = galaxy.id
  }
  
  private func setupDelegates() {
    collectionView.dataSource = self
    collectionView.delegate = self
    guard let galaxy = galaxy else { return }
    galaxy.eventsDelegate = self
  }
  
  private func setupCell() {
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.collectionViewLayout = createCompositionalLayout()
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
  }
  
  private func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout {  (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      return self.createSection()
    }
    
    return layout
  }
  
  
  private func createSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(1))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 0)
    return section
  }
  
  private func showAlert() {
    
    let alertController = UIAlertController(title: "Galaxy destroyed", message: "Press 'OK' button to move to the all galaxies.", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { [ weak self ] (alert) in
      self?.moveToGalaxies()
    }
    alertController.addAction(okAction)
    DispatchQueue.main.async {
      if self.presentedViewController==nil{
        self.present(alertController, animated: true, completion: nil)
      }else{
          self.presentedViewController!.present(alertController, animated: true, completion: nil)
      }
    }
    
  }
  
  private func moveToGalaxies() {
    if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
      for vc in viewControllers {
        if(vc is UniverseViewController){
          self.navigationController!.popToViewController(vc, animated: true);
        }
      }
    }
  }
  
}


extension GalaxyViewController: GalaxyEventsDelegate {
  func galaxyElementsCountDidUpdate() {
    
    DispatchQueue.main.async {[weak self] in
      guard let self = self else {return}
      
      self.collectionView.reloadData()
    }
  }
  
  func galaxyDestroyed() {
        showAlert()
  
  }
  
}

extension GalaxyViewController: UICollectionViewDelegate {
}

extension GalaxyViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
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
    if let galaxy = galaxy {
      switch indexPath.section {
      case 0:
        let blackHoleItem = galaxy.blackHoles[indexPath.row]
        cell.label.text = blackHoleItem.id
        cell.count.text = blackHoleItem.age.description
        cell.elementsNumber.text = "None"
        cell.isUserInteractionEnabled = false
      default:
        let stellarSystemItem = galaxy.stellarPlanetSystems[indexPath.row]
        cell.label.text = stellarSystemItem.id
        cell.count.text = stellarSystemItem.age.description
        cell.elementsNumber.text = (stellarSystemItem.planets.count + 1).description
      }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: Constants.stellarSystemsVCid) as! StellarSystemViewController
    guard let galaxy = galaxy else { return }
    destination.stellarSystem = galaxy.stellarPlanetSystems[indexPath.row]
    self.navigationController?.pushViewController(destination, animated: true)
    
  }
  
}





