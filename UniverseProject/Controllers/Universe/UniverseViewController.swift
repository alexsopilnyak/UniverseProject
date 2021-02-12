//
//  UniverseViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import UIKit

class UniverseViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private let universe = Universe.shared
  
  private var dataSource: UniverseCollectionViewDataSource?
  private var delegate: UniverseCollectionViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupDelegatesAndDataSource()
    setupCell()
    setupTitle()
  }
  
  private func setupTitle() {
    navigationItem.title = universe.id
  }
  
  private func setupDelegatesAndDataSource() {
    dataSource = UniverseCollectionViewDataSource(universeData: universe)
    
    guard let dataSource = dataSource, let navigationController = navigationController else { return }
    delegate = UniverseCollectionViewDelegate(dataSource: dataSource, navigationController: navigationController)
    
    collectionView.dataSource = dataSource
    collectionView.delegate = delegate
    universe.eventsDelegate = self
  }
  
  private func setupCell() {
    let nibCell = UINib(nibName: Constants.cellID, bundle: nil)
    collectionView.register(nibCell, forCellWithReuseIdentifier: Constants.cellID)
  }
  
  private func showAlert() {
    let alertController = UIAlertController(title: "Universe destroyed", message: "Press 'OK' button to move to the all galaxies.", preferredStyle: .alert)
    self.present(alertController, animated: true, completion: nil)
  }
}


// MARK:- Extention - EventsDelegate
extension UniverseViewController: EventsDelegate {
  func elementDestroyed() {
    showAlert()
  }
  
  func elementDidUpdate() {
    DispatchQueue.main.async {[weak self] in
      guard let self = self else {return}
      self.collectionView.reloadData()
    }
  }
}







