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
  
  private var dataSource: StellarSystemCollectionViewDataSource?
  private var delegate: StellarSystemCollectionViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCell()
    setupTitles()
    setupDelegatesAndDataSource()
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
  
  private func setupDelegatesAndDataSource() {
    guard let stellarSystem = stellarSystem else { return }
    dataSource = StellarSystemCollectionViewDataSource(stellarSystem: stellarSystem)
    
    guard let dataSource = dataSource, let navigationController = navigationController  else { return }
    delegate = StellarSystemCollectionViewDelegate(dataSource: dataSource, navigationController: navigationController)
    
    collectionView.dataSource = dataSource
    collectionView.delegate = delegate
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


// MARK:- Extention - EventsDelegate
extension StellarSystemViewController: EventsDelegate {
  func elementDidUpdate() {
    DispatchQueue.main.async {[weak self] in
      guard let self = self else { return }
      self.collectionView.reloadData()
    }
  }
  
  func elementDestroyed() {
    moveToGalaxies()
  }
}
