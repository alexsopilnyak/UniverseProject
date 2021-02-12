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
  
  private var dataSource: GalaxyCollectionViewDataSource?
  private var delegate: GalaxyCollectionViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTitles()
    setupDelegatesAndDataSource()
    setupCell()
  }
  
  private func setupTitles() {
    guard let galaxy = galaxy else { return }
    navigationItem.title = galaxy.id
  }
  
  private func setupDelegatesAndDataSource() {
    guard let galaxy = galaxy else { return }
    dataSource = GalaxyCollectionViewDataSource(galaxyData: galaxy)
    
    guard let dataSource = dataSource, let navigationController = navigationController else { return }
    delegate = GalaxyCollectionViewDelegate(dataSource: dataSource, navigationController: navigationController)
    
    collectionView.dataSource = dataSource
    collectionView.delegate = delegate
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

// MARK:- Extention - EventsDelegate
extension GalaxyViewController: EventsDelegate {
  func elementDidUpdate() {
    DispatchQueue.main.async {[weak self] in
      guard let self = self else { return }
      self.collectionView.reloadData()
    }
  }
  
  func elementDestroyed() {
    showAlert()
  }
  
}






