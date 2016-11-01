//
//  Common.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 8/13/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import UIKit
import PKHUD
import SystemConfiguration

class Common: NSObject {

  class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }

  class func UIColorFromRGBWithAlpha(rgbValue: UInt, alpha: CGFloat ) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(alpha)
    )
  }

  static var __animationLayer: CATransition? = nil


  class func animationLayer() -> CATransition {
    if (__animationLayer == nil) {
      __animationLayer = CATransition()
      __animationLayer!.duration = 0.69
      __animationLayer!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      __animationLayer!.type = kCATransitionFade
      return __animationLayer!
    } else {
      return __animationLayer!
    }
  }

  class func isIPhone5or4() -> Bool {

    return screenWidth == 320 ?true:false
  }

  class func isIPhone5() -> Bool {
    return screenHeight == 568 ?true:false
  }

  class func isIPhone4() -> Bool {
    return screenHeight == 480 ? true:false
  }

  class func isIPhone6() -> Bool {
    return screenWidth == 375 ?true:false
  }

  class func isIPhone6plus() -> Bool {
    return screenWidth == 414 ?true:false
  }

  class func getNameXib(name: String!, isCheck: Bool!) -> String {

    if isCheck == true {
      if screenWidth == 375 {
        return "P"+name
      } else if screenWidth == 414 {
        return "PP"+name
      } else {
        return name
      }
    } else {
      return name
    }
  }

  class func showAlertWithUIAlertView(message: String!) -> Void {
    let alertView: UIAlertView = UIAlertView(title: APP_NAME,
      message: message,
      delegate: nil,
      cancelButtonTitle: "OK")
    alertView.show()
  }

  class func showAlertWithHUD(message: String) {
    HUD.flash(.Label(message), delay: 1.0)
  }

  class func showAlert(message: String!) -> Void {

    let alertView: UIAlertController = UIAlertController(title: APP_NAME, message: message, preferredStyle:UIAlertControllerStyle.Alert)
    let action = UIAlertAction(title: "OK", style: .Default) { _ in
      // Put here any code that you would like to execute when
      // the user taps that OK button (may be empty in your case if that's just
      // an informative alert)
    }
    alertView.addAction(action)

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    appDelegate.window?.rootViewController?.presentViewController(alertView, animated: true, completion: nil)
  }

  class func showAlertWithVC(message: String!, onVC vc: UIViewController) -> Void {

    let alertView: UIAlertController = UIAlertController(title: APP_NAME, message: message, preferredStyle:UIAlertControllerStyle.Alert)
    let action = UIAlertAction(title: "OK", style: .Default) { _ in
      // Put here any code that you would like to execute when
      // the user taps that OK button (may be empty in your case if that's just
      // an informative alert)
    }
    alertView.addAction(action)
    vc.presentViewController(alertView, animated: true, completion: nil)
  }


  class func sizeOfString(string: String!, inFont font: UIFont!, andMaxWidth width: CGFloat!) -> CGSize {

    if string.isEmpty {
      return CGSize(width: width, height: 1.0)
    } else {
      let label: UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
      label.numberOfLines = 0
      label.lineBreakMode = NSLineBreakMode.ByTruncatingTail
      label.font = font
      label.text = string

      label.sizeToFit()
      return CGSizeMake(width, label.frame.size.height)
    }
  }

  class func sizeOfString(string: String!, inFont font: UIFont!, andMaxHeight height: CGFloat!) -> CGSize {

    if string.isEmpty {
      return CGSize(width: 0.0, height: height)
    } else {
      let label: UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max, height))
      label.numberOfLines = 0
      label.lineBreakMode = NSLineBreakMode.ByTruncatingTail
      label.font = font
      label.text = string

      label.sizeToFit()
      return CGSizeMake(label.frame.size.width, height)
    }
  }

  class func sizeOfAttributeString(attibute: NSAttributedString!, andMaxWidth width: CGFloat!) -> CGRect {

    let sizeContent: CGRect?

    //        sizeContent = attibute.boundingRectWithSize(CGSizeMake(width, 1000000), options: NSStringDrawingOptions.UsesLineFragmentOrigin | NSStringDrawingOptions.UsesFontLeading, context: nil)

    sizeContent = attibute.boundingRectWithSize(CGSize(width: width, height: 1000000), options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], context: nil)

    sizeContent?.size.height+=1
    return sizeContent!
  }

  class func isValidEmail(testStr: String) -> Bool {

    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

    let result = emailTest.evaluateWithObject(testStr)

    return result

  }

  class func animationItemNaviOject(object: UIView!) -> Void {
    object.alpha = 0.0
    UIView.animateWithDuration(0.20, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
      object.alpha = 1.0
      }, completion: nil)
  }

  class func makeIconNavi(image: UIImage!, andLeftOrRight isLeft: Bool!) -> UIImage {

    if isLeft == true {
      UIGraphicsBeginImageContextWithOptions(CGSizeMake(40+image.size.width, image.size.height), false, 0.0)
      image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))

      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage
    } else {
      UIGraphicsBeginImageContextWithOptions(CGSizeMake(35+image.size.width, image.size.height), false, 0.0)
      image.drawInRect(CGRectMake(35, 0, image.size.width, image.size.height))

      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage
    }
  }

  class func makeIconTabbar(image: UIImage!, andPlusPosition position: CGFloat!) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, position+image.size.height), false, 0.0)
    image.drawInRect(CGRectMake(0, position, image.size.width, image.size.height))

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
  }

  class func translutionImage(value: CGFloat, image: UIImage) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)

    let ctx = UIGraphicsGetCurrentContext()
    let area = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)

    CGContextScaleCTM(ctx, 1, -1)
    CGContextTranslateCTM(ctx, 0, -area.size.height)
    CGContextSetBlendMode(ctx, CGBlendMode.Multiply)
    CGContextSetAlpha(ctx, value)
    CGContextDrawImage(ctx, area, image.CGImage)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
  }

  //For Image

  class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size

    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
      newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
    } else {
      newSize = CGSizeMake(size.width * widthRatio, size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRectMake(0, 0, newSize.width, newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.drawInRect(rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
  }


  class func convertStringWithDate(stringDate: String) -> String {

    let dateFormat = getDateFormat()

    let date: NSDate = dateFormat.dateFromString(stringDate)!
    let secondsBetween: NSTimeInterval = NSDate().timeIntervalSinceDate(date)

    if (secondsBetween < 60) {
      var strSecond = "seconds"
      if secondsBetween == 1 {
        strSecond = "second"
      }
      return String(format:"%d", Int(secondsBetween)) + " \(strSecond) ago"
    }
    if (secondsBetween < 3600) { //< an hour
      var strMinu = "minutes"
      if Int(secondsBetween/60) == 1 {
        strMinu = "minute"
      }
      return String(format:"%d", Int(secondsBetween/60)) + " \(strMinu) ago"
    }
    if (secondsBetween < 86400) { //< a day
      var strHour = "hours"
      if Int(secondsBetween/3600) == 1 {
        strHour = "hour"
      }
      return String(format:"%d", Int(secondsBetween/3600)) + " \(strHour) ago"
    }
    if (secondsBetween <= 604800) {//< 7 days
      var strDay = "days"
      if Int(secondsBetween/86400) == 1 {
        strDay = "day"
      }
      return String(format:"%d", Int(secondsBetween/86400)) + " \(strDay) ago"
    } else {

      return String(format:"%d", Int(secondsBetween/86400)) + " days ago"
    }
  }

  class func convertStringToNSDate(strDate: String, timeZone: NSTimeZone = NSTimeZone(name: "UTC")!) -> NSDate {

    if strDate.containsString("+") {
      return getDateFormat(timeZone).dateFromString(strDate)!
    }
    if strDate.containsString("T") {
      return getDateFormatContainTWithNoTimeZone(timeZone).dateFromString(strDate)!
    }
    return getDateFormatNoTimeZone(timeZone).dateFromString(strDate)!
  }

  class func formatStringWithFormat(format: String, withDate date: NSDate, timeZone: NSTimeZone = NSTimeZone(name: "UTC")!) -> String {

    let dateformater = NSDateFormatter()
    
    dateformater.locale = NSLocale(localeIdentifier: "en_US")
    dateformater.timeZone = timeZone
    dateformater.dateFormat = format
    return dateformater.stringFromDate(date)
  }

  class func subString(startIndex: Int, length: Int, string: String) -> String {

    let start = string.startIndex.advancedBy(startIndex)
    let end = string.startIndex.advancedBy(startIndex + length)

    return string.substringWithRange(Range<String.Index>(start..<end))
  }

  class func removeHTMLInString(string: String) -> String {
    //        let str = string.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)

    if string == "" {
      return ""
    } else {

      let encodedData = string.dataUsingEncoding(NSUTF8StringEncoding)!
      let attributedOptions: [String: AnyObject] = [
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
      ]

      var attributedString: NSAttributedString?
      do {
        attributedString = try NSAttributedString(data:encodedData, options: attributedOptions, documentAttributes: nil)
      } catch _ {
        attributedString = NSAttributedString()
      }


      let decodedString = attributedString!.string

      return decodedString
    }

  }

  class func convertAttributeStringWithHTMLString(string: String) -> NSAttributedString {
    //        let str = string.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)

    let encodedData = string.dataUsingEncoding(NSUTF8StringEncoding)!
    let attributedOptions: [String: AnyObject] = [
      NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
      NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
    ]

    let attributedString: NSAttributedString!
    do {
      attributedString = try NSAttributedString(data:encodedData, options: attributedOptions, documentAttributes: nil)
    } catch _ {
      attributedString = nil
    }

    return attributedString
  }

//  class func stringWithDate(date:NSDate)->String{
//    let format = getDateFormat()
//
//    return format.stringFromDate(date)
//  }

  class func openWithLink(link: String) -> Void {
    if UIApplication.sharedApplication().canOpenURL(NSURL(string:link)!) {
      UIApplication.sharedApplication().openURL(NSURL(string:link)!)
    }
  }

  class func convertBigNumberToStringPretty(number: AnyObject) -> String {

    let new = number as! String


    return new

  }

  class func encoding(text: String) -> String {
    //Encode Url String
    let customAllowedSet =  NSCharacterSet(charactersInString:"=\"#%/<>?@\\^`{|} ").invertedSet
    let urlStringEncoded = text.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
    return urlStringEncoded!
  }

  class func randomNumber(range: Range<Int>) -> Int {
    let min = range.startIndex
    let max = range.endIndex
    return Int(arc4random_uniform(UInt32(max - min))) + min
  }

  //MARK: - Date
  class func convertDateToString(dateString dateString: String) -> String {

    if dateString == "" {
      return ""
    }

    let dateFormatter = getDateFormat()

    let date: NSDate! = dateFormatter.dateFromString(dateString)
    let calendar = NSCalendar.currentCalendar()

    let comp = calendar.components([.Year, .Month, .Day], fromDate: date)
    let day = comp.day
    let month = comp.month
    let year = comp.year

    let monthName: String = dateFormatter.monthSymbols[month - 1]

    return "\(monthName) " + convertIntToString(int: day) + ", \(year)"
  }

  class func convertIntToString(int int: Int!) -> String {
    if int < 10 {
      return "0\(int)"
    } else {
      return "\(int)"
    }
  }

  class func formatPhoneNumber(phoneNumber string: String) -> String {
    return String(format: "%@-%@-%@", string.substringToIndex(string.startIndex.advancedBy(3)),
      string.substringWithRange(string.startIndex.advancedBy(3) ... string.startIndex.advancedBy(5)),
      string.substringWithRange(string.startIndex.advancedBy(6) ... string.startIndex.advancedBy(string.characters.count - 1)))
  }

  class func convertDateToNumberString(dateString dateString: String) -> String {

    if dateString == "" {
      return ""
    }

    let dateFormatter = getDateFormat()

    let date: NSDate! = dateFormatter.dateFromString(dateString)
    let calendar = NSCalendar.currentCalendar()

    let comp = calendar.components([.Year, .Month, .Day], fromDate: date)
    let day = comp.day
    let month = comp.month
    let year = comp.year

    return "\(convertIntToString(int: month))/\(convertIntToString(int: day))/\(year)"
  }

  class func getYearFromDateString(dateString dateString: String) -> Int {

    if dateString == "" {
      return 0
    }

    let dateFormatter = getDateFormat()

    let date: NSDate! = dateFormatter.dateFromString(dateString)
    let calendar = NSCalendar.currentCalendar()

    let comp = calendar.components([.Year], fromDate: date)
    let year = comp.year

    return year
  }

  class func getMonthFromDateString(dateString dateString: String) -> Int {

    if dateString == "" {
      return 0
    }

    let dateFormatter = getDateFormat()

    let date: NSDate! = dateFormatter.dateFromString(dateString)
    let calendar = NSCalendar.currentCalendar()

    let comp = calendar.components([.Month], fromDate: date)
    let month = comp.month

    return month
  }

  class func trimWhiteSpaceInsets(string string: String) -> String {
    return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
  }

  class func mixCoverImage(image img: UIImage, mask maskImg: UIImage) -> UIImage {
    let bottomImage = img
    let maskImage = maskImg
    let newSize: CGSize = bottomImage.size
    UIGraphicsBeginImageContext(newSize)
    bottomImage.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
    maskImage.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height), blendMode: CGBlendMode.Normal, alpha: 0.8)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }

  class func validatePhoneNumber(value: String) -> Bool {

    let PHONE_REGEX = "^[(]?[1-9][0-9]{2}[)]?[ -]?[0-9]{3}[ -]?[0-9]{4}$"

    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)

    let result =  phoneTest.evaluateWithObject(value)

    return result

  }

