//
//  SatellitesViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import UIKit

class PlanetViewController: UIViewController {
  
  @IBOutlet private weak var planetLabel: UILabel!
  @IBOutlet private weak var collectionView: UICollectionView!
  weak var planet: Planet?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTitles()
    setupDelegatesAndDataSources()
    setupCell()
    
  }
  
  private func setupTitles() {
    guard let planet = planet else { return }
    navigationItem.title = planet.id
    planetLabel.text = planet.id
  }
   
  private func setupCell() {
    collectionView.dataSource = self
    collectionView.delegate = self
    
    guard let planet = planet else { return }
    planet.eventsDelegate = self
    
  }
  
  private func setupDelegatesAndDataSources() {
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
  }
  
  private func showAlert() {
   
    let alertController = UIAlertController(title: "This planet destroyed", message: "Press 'OK' button to move to the all galaxies.", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { [ weak self ] (alert) in
      self?.moveToGalaxies()
    }
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  private func moveToGalaxies() {
    let viewControllers: [UIViewController] = self.navigationController!.viewControllers
    
    for vc in viewControllers {
      if(vc is UniverseViewController){
        self.navigationController!.popToViewController(vc, animated: true);
      }
    }
  }
  
}

//MARK:- Extensions

extension PlanetViewController: UICollectionViewDelegate {
}

extension PlanetViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: 50)
  }
}

extension PlanetViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let planet = planet else { return 0 }
    return planet.satellites?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! ItemCollectionViewCell
    guard let satelite = planet!.satellites?[indexPath.row] else {
      cell.label.text = "Satelistes is absent"
      return cell
    }
    cell.label.text = satelite.id
    cell.count.text = satelite.age.description
    cell.elementsNumber.text = ""
    
    return cell
  }
}

extension PlanetViewController: PlanetEventsDelegate {
  func planetDestroyed() {
    showAlert()
  }
  
  func ageUpdated() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else {return}
      self.collectionView.reloadData()
    }
    
  }
}
