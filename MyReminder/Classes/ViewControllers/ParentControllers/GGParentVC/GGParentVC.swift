//
//  GGParentVC.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 8/13/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import UIKit

let HeightNavibar: CGFloat = 64

let OriginNavibar: CGFloat = 0

let ColorNavibar: UIColor = UIColor.yellowColor()

class GGParentVC: UIViewController {

  // MARK: - Enum
  enum LeftItem {
    case Back
    case Map
    case Close
    case None
  }

  enum RightItem {
    case Done
    case Home
    case Message
    case Flag
    case Save
    case None
  }

  enum CenterItem {
    case Title
    case None
  }

  enum ItemType {
    case None
    case Favorite
    case Share
    case Back
    case Map
    case Search
    case Close
    case Done
    case UnFavorite
  }

  //MARK: Variable
  private var navigationVCCurrent: GGNavigationController?

  private var previousScrollViewYOffset: CGFloat = 0.0
  private var frameViewCustom: CGRect! = nil
  private var scrollBackUp: UIScrollView! = nil

  var lblTitle: UILabel! = UILabel()
  var strTitle: String! = ""
  var fontTitle: UIFont! = UIFont.systemFontOfSize(18)

  // MARK: - Override Method
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init(leftType: LeftItem, centerType: CenterItem, rightType: [ItemType]) {
    self.init(nibName:nil, bundle: nil)

    navigationItem.hidesBackButton = true

    makeLeftButtons(withType: leftType)
    makeRightButtons(withType: rightType)
    makeCenterItems(withType: centerType)
  }


  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    UIApplication.sharedApplication().statusBarHidden = false

