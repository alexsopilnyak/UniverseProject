//
//  GalaxyCollectionViewCell.swift
//  UniverseProject
//
//  Created by Alexandr Sopilnyak on 23.01.2021.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var idLabel: UILabel!
  @IBOutlet private weak var ageLabel: UILabel!
  @IBOutlet private weak var elementsNumberLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

  func configureCell(id: String, age: String, elementsNumber: Int) {
    idLabel.text = id
    ageLabel.text = age
    elementsNumberLabel.text = elementsNumber.description
  }
 
}
