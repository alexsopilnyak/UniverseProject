//
//  UniverseViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import UIKit

class UniverseViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  let universe = Universe(timer: TimeTracker(withTimeInterval: 1))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupDelegates()
    setupCell()
    setupTitles()
    
  }
  
  private func setupTitles() {
    navigationItem.title = universe.id
  }
  
  private func setupDelegates() {
    collectionView.dataSource = self
    collectionView.delegate = self
    universe.eventsDelegate = self
  }
  
  private func setupCell() {
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
  }
}


extension UniverseViewController: UniverseEventsDelegate {
  func galaxiesCountDidUpdate() {
    DispatchQueue.main.async {[weak self] in
      guard let self = self else {return}
      self.collectionView.reloadData()
    }
  }
}


extension UniverseViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
}


extension UniverseViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    universe.galaxies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    
    let galaxy = universe.galaxies[indexPath.row]
      cell.label.text = galaxy.id
      cell.count.text = galaxy.age.description
      cell.elementsNumber.text = (galaxy.stellarPlanetSystems.count + galaxy.blackHoles.count).description

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: Constants.galaxyVCid) as! GalaxyViewController
      destination.galaxy = self.universe.galaxies[indexPath.row]
      self.navigationController?.pushViewController(destination, animated: true)
    
   
  }
}