    navigationVCCurrent?.naviBar?.hidden = false
    reSetNavigationBarItem()
    setImageNavibar()

//    if !Common.isConnectedToNetwork() {
//      if viewNoInternetConnection == nil {
//        viewNoInternetConnection = NoInternetConnectionView.initWithXib(onVC: self, withFrame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        viewNoInternetConnection?.delegate = self
//      } else {
//
//      }
//      view.addSubview(viewNoInternetConnection!)
//      viewNoInternetConnection?.hidden = false
//    } else {
//
//    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.setImageNavibar()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    print("Screen name: \(classForCoder)")
  }

  override func prefersStatusBarHidden() -> Bool {
    return false
  }

  override func shouldAutorotate() -> Bool {

    return false
  }

  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Portrait
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 7.0 {
      automaticallyAdjustsScrollViewInsets = false
    } else {

    }

    navigationVCCurrent = navigationController as? GGNavigationController
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  // MARK: - Public Method
  func setTitleForVC(title: String, font: UIFont = UIFont.systemFontOfSize(18)) {
    strTitle = title
    fontTitle = font

    if (lblTitle != nil) {
      lblTitle.text = strTitle
      lblTitle.font = fontTitle
    }
  }

  func setRightButtonEnable(enable: Bool) {
    if enable {
      makeRightButtons(withType: [GGParentVC.ItemType.Done])
    } else {
      makeRightButtons(withType: [GGParentVC.ItemType.None])
    }
  }

  func changeLeftItem(withType leftType: LeftItem) {
    makeLeftButtons(withType: leftType)
  }

  func changeRightItem(withType rightType: [ItemType]) {
    makeRightButtons(withType: rightType)

  }

  func setImageNavibar(image: UIImage? = UIImage(named: "image_navibar")!.resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .Stretch)) {
    navigationVCCurrent?.naviBar?.setBackgroundImage(image, forBarMetrics: UIBarMetrics.Default)
    navigationVCCurrent?.naviBar?.shadowImage = UIImage()
  }

  func setHidenNaviBar(isHiden: Bool) {
    if (isHiden == true) {
      navigationVCCurrent?.naviBar?.hidden = true

    } else {
      navigationVCCurrent?.naviBar?.hidden = false
    }
  }

  func setHidenStatusBar(isHiden: Bool) {
    if (isHiden == true) {
      UIApplication.sharedApplication().statusBarHidden = true
    } else {
      UIApplication.sharedApplication().statusBarHidden = false
    }
  }

  func setNaviItemLeftHiden() {
    navigationItem.leftBarButtonItem?.customView?.alpha = 0.0
  }

  func setNaviItemRightHiden() {
    navigationItem.rightBarButtonItem?.customView?.alpha = 0.0
  }

  func setNaviItemTitleHiden() {
    navigationItem.titleView?.alpha = 0.0
  }

  func resetNavibar() {
    if navigationVCCurrent?.naviBar?.frame.origin.y != 0 {
      if scrollBackUp != nil {
        scrollBackUp.contentOffset = CGPointMake( scrollBackUp.contentOffset.x, scrollBackUp.contentOffset.y - 64)
        //self.navigationVCCurrent?.naviBar?.frame.origin.y = ORIGIN_Y_NAVIBAR;
      } else {

      }
    } else {

    }

    navigationItem.leftBarButtonItem?.customView?.alpha = 1.0
    navigationItem.rightBarButtonItem?.customView?.alpha = 1.0
    navigationItem.titleView?.alpha = 1.0
  }

  func scrollAutoAnimationWhenEndDrag(scrollView: UIScrollView!, andPlusHeightView viewCustom: UIView!, andPlusHeight heightPlus: CGFloat!) {
    if viewCustom == nil {
      return
    }
    if navigationVCCurrent?.naviBar?.frame.origin.y == -44 ||  navigationVCCurrent?.naviBar?.frame.origin.y == 0 {
      if viewCustom.frame.origin.y < (64 - viewCustom.frame.size.height) || viewCustom.frame.origin.y == 64 {

      } else {
        if viewCustom.frame.origin.y > (64 - viewCustom.frame.size.height/2) {
          let plus = 64 - viewCustom.frame.origin.y
          scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-plus), animated: true)
        } else {
          let plus = viewCustom.frame.origin.y - (64 - viewCustom.frame.size.height)
          scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+plus), animated: true)
        }
      }
    } else {
      if navigationVCCurrent?.naviBar?.frame.origin.y > -32 {
        let origin: CGFloat! = navigationVCCurrent?.naviBar?.frame.origin.y
        var plus = (origin * -1)
        if viewCustom != nil {
          plus += viewCustom.frame.size.height
        } else {
          plus += viewCustom.frame.size.height
        }
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-plus), animated: true)
      } else {
        let origin: CGFloat! = navigationVCCurrent?.naviBar?.frame.origin.y
        var plus = 44 - (origin * -1)
        if viewCustom != nil {
          plus += viewCustom.frame.size.height
        } else {
          plus += viewCustom.frame.size.height
        }
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+plus), animated: true)
      }
    }

  }

  func scrollAnimationNavigationbarWithRect(scrollView: UIScrollView!, andPlusHeightView viewCustom: UIView!, andPlusHeight heightPlus: CGFloat!) {
    scrollBackUp = scrollView
    // 20 => -44

    if viewCustom == nil {
      if frameViewCustom == nil {
        frameViewCustom = CGRectMake(0, HeightNavibar, UIScreen.mainScreen().bounds.size.width, 0)
      }
    }

    if (viewCustom != nil) {
      if (scrollView.contentOffset.y + HeightNavibar + heightPlus + viewCustom.frame.height > 0) {
        if frameViewCustom == nil {
          frameViewCustom = CGRectMake(0, HeightNavibar, UIScreen.mainScreen().bounds.size.width, viewCustom.frame.size.height)

        }
        let newOffset: CGFloat! = (scrollView.contentOffset.y + heightPlus + HeightNavibar + viewCustom.frame.height)
        let scrollDiff: CGFloat! = newOffset - previousScrollViewYOffset
        let maxVY: CGFloat! = HeightNavibar, minVY: CGFloat! = -viewCustom.frame.height
        let realVY = (frameViewCustom.origin.y-scrollDiff)

        if (realVY < minVY) {
          viewCustom?.frame.origin.y = minVY
        } else if (realVY > maxVY) {
          viewCustom?.frame.origin.y = maxVY
        } else {
          viewCustom?.frame.origin.y = realVY
        }

        let maxNY: CGFloat! = OriginNavibar, minNY: CGFloat! = -44

        let realNY = viewCustom.frame.origin.y - (HeightNavibar - viewCustom.frame.height)

        if (realNY < minNY) {
          navigationVCCurrent?.naviBar?.frame.origin.y = minNY
        } else if (realNY > maxNY) {
          navigationVCCurrent?.naviBar?.frame.origin.y = maxNY
        } else {
          navigationVCCurrent?.naviBar?.frame.origin.y = realNY
        }

        frameViewCustom = viewCustom.frame
        previousScrollViewYOffset = newOffset

      } else {
        navigationVCCurrent?.naviBar?.frame.origin.y = OriginNavibar
      }
    } else {
      navigationVCCurrent?.naviBar?.frame.origin.y = OriginNavibar
    }


    let alpha: CGFloat! = navigationVCCurrent?.naviBar?.frame.origin.y

    if alpha == nil {
      navigationItem.titleView?.alpha = 1.0
      navigationItem.leftBarButtonItem?.customView?.alpha = 1.0
      navigationItem.rightBarButtonItem?.customView?.alpha = 1.0
    } else {
      navigationItem.titleView?.alpha = 1 - (alpha * -1)/44
      navigationItem.leftBarButtonItem?.customView?.alpha = 1 - (alpha * -1)/44
      navigationItem.rightBarButtonItem?.customView?.alpha = 1 - (alpha * -1)/44
    }

  }

  // MARK: - Configue Navibar
  func setNumberBookingForNotificationRightButton(number: Int = 0) {
    if let imgBooking = UIImage(named: "ic_navi_favorite") {
      let viewBooking = UIView(frame: CGRect(x: 0, y: 0, width: imgBooking.size.width, height: imgBooking.size.height + imgBooking.size.height / 2))
      let button = UIButton(type: .Custom)
      button.frame = CGRect(x: 0, y: imgBooking.size.height / 2, width: imgBooking.size.width, height: imgBooking.size.height)
      button.setImage(imgBooking, forState: .Normal)
      button.contentHorizontalAlignment = .Center
      button.addTarget(self, action: #selector(tapToTest(_:)), forControlEvents: .TouchUpInside)
      viewBooking.addSubview(button)

      let lblNumber = UILabel(frame: CGRect(x: viewBooking.frame.size.width - (viewBooking.frame.size.width / 2), y: 0, width: imgBooking.size.width - 3, height: imgBooking.size.width - 3))
      lblNumber.layer.cornerRadius = lblNumber.frame.size.width / 2
      lblNumber.layer.masksToBounds = true
      lblNumber.font = UIFont.systemFontOfSize(10)
      lblNumber.backgroundColor = UIColor.redColor()
      lblNumber.textAlignment = NSTextAlignment.Center
      lblNumber.textColor = UIColor.whiteColor()
      lblNumber.text = "\(number)"

      if number != 0 {
        viewBooking.addSubview(lblNumber)
      } else {

      }

      let tap = UITapGestureRecognizer(target: self, action: #selector(tapToTest(_:)))
      viewBooking.addGestureRecognizer(tap)

      let itemB: UIBarButtonItem = UIBarButtonItem(customView: viewBooking)
      itemB.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blueColor()], forState: UIControlState.Disabled)

      let paddingA = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: nil)
      paddingA.width = -10

      self.navigationItem.rightBarButtonItems = [paddingA, itemB]
    }
  }

  private func makeLeftButtons(withType leftType: LeftItem) {

    let paddingLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: nil)
    paddingLeft.width = -5

    if leftType == LeftItem.Back {
      //Back button
      let image = UIImage(named: "ic_navi_back")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

      let itemLeft: UIBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone:image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(tapToBack(_:)))

      navigationItem.setLeftBarButtonItems([paddingLeft, itemLeft], animated: false)

    } else if leftType == LeftItem.Map {

      let image = UIImage(named: "ic_navi_map")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

      let itemLeft: UIBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone:image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(tapToMap(_:)))

      navigationItem.setLeftBarButtonItems([paddingLeft, itemLeft], animated: false)

    } else if leftType == LeftItem.Close {

      let image = UIImage(named: "ic_navi_close")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

      let itemLeft: UIBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone:image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(tapToClose(_:)))

      navigationItem.setLeftBarButtonItems([paddingLeft, itemLeft], animated: false)

    } else {
//      self.navigationItem.leftBarButtonItems = []
      let itemLeft = UIBarButtonItem(title: "       ", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
      let font = UIFont.systemFontOfSize(14)
      let dic = [NSFontAttributeName: font, NSForegroundColorAttributeName : UIColor.whiteColor()]
      itemLeft.setTitleTextAttributes(dic, forState: UIControlState.Normal)

      navigationItem.setLeftBarButtonItems([paddingLeft, itemLeft], animated: false)
    }
  }

  private func makeRightButtons(withType rightTypes: [ItemType]) {
    var tmpItems = rightTypes
    var items = [UIBarButtonItem]()

    let paddingRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: nil)
    paddingRight.width = -5
    items.append(paddingRight)

    items.append(createButtonWithType(tmpItems[0]))
    tmpItems.removeFirst()

    for type in tmpItems {
      let item = createButtonWithType(type)
      item.imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
      items.append(item)
    }

    navigationItem.setRightBarButtonItems(items, animated: false)
  }

  private func makeCenterItems(withType centerItem: CenterItem) {

    if centerItem == CenterItem.Title {
      //Title
      lblTitle = UILabel(frame: CGRectMake(0, (screenWidth / 2) - 115, 150, 25))
      lblTitle.backgroundColor = UIColor.clearColor()
      lblTitle.textAlignment = NSTextAlignment.Center
      lblTitle.textColor = UIColor.whiteColor()

      lblTitle.font = fontTitle
      lblTitle.text = strTitle

      lblTitle.userInteractionEnabled = true
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToTitle(_:)))
      tapGesture.numberOfTapsRequired = 1
      lblTitle.addGestureRecognizer(tapGesture)

      navigationItem.titleView = lblTitle
    } else {
      navigationItem.titleView = nil
      navigationItem.title = ""
    }
  }

