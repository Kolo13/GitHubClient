//
//  UserCollectionViewCell.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/22/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var loginName: UILabel!
  
  
  override func prepareForReuse() {
    super.prepareForReuse() 
    self.imageView.image = nil
  }
  
  
  
}
