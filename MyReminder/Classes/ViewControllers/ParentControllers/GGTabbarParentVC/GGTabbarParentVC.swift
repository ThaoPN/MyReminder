////
////  GGTabbarParentVC.swift
////  GGStructureSwift
////
////  Created by Đăng Hoà on 8/14/15.
////  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
////
//
//import UIKit
//
//let COLOR_TINT_TABBAR: UIColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
//let COLOR_BACKGROUND_TABBAR: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//
//class GGTabbarParentVC: UITabBarController, UITabBarControllerDelegate {
//
//  // MARK: Property
//
//  static private var __mainTabbar: GGTabbarParentVC!
//
//
//  var indexTempTabbarItem: Int? = 0
//
//  var homeVC: UIViewController? = nil
//  var upcomingVC: UIViewController? = nil
//  var profileVC: UIViewController? = nil
//  var notificaitonVC: UIViewController? = nil
//  var homeNC: GGNavigationController? = nil
//  var upcomingNC: GGNavigationController? = nil
//  var profileNC: GGNavigationController? = nil
//  var notificationNC: GGNavigationController? = nil
//
//  // MARK: Public Method
//
//  class func reset() {
//    __mainTabbar.homeVC = nil
//    __mainTabbar.upcomingVC = nil
//    __mainTabbar.profileVC = nil
//    __mainTabbar.homeNC = nil
//    __mainTabbar.upcomingNC = nil
//    __mainTabbar.profileNC = nil
//    __mainTabbar.notificationNC = nil
//    __mainTabbar = nil
//  }
//
//  class func shareInstance() -> GGTabbarParentVC {
//    if (__mainTabbar != nil) {
//      return __mainTabbar
//    } else {
//      __mainTabbar = GGTabbarParentVC()
//
//      return __mainTabbar
//    }
//  }
//
//  class func resetTabbar() {
//    __mainTabbar = nil
//  }
//
//  func setHidenTabBar(isHiden: Bool) {
//    if isHiden == true {
//      self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, UIScreen.mainScreen().bounds.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height)
//    } else {
//
//      UIView.animateWithDuration(0.3, animations: {
//        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, UIScreen.mainScreen().bounds.size.height-self.tabBar.frame.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height)
//      })
//    }
//  }
//
//  func setNumberNotificationUnread(number: Int) {
//    setBagdeNumber(number, forIndex: 3)
//  }
//
//  // MARK: Private Method
//  private func createTabbarWithControllers() {
//    tabBar.tintColor = UIColor(red: 153/255, green: 72/255, blue: 222/255, alpha: 1)
//
//    homeVC = HomeVC()
//    homeNC = GGNavigationController(rootViewController:homeVC!)
//    homeNC?.tabBarItem.title = "Home"
//    homeNC?.tabBarItem.image = UIImage(named: "ic_homevc")
//    homeNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)], forState: UIControlState.Normal)
//    homeNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 153/255, green: 72/255, blue: 222/255, alpha: 1)], forState: UIControlState.Selected)
//    homeNC?.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 4, vertical: -4)
//
//    //
//    upcomingVC = MyBookingVC()
//    upcomingNC = GGNavigationController(rootViewController:upcomingVC!)
//    upcomingNC?.tabBarItem.title = "My Bookings"
//    upcomingNC?.tabBarItem.image = UIImage(named: "ic_bookingvc")
//    upcomingNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)], forState: UIControlState.Normal)
//    upcomingNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 153/255, green: 72/255, blue: 222/255, alpha: 1)], forState: UIControlState.Selected)
//    upcomingNC?.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 4, vertical: -4)
//
//    //
//    profileVC = ProfileVC()
//    profileNC = GGNavigationController(rootViewController:profileVC!)
//    profileNC?.tabBarItem.title = "Profile"
//    profileNC?.tabBarItem.image = UIImage(named: "ic_profilevc")
//    profileNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)], forState: UIControlState.Normal)
//    profileNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 153/255, green: 72/255, blue: 222/255, alpha: 1)], forState: UIControlState.Selected)
//    profileNC?.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 4, vertical: -4)
//
//    //
//    notificaitonVC = ListNotificationVC()
//    notificationNC = GGNavigationController(rootViewController: notificaitonVC!)
//    notificationNC?.tabBarItem.title = "Notifications"
//    notificationNC?.tabBarItem.image = UIImage(named: "ic_list_notification_vc")
//    notificationNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)], forState: UIControlState.Normal)
//    notificationNC?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 153/255, green: 72/255, blue: 222/255, alpha: 1)], forState: UIControlState.Selected)
//    notificationNC?.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 4, vertical: -4)
//
//    //set to tabbar
//    setViewControllers([homeNC!, upcomingNC!, profileNC!, notificationNC!], animated: true)
//
//
//    let _ = notificaitonVC!.view
//  }
//
//  private func setBagdeNumber(number: Int, forIndex index: Int) {
////    if number != 0 {
//      if let items = tabBar.items {
//        if index >= 0 && index < items.count {
//          let item = items[index]
//          if number == 0 {
//            item.badgeValue = nil
//          } else {
//            item.badgeValue = "\(number)"
//          }
//        }
//      }
////    } 
//  }
//  // MARK: Tabbar Delegate
//
//  func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//    //        let navi:GGNavigationController = viewController as! GGNavigationController
//    ////        navi.delegate = nil
//    //
//    //
//    //        let vc: GGParentVC = navi.viewControllers.last as! GGParentVC
//    //
//    //        if indexTempTabbarItem == 0 {
//    //
//    //            if !vc.isKindOfClass(AuthenVC.classForCoder()) {
//    //
//    //                self.navi1?.delegate = nil
//    //                self.indexTempTabbarItem = -1
//    //            }
//    //
//    //        }else if self.indexTempTabbarItem == 1 {
//    //
//    //            if !vc.isKindOfClass(AuthenVC.classForCoder()) {
//    //
//    //                self.navi1?.delegate = nil
//    //                self.indexTempTabbarItem = -1
//    //            }
//    //        }else{
//    //            if !vc.isKindOfClass(AuthenVC.classForCoder()){
//    //
//    //                self.navi1?.delegate = nil
//    //                self.indexTempTabbarItem = -1
//    //            }
//    //        }
//
//
//    return true
//
//  }
//
//  func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
//
//    //        if self.selectedIndex == 0{
//    //            if self.indexTempTabbarItem == self.selectedIndex{
//    //                //self.vc1?.scrollToTop()
//    //
//    //            }
//    //        }else if self.selectedIndex == 1{
//    //            if self.indexTempTabbarItem == self.selectedIndex {
//    //
//    //                //self.vc2?.scrollToTop()
//    //            }
//    //        }else{
//    //            if self.indexTempTabbarItem == self.selectedIndex {
//    //
//    //            }
//    //        }
//    //
//    //        self.indexTempTabbarItem = self.selectedIndex;
//  }
//
//  // MARK: Override Method
//
//  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    self.createTabbarWithControllers()
//
//    self.delegate = self
//  }
//
//  required init(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  convenience init() {
//    self.init(nibName: nil, bundle: nil)
//
//    GGTabbarParentVC.__mainTabbar = self
//    self.delegate = self
//  }
//
//  override func viewWillAppear(animated: Bool) {
//    super.viewWillAppear(animated)
//
//
//    let naviCurrent = navigationController as? GGNavigationController
//    naviCurrent?.naviBar?.hidden = true
//
//    tabBar.backgroundColor = COLOR_BACKGROUND_TABBAR
//    tabBar.barTintColor = COLOR_BACKGROUND_TABBAR
//  }
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Do any additional setup after loading the view.
//    tabBar.tintColor = COLOR_TINT_TABBAR
//
//    tabBar.translucent = true
//
//    AccountFlowManager.continueStart()
//  }
//
//  deinit {
//    // perform the deinitialization
//    print("\(classForCoder) -> Deinit")
//  }
//
//  override func shouldAutorotate() -> Bool {
//
//    return false
//  }
//
//  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//    return UIInterfaceOrientationMask.Portrait
//  }
//
//}
