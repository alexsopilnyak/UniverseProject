//
//  SatellitesViewController.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 22.01.2021.
//

import UIKit

class SatelliteViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
  override func viewDidLoad() {
        super.viewDidLoad()

    }
    
  
  
  
  
  
  
  
  
  
  
  func toParent() {
    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];

            for aViewController in viewControllers {
                if(aViewController is GalaxyViewController){
                     self.navigationController!.popToViewController(aViewController, animated: true);
                }
            }
  }
  
}

