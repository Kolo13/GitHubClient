//
//  DetailViewController.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/23/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {

  var image: UIImage?
  var reverseOrigin: CGRect?
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.imageView.image = image
  }
}
