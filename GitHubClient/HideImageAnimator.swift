//
//  HideImageAnimator.swift
//  GitHubClient
//
//  Created by Kori Kolodziejczak on 10/23/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//

import UIKit

class HideImageAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  // Rectangle denoting where the animation should start from
  // Used for positioning the toViewController's view
  var origin: CGRect?
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 1.0
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as DetailViewController
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UsersViewController
    
    let containerView = transitionContext.containerView()
    containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
    
    UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: { () -> Void in
      fromViewController.view.alpha = 1.0
      toViewController.view.alpha = 1.0

      fromViewController.view.frame = self.origin!
      fromViewController.imageView.frame = fromViewController.view.bounds
      }) { (finished) -> Void in
        transitionContext.completeTransition(finished)
    }
  }
}
