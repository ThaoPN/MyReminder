//
//  DHIndicator.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 8/13/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import UIKit

class DHIndicator: NSObject {
  
  static var viewHud = UIView (frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height
    ))
  
  static var viewBgr = UIView(frame: CGRectMake(viewHud.frame.size.width/2 - 50, viewHud.frame.size.height/2-50 , 100, 100))
  
  static var indicator =  UIActivityIndicatorView(frame: CGRectMake(viewBgr.frame.size.width/2 - 10, viewBgr.frame.size.height/2 - 10 , 20, 20))
  
  deinit{
    
  }
  
  class func show()->Void {
    
    dispatch_async(dispatch_get_main_queue(),{
      
      
      viewBgr.addSubview(indicator)
      viewHud.addSubview(viewBgr)
      
      viewHud.backgroundColor = UIColor.clearColor()
      indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
      indicator.startAnimating()
      
      viewBgr.backgroundColor = UIColor.blackColor()
      viewBgr.alpha = 0.6;
      viewBgr.layer.cornerRadius = 6
      
      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      appDelegate.window?.addSubview(viewHud)
    })
  }
  
  class func hide()->Void {
    dispatch_async(dispatch_get_main_queue(),{
      indicator.removeFromSuperview()
      viewBgr.removeFromSuperview()
      viewHud.removeFromSuperview()
    })
    
  }
  
}

class DHActiIndicator: UIView {
    
    // MARK - Variables
    
    lazy private var animationLayer : CALayer = {
        return CALayer()
        }()
    
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    
    var viewBG:UIView? = nil
    
    // MARK - Init
    
    deinit{
        print(self.classForCoder)
        print("deinit")
    }
    
    init() {
        let image : UIImage = UIImage(named: "dh_loading")!
        
        let frame : CGRect = CGRectMake(0.0, 0.0, image.size.width, image.size.height)
        
        self.viewBG = UIView(frame: frame)
        
        super.init(frame: frame)
        
        animationLayer.frame = frame
        animationLayer.contents = image.CGImage
        animationLayer.masksToBounds = true
        
        self.viewBG!.backgroundColor = UIColor.whiteColor()
        self.viewBG!.layer.cornerRadius = 6.0
        self.viewBG!.layer.masksToBounds = true
        self.viewBG!.alpha = 0.25
        self.addSubview(viewBG!)
        self.layer.addSublayer(animationLayer)
        
        addRotation(forLayer: animationLayer)
        pause(layer: animationLayer)
        self.hidden = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Func
    
    func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        
        rotation.duration = 0.9
        rotation.removedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = NSNumber(float: 0.0)
        rotation.toValue = NSNumber(float: 3.14 * 2.0)
        
        layer.addAnimation(rotation, forKey: "rotate")
    }
    
    func pause(layer layer : CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        
        isAnimating = false
    }
    
    func resume(layer layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
        
        isAnimating = true
    }
    
    func startAnimating () {
        
        dispatch_async(dispatch_get_main_queue(),{
            
            
            if self.isAnimating {
                return
            }
            
            if self.hidesWhenStopped {
                self.hidden = false
            }
            self.resume(layer: self.animationLayer)
        })
        
        
    }
    
    func stopAnimating () {
        
        dispatch_async(dispatch_get_main_queue(),{
            
            if self.hidesWhenStopped {
                self.hidden = true
            }
            self.pause(layer: self.animationLayer)
        })
        
        
    }
}