//  class func loadGifIndicator(imageView imv: UIImageView) {
//    let path = NSBundle.mainBundle().pathForResource("img_loading_indicator", ofType: "gif")
//
//    if let path = path, data = NSData(contentsOfFile: path) {
//      let img = UIImage.animatedImageWithAnimatedGIFData(data)
//      imv.image = img
//    } else {
//      imv.image = nil
//    }
//  }

  class func getDateFormat(timeZone: NSTimeZone = NSTimeZone(name: "UTC")!) -> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.timeZone = timeZone
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
    return dateFormatter
  }

  class func getDateFormatNoTimeZone(timeZone: NSTimeZone = NSTimeZone(name: "UTC")!) -> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
    dateFormatter.timeZone = timeZone
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
    return dateFormatter
  }

  class func getDateFormatContainTWithNoTimeZone(timeZone: NSTimeZone = NSTimeZone(name: "UTC")!) -> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.timeZone = timeZone
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
    return dateFormatter
  }

  class func hideGradientBackgroundFromUIWebView(webview view: UIView) {

    view.opaque = false
    view.backgroundColor = UIColor.clearColor()

    for subview in view.subviews {
      if subview.isKindOfClass(UIImage) {
        subview.removeFromSuperview()
      }

      if subview.isKindOfClass(UIScrollView) {
        let scrollView = subview as! UIScrollView
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        for subview in scrollView.subviews {
          if subview.isKindOfClass(UIImage) {
            subview.hidden = true
          }
        }
      }
    }
  }

  class func addBlurView(view view: UIView, style effectStyle: UIBlurEffectStyle, backgroundColor bgColor: UIColor?) {
    let blurEffect = UIBlurEffect(style: effectStyle)
    let blurView = UIVisualEffectView(effect: blurEffect)
    if let color = bgColor {
    blurView.backgroundColor = color
    }
    blurView.translatesAutoresizingMaskIntoConstraints = false
    view.insertSubview(blurView, atIndex: 0)

    view.addConstraint(NSLayoutConstraint(item: blurView,
      attribute: .Height, relatedBy: .Equal, toItem: view,
      attribute: .Height, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: blurView,
      attribute: .Width, relatedBy: .Equal, toItem: view,
      attribute: .Width, multiplier: 2, constant: 0))

  }

  class func setStyleToHTMLContent(fontName font: String, fontSize size: String, htmlString content: String ) -> String {
    var htmlString = ""

    htmlString = "<html>"
      + "<head>"
      + "<style type=\"text/css\">"
      + "body {text-align:justify;color:black !important; font-family: '\(font)'; font-size: \(size);padding:0 10 0 0; margin:0}"
      + "a {text-decoration: none;color: black !important}"
      + ".dont-break-out {overflow-wrap: break-word;word-wrap: break-word;-ms-word-break: break-all;word-break: break-all;word-break: break-word;-ms-hyphens: auto;-moz-hyphens: auto;-webkit-hyphens: auto;hyphens: auto;}"
      + "</style>"
      + "</head>"
      + "<body class=\"dont-break-out\">\(content)</body>"
      + "</html>"

    return htmlString
  }

  class func printFonts() {
    let fontFamilyNames = UIFont.familyNames()
    for familyName in fontFamilyNames {
      print("------------------------------")
      print("Font Family Name = [\(familyName)]")
      let names = UIFont.fontNamesForFamilyName(familyName)
      print("Font Names = [\(names)]")
    }
  }

  class func getMessageAfterDragImageToRight(userName: String) -> String {
    return "Dragging a picture to the right you are interested in \(userName)"
  }

  class func getMessageAfterFragImageToLeft(userName: String) -> String {
    return "Dragging a picture to the left you are not interested in \(userName)"
  }

  class func stringWithDate(date: NSDate) -> String {
    let format = Common.getDateFormat()
//    format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

    return format.stringFromDate(date)
  }

  class func formatDate(date: NSDate) -> String {

    let stringMonthStart = DHCalendarData.nameMonthWithNumberMonth(DHCalendarData.getMonthWithDate(date))

    let formatDate = stringMonthStart + " \(DHCalendarData.getDayWithDate(date))" + ", " + "\(DHCalendarData.getYearWithDate(date))"

    return formatDate
  }

  class func formatTime(time: String) -> String {
    let AM = "am"
    let PM = "pm"

    let arrayHour = time.componentsSeparatedByString(":")

    var hour = Int(arrayHour[0])!
    let min = Int(arrayHour[1])!

    var time = ""

    if hour > 12 {
      hour = hour - 12
      if hour < 10 {
        if min < 10 {
          time = "\(hour):0\(min) \(PM)"
        } else {
          time = "\(hour):\(min) \(PM)"
        }
      } else {
        if min < 10 {
          time = "\(hour):0\(min) \(PM)"
        } else {
          time = "\(hour):\(min) \(PM)"
        }
      }

    } else {
      if hour < 10 {
        if min < 10 {
          time = "\(hour):0\(min) \(AM)"
        } else {
          time = "\(hour):\(min) \(AM)"
        }
      } else {

        if hour == 12 {
          if min < 10 {
            time = "\(hour):0\(min) \(PM)"
          } else {
            time = "\(hour):\(min) \(PM)"
          }
        } else {
          if min < 10 {
            time = "\(hour):0\(min) \(AM)"
          } else {
            time = "\(hour):\(min) \(AM)"
          }
        }
      }

    }

    return time

  }



  class func formatNumber(num: Float) -> String {
    var strFormated = ""

    let formatter = NSNumberFormatter()
    formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle

    if let s = formatter.stringFromNumber(NSNumber(float: num)) {
      strFormated = s
    } else {
      strFormated = ""
    }

    return strFormated
  }

  class func formatCurrencyUS(stringNumber: String) -> String {
    var strFormated = ""

    if let float = Float(stringNumber) {
      let formatter = NSNumberFormatter()
      formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
      formatter.locale = NSLocale(localeIdentifier: "en_US")

      if let s = formatter.stringFromNumber(NSNumber(float: float)) {
        strFormated = s
      } else {
        strFormated = ""
      }
    }
    return strFormated
  }

