//
//  UniverseViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import UIKit

class UniverseViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  
  let universe = Universe(timer: TimeTracker(withTimeInterval: 0.1))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    universe.eventsDelegate = self
    
    
    print(universe.galaxies.count)
    navigationItem.title = universe.id
    collectionView.dataSource = self
    collectionView.delegate = self
    
    
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
    
  }
  
  
}


extension UniverseViewController: UniverseEventsDelegate {
  func galaxiesCountDidUpdate(galaxies: [Galaxy]) {
    collectionView.reloadData()
  }
  
  func stellarSystemsCountDidUpdate() {
  }
  
  func plantesCountDidUpdate() {
  }
  
  func blackHoleCreated() {
  }
}




extension UniverseViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
}

extension UniverseViewController: UICollectionViewDelegate {}

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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: "GalaxyViewController") as! GalaxyViewController
    destination.galaxy = universe.galaxies[indexPath.row]
    self.navigationController?.pushViewController(destination, animated: true)
    //self.performSegue(withIdentifier: Constants.toGalaxyVCSegue, sender: indexPath)
  }
}
