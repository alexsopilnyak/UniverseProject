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
  
  private var dataSource: PlanetCollectionViewDataSource?
  private var delegate: PlanetCollectionViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTitles()
    setupDelegatesAndDataSource()
    setupCell()
  }
  
  private func setupTitles() {
    guard let planet = planet else { return }
    navigationItem.title = planet.id
    planetLabel.text = planet.id
  }
  
  private func setupDelegatesAndDataSource() {
    guard let planet = planet else { return }
    dataSource = PlanetCollectionViewDataSource(planet: planet)
    
    guard let dataSource = dataSource, let navigationController = navigationController else { return }
    delegate = PlanetCollectionViewDelegate(dataSource: dataSource, navigationController: navigationController)
    
    collectionView.dataSource = dataSource
    collectionView.delegate = delegate
    planet.eventsDelegate = self
  }
  
  private func setupCell() {
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
  }
  
  private func showAlert() {
    
    let alertController = UIAlertController(title: "This planet destroyed", message: "Press 'OK' button to move to the all galaxies.", preferredStyle: .alert)
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
    let viewControllers: [UIViewController] = self.navigationController!.viewControllers
    
    for vc in viewControllers {
      if(vc is UniverseViewController){
        self.navigationController!.popToViewController(vc, animated: true);
      }
    }
  }
}


//MARK:- Extension - EventsDelegate
extension PlanetViewController: EventsDelegate {
  func elementDestroyed() {
    showAlert()
  }
  
  func elementDidUpdate() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else {return}
      self.collectionView.reloadData()
    }
    
  }
}
