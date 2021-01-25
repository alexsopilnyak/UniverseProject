//
//  StellarSystemsViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import UIKit

class StellarSystemViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var starLabel: UILabel!
  weak var stellarSystem: StellarPlanetSystem?
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    
    navigationItem.title = stellarSystem!.id
    starLabel.text = stellarSystem?.hostStar?.id
    stellarSystem!.eventsDelegate = self
    collectionView.dataSource = self
    collectionView.delegate = self
    
    
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
  
    
    }

}

extension StellarSystemViewController: UICollectionViewDelegate{
  
  
  
}
extension StellarSystemViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
}

extension StellarSystemViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    stellarSystem!.planets.count
  }

  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    let planet = stellarSystem!.planets[indexPath.row]
    cell.label.text = planet.id
    cell.count.text = planet.age.description
    cell.elementsNumber.text = "\(planet.satellites?.count ?? 0)"
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let destination = storyboard.instantiateViewController(identifier: "SatelliteViewController") as! SatelliteViewController
    //destination.galaxy = galaxies[indexPath.row]
    self.navigationController?.pushViewController(destination, animated: true)
    //self.performSegue(withIdentifier: Constants.toGalaxyVCSegue, sender: indexPath)
  }
 
}


extension StellarSystemViewController: StellarSystemEventsDelegate{
  func planetsCountDidUpdate() {
    collectionView.reloadData()
  }
  
  func starEvoluteToBlackHole() {
    //presentAlert
  }
  
  func stellarSystemDestroyed() {
    //presentAlert
  }
}