//  class func calculateAge(birthday: NSDate) -> Int {
//    let year = NSCalendar.currentCalendar().components(.Year, fromDate: birthday, toDate: NSDate(), options: [])
//    let month = NSCalendar.currentCalendar().components(.Month, fromDate: birthday, toDate: NSDate(), options: [])
//    let day = NSCalendar.currentCalendar().components(.Day, fromDate: birthday, toDate: NSDate(), options: [])
//    print(year.year)
//    print(month.month)
//    print(day.day)
//
//    return NSCalendar.currentCalendar().components(.Year, fromDate: birthday, toDate: NSDate(), options: []).year
//  }

  class func calculateAge(birthday: NSDate) -> Int {
    let calendar = NSCalendar.currentCalendar()
    if let timeZone = NSTimeZone(name: "UTC") {
      calendar.timeZone = timeZone
    }
    let yearComponentNow = calendar.components(.Year, fromDate: NSDate())
//    let monthComponentNow = calendar.components(.Month, fromDate: NSDate())
//    let dayComponentNow = calendar.components(.Day, fromDate: NSDate())

    let yearComponentBirth = calendar.components(.Year, fromDate: birthday)
//    let monthComponentBirth = calendar.components(.Month, fromDate: birthday)
//    let dayComponentBirth = calendar.components(.Day, fromDate: birthday)

//    if (monthComponentNow.month < monthComponentBirth.month) || (dayComponentNow.day < dayComponentBirth.day) {
//      return yearComponentNow.year - yearComponentBirth.year - 1
//    } else {
//
//    }

    return yearComponentNow.year - yearComponentBirth.year
  }

  class func caculateAge(birthday: String) -> Int {
    if birthday == "" {
      return 0
    }

    let dateFormatter = getDateFormat()

    guard let date = dateFormatter.dateFromString(birthday) else { return 0 }

    return Common.calculateAge(date)
  }

  class func convertMinuteToHour(m: Float) -> String {
    let h = (m - (m % 60))/60
    let mm = m % 60
    let suffixMinute = "mins"
    var suffixHour = "hrs"

    if h < 1 {
      return "\(Int(mm))\(suffixMinute)"
    }
    if h == 1 {
      suffixHour = "hr"
    } else {
      suffixHour = "hrs"
    }
    if mm == 0.0 {
      return "\(Int(h))\(suffixHour)"
    }
    return "\(Int(h))\(suffixHour) \(Int(mm))\(suffixMinute)"
  }

  class func convertTimeToISOString(time: Time, date: NSDate) -> String {

    var strTime = ""
    if time.nameTime.containsString("AM") {
      strTime = time.nameTime.stringByReplacingOccurrencesOfString(" AM", withString: ":00")
    } else {
      strTime = time.nameTime.stringByReplacingOccurrencesOfString(" PM", withString: ":00")

      let array = strTime.componentsSeparatedByString(":")

      if array.count == 3 {
        strTime = "\(Int(array[0])! + (Int(array[0])! == 12 ? 0 : 12))" + ":" + array[1] + ":" + array[2]
      }
    }

    let workAtNotConvert = DHCalendarData.formatStringTypeYMDLineWithDate(date) + "T" + strTime

    let workAt = workAtNotConvert + "+0000"

    return workAt
  }

  class func convertLocalTimeToGMTTime(time: Time, date: NSDate) -> String {
    var strTime = ""
    if time.nameTime.containsString("AM") {
      strTime = time.nameTime.stringByReplacingOccurrencesOfString(" AM", withString: ":00")
    } else {
      strTime = time.nameTime.stringByReplacingOccurrencesOfString(" PM", withString: ":00")

      let array = strTime.componentsSeparatedByString(":")

      if array.count == 3 {
        strTime = "\(Int(array[0])! + (Int(array[0])! == 12 ? 0 : 12))" + ":" + array[1] + ":" + array[2]
      }
    }

    let dateformater = NSDateFormatter()
    dateformater.dateFormat = "xxxx"
    let strTimeZone = dateformater.stringFromDate(date)

    dateformater.dateFormat = "yyyy-MM-dd"

    let strTimeLocal = dateformater.stringFromDate(date) + "T" + strTime + "\(strTimeZone)"

    dateformater.timeZone = NSTimeZone(name: "UTC")
    dateformater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxx"

    let dateTimeGMT = dateformater.dateFromString(strTimeLocal)

    return dateformater.stringFromDate(dateTimeGMT!)
  }

  class func daySuffix(date: NSDate) -> String {
    let dateformater = NSDateFormatter()
    let locale = NSLocale.currentLocale()

    dateformater.locale = locale
    dateformater.dateFormat = "d"

    let dayOfMonth = dateformater.stringFromDate(date)
    switch dayOfMonth {
    case "1", "21", "31": return "st"
    case "2", "22": return "nd"
    case "3", "23": return "rd"
    default: return "th"
    }
  }

  //MARK: - Data and JSON
  class func nsdataToJSON(data: NSData) -> AnyObject? {
    do {
      return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
    } catch {
      return nil
    }
    //return NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
  }

  class func showToastWithMessage(text: String) {
    JLToast.makeText(text).show()
  }

  class func convertTypeDateToMicroSecond(date: NSDate) -> String {
    let formater: NSDateFormatter = NSDateFormatter()
    formater.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
    let strMoveInDate: String = formater.stringFromDate(date)
    let arr = strMoveInDate.componentsSeparatedByString("+")

    return arr[0] + ".000000Z"
  }

  class func getPageCollectionView(number: Int) -> Int {
    let page = number % 3
    if page == 0 {
      return number / 3
    } else {
      return (number / 3) + 1
    }
  }

  class func getDateCurrentFirstMonth() -> String {
    let strCurrentDate = Common.getDateFormat().stringFromDate(NSDate())
    let arrDate = strCurrentDate.componentsSeparatedByString("T")
    let arr = arrDate[0].componentsSeparatedByString("-")

    let date = "\(arr[0])-01-01"

    let currentDate = date + "T" + arrDate[1]

    return currentDate
  }

  class func jsonToNSData(json: AnyObject) -> NSData? {
    do {
      return try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(rawValue: 0))
    } catch {
      return nil
    }
  }

  class func formatDateMatch(dateMatch: String) -> String {

    if dateMatch == "" {
      return ""
    } else {
      let dateformatter = Common.getDateFormatWithTimeZone()

      guard let date = dateformatter.dateFromString(dateMatch) else {
        return dateMatch
      }

      let arrDMY = dateformatter.stringFromDate(date).componentsSeparatedByString("-")

      if arrDMY.count >= 3 {
        let arrDay = arrDMY[2].componentsSeparatedByString("T")
        let strDate = arrDMY[1] + "/" + arrDay[0] + "/" + arrDMY[0]
        return strDate
      }

      return dateMatch

    }

  }

  class func getDateFormatWithTimeZone() -> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    dateFormatter.timeZone = DHCalendarData.getCalendarCurrent().timeZone
    dateFormatter.locale = DHCalendarData.getCalendarCurrent().locale
    return dateFormatter
  }

  class func checkDateInPast(strDate: String) -> Bool {
    let arrDMY = strDate.componentsSeparatedByString("-")
    if arrDMY.count >= 3 {
      let arrDay = arrDMY[2].componentsSeparatedByString("T")
      let date = NSDate()
      let format = getDateFormat()
      let str = format.stringFromDate(date)
      let arr = str.componentsSeparatedByString("-")
      let a = arr[2].componentsSeparatedByString("T")
      if Int(arrDMY[0]) < Int(arr[0]) {
        return true
      } else if Int(arrDMY[0]) == Int(arr[0]) {
        if Int(arrDMY[1]) < Int(arr[1]) {
          return true
        } else if Int(arrDMY[1]) == Int(arr[1]) {
          if Int(arrDay[0]) < Int(a[0]) {
            return true
          } else {
            return false
          }
        } else {
          return false
        }
      } else {
        return false
      }
    } else {
      return false
    }
  }

  class func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRectMake(0, 0, size.width, size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }

  class func getAttributeTextSignInAndSignUp(stringFirst: String, stringSecond: String) -> NSMutableAttributedString {
    let attrFirst = NSMutableAttributedString(string: stringFirst)
    attrFirst.addAttribute(NSFontAttributeName, value: getProximaNovaRegularWith(16), range: NSRange(location: 0, length: attrFirst.length))
    attrFirst.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1), range: NSRange(location: 0, length: attrFirst.length))

    let attrSecond = NSMutableAttributedString(string: stringSecond)
    attrSecond.addAttribute(NSFontAttributeName, value: getProximaNovaRegularWith(16), range: NSRange(location: 0, length: attrSecond.length))
    attrSecond.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 171/255, green: 101/255, blue: 229/255, alpha: 1), range: NSRange(location: 0, length: attrSecond.length))

    attrFirst.appendAttributedString(attrSecond)

    return attrFirst
  }

  class func getAttributeTextTermAndPrivacy(stringFirst: String, stringSecond: String, stringThird: String, stringFourth: String) -> NSMutableAttributedString {
    let attrFirst = NSMutableAttributedString(string: stringFirst)
    attrFirst.addAttribute(NSFontAttributeName, value: getProximaNovaRegularWith(16), range: NSRange(location: 0, length: attrFirst.length))
    attrFirst.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1), range: NSRange(location: 0, length: attrFirst.length))

    let attrSecond = NSMutableAttributedString(string: stringSecond)
    attrSecond.addAttribute(NSFontAttributeName, value: getProximaNovaRegularWith(16), range: NSRange(location: 0, length: attrSecond.length))
    attrSecond.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 171/255, green: 101/255, blue: 229/255, alpha: 1), range: NSRange(location: 0, length: attrSecond.length))
    attrFirst.appendAttributedString(attrSecond)

    let attrThird = NSMutableAttributedString(string: stringThird)
    attrThird.addAttribute(NSFontAttributeName, value: getProximaNovaRegularWith(16), range: NSRange(location: 0, length: attrThird.length))
    attrThird.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1), range: NSRange(location: 0, length: attrThird.length))
    attrFirst.appendAttributedString(attrThird)

    let attrFourth = NSMutableAttributedString(string: stringFourth)
    attrFourth.addAttribute(NSFontAttributeName, value: getProximaNovaRegularWith(16), range: NSRange(location: 0, length: attrFourth.length))
    attrFourth.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 171/255, green: 101/255, blue: 229/255, alpha: 1), range: NSRange(location: 0, length: attrFourth.length))
    attrFirst.appendAttributedString(attrFourth)

    return attrFirst
  }

  // Check available network connection
  class func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
      SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
      return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
  }

  class func isValidPassword(testStr: String) -> Bool {

    let capitalLetterRegEx  = ".*[A-Z]+.*"
    let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
    let capitalresult = texttest.evaluateWithObject(testStr)
    print("\(capitalresult)")

    let numberRegEx  = ".*[0-9]+.*"
    let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    let numberresult = texttest1.evaluateWithObject(testStr)
    print("\(numberresult)")

    return capitalresult && numberresult

  }

  class func setOpenHourForSalonDetail(day: String, hour: String) -> String {
    return day + ": " + hour
  }

  class func convertRepeatTypeToString(re: RepeatObject, date: NSDate) -> String {

    switch re.id {
    case 0:
      return "None"
    case 1:
      return "Weekly on " + Common.formatStringWithFormat("EE", withDate: date)
    case 2:
      return "Every 2 Weeks on " + Common.formatStringWithFormat("EE", withDate: date)
    case 3:
      return "Every 3 Weeks on " + Common.formatStringWithFormat("EE", withDate: date)
    case 4:
      return "Every 4 Weeks on " + Common.formatStringWithFormat("EE", withDate: date)
    default:
      break
    }

    return ""
  }

  class func checkUserName(userName: String) -> (String, String) {
    let arrUserName = userName.componentsSeparatedByString(" ")
    let firstName = arrUserName[0]
    var lastName = ""
    for i in 1..<arrUserName.count {
      if i == 2 {
        lastName += " \(arrUserName[i])"
      } else {
        lastName += arrUserName[i]
      }
    }
    return (firstName, lastName)
  }

  class func requiredLoginToContinue(onVC: UIViewController) {
    let alertController = UIAlertController(title: APP_NAME, message: MessRequiredLoginToContinue, preferredStyle: .Alert)

    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
      UIAlertAction in
      let vc = SignInVC()
      onVC.navigationController?.pushViewController(vc, animated: true)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
      UIAlertAction in

    }

    alertController.addAction(okAction)
    alertController.addAction(cancelAction)

    onVC.presentViewController(alertController, animated: true, completion: nil)
  }
}
