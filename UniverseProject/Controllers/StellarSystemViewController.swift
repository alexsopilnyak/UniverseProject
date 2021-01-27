//
//  StellarSystemsViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import UIKit

class StellarSystemViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var starLabel: UILabel!
  weak var stellarSystem: StellarPlanetSystem?
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    setupCell()
    setupTitles()
    setupDelegates()
    
    }
  
 
  private func setupCell() {
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
  }
  
  private func setupTitles() {
    guard let stellarSystem = stellarSystem else { return }
    navigationItem.title = stellarSystem.id
    starLabel.text = stellarSystem.hostStar?.id ?? "Host star absent"
  }
  private func setupDelegates() {
    collectionView.dataSource = self
    collectionView.delegate = self
    guard let stellarSystem = stellarSystem else { return }
    stellarSystem.eventsDelegate = self
  }
  
  
  private func showAlert() {
    
    let alertController = UIAlertController(title: "Stellar system destroyed", message: "Press 'OK' button to move to the all galaxies.", preferredStyle: .alert)
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

// MARK:- Extentions
extension StellarSystemViewController: UICollectionViewDelegate{
}

extension StellarSystemViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
  
}

extension StellarSystemViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let stellarSystem = stellarSystem else { return 0}
    return stellarSystem.planets.count
  }

  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    guard let stellarSystem = stellarSystem else { return cell }
    let planet = stellarSystem.planets[indexPath.row]
    cell.label.text = planet.id
    cell.count.text = planet.age.description
    cell.elementsNumber.text = "\(planet.satellites?.count ?? 0)"
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
    guard let stellarSystem = stellarSystem else { return }
    let destination = storyboard.instantiateViewController(identifier: Constants.planetVCid) as! PlanetViewController
    destination.planet = stellarSystem.planets[indexPath.row]
    self.navigationController?.pushViewController(destination, animated: true)

  }
}


extension StellarSystemViewController: StellarSystemEventsDelegate{
  func planetsCountDidUpdate() {
    
    DispatchQueue.main.async {[weak self] in
      guard let self = self else {return}
      self.collectionView.reloadData()
    }
  }
  
  func stellarSystemDestroyed() {
   moveToGalaxies()
  }
}