//  private func addItemLeft(){
//    let item = createButtonWithType(lefItem)
//
//    let padding = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: nil)
//
//    if let _ = item.customView {
//      padding.width = -25
//    } else {
//      padding.width = 5
//    }
//
//    self.navigationItem.leftBarButtonItems = [padding,item]
//    //self.navigationItem.leftBarButtonItem = item
//  }

  private func createButtonWithType(type: ItemType) -> UIBarButtonItem {
    var btn = UIBarButtonItem()
    //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent

    switch (type) {
    case .Map:
      let image = UIImage(named: "ic_navi_map.png")
      btn = createBarButton(image, actionString: "Map")

      break

    case .Back:
      let image = UIImage(named:"ic_navi_back.png")
      btn = createBarButton(image, actionString: "Back")

      break

    case .Close:
      let image = UIImage(named: "ic_navi_close.png")
      btn = createBarButton(image, actionString: "Close")

      break

    case .Favorite:
      let image = UIImage(named: "ic_navi_favorite.png")
      btn = createBarButton(image, actionString: "Favorite")

      break
    case .Search:
      let image = UIImage(named: "ic_navi_search.png")
      btn = createBarButton(image, actionString: "Search")

      break
    case .Share:
      let image = UIImage(named: "ic_navi_share.png")
      btn = createBarButton(image, actionString: "Share")

      break
    case .Done:
      btn = createBarButton(nil, title: "Done ", actionString: "Done")
      break
    case .UnFavorite:
      let image = UIImage(named: "ic_favorite_salon")
      btn = createBarButton(image, actionString: "UnFavorite")
    default:
      break
    }

    return btn
  }

  private func createBarButton(image: UIImage?, title: String = "", actionString: String) -> UIBarButtonItem {
    let str = "tapTo\(actionString):"

    if let image = image {
      let image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

      let item = UIBarButtonItem(image: image, landscapeImagePhone:image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector(str))
      return item
    } else {
      let item = UIBarButtonItem(title: title, style: .Plain, target: self, action: Selector(str))
      let font = UIFont.systemFontOfSize(18)
      let dic = [NSFontAttributeName: font, NSForegroundColorAttributeName : UIColor.whiteColor()]
      item.setTitleTextAttributes(dic, forState: UIControlState.Normal)

      return item
    }

//    navigationItem.setLeftBarButtonItems([itemLeft], animated: true)
  }

  private func reSetNavigationBarItem() {
//    self.navigationVCCurrent?.naviBar?.setItems([], animated: false)
    navigationVCCurrent?.naviBar?.setItems([self.navigationItem], animated: false)
  }

  // MARK: - Private Method

  func tapToBack(sender: UIButton!) {

    print("tapToBack")
    view.endEditing(true)
    navigationController?.popViewControllerAnimated(true)
  }

  func tapToClose(sender: UIButton!) {
    print("tapToClose")

    view.endEditing(true)
    dismissViewControllerAnimated(true, completion: nil)
  }

  func tapToTitle(sender: UIButton!) {
    print("tapToTitle")
  }

  func tapToMap(sender: UIButton!) {
    print("tapToMap")
  }

  func tapToFavorite(sender: UIButton!) {
    print("tapToFavorite")
  }

  func tapToShare(sender: UIButton!) {
    print("tapToShare")
  }

  func tapToSearch(sender: UIButton!) {
    print("tapToSearch")
  }

  func tapToDone(sender: UIButton!) {
    print("tapToDone")
  }

  func tapToUnFavorite(sender: UIButton!) {
    print("Unfavorite")
  }

  func tapToTest(sender: UIButton!) {
    print("test")
  }

  func tapToTryAgainConnection() {
    print("Try agian")
  }
}
