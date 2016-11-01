//
//  GGNavigationController.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 8/13/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import UIKit

class GGNavigationController: UINavigationController {
  var naviBar: UINavigationBar?
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationBarHidden = true
    
  }
  
  deinit{
    print(self.classForCoder)
    print("deinit")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    naviBar = UINavigationBar(frame:CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, HeightNavibar))
    naviBar?.autoresizingMask = [UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleRightMargin,UIViewAutoresizing.FlexibleLeftMargin,UIViewAutoresizing.FlexibleWidth]
    naviBar?.barTintColor = ColorNavibar
    naviBar?.translucent = false
    
    view.addSubview(naviBar!)
  }
  
  override func shouldAutorotate() -> Bool {
    
    return false
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Portrait
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
}

//extension UINavigationController {
//  override public func shouldAutorotate() -> Bool {
//    return false
//  }
//  
//  override public func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
//    return UIInterfaceOrientation.Portrait
//  }
//  
//  override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//    return UIInterfaceOrientationMask.Portrait
//  }
//}
