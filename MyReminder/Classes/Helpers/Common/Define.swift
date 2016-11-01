//
//  Define.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 8/13/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import Foundation
import UIKit



//MARK: - App Name
let APP_NAME              = "Images Luxury Nail Lounge"

//MARK: - Banner Height
let BANNER_HEIGHT: CGFloat = 64.0

//MARK: - Type message part
let TypeTextPlain         = "text/plain"
let TypeTextHTML          = "text/HTML"
let TypeImagePNG          = "image/png"
let TypeImageGIF          = "image/gif"
let TypeVideoQuickTime    = "video/quicktime"
let TypeImageSize         = "application/json+imageSize"
let TypeImageJPEG         = "image/jpeg"
let TypeImageJPEGPreview  = "image/jpeg+preview"
let TypeImageGIFPreview   = "image/gif+preview"
let TypeLocation          = "location/coordinate"
let TypeDate              = "text/date"
let TypeVideoMP4          = "video/mp4"

//MARK: - Duration
let Duration              = 60 * 60

let P_DURATION = 0.7

//MARK: - Name VC

let NAME_LOGIN_VC         = "Login"

//MARK: - Font
let NAME_FONT_MEDIUM      =  "Helvetica-Medium"
let NAME_FONT_REGULAR     =  "Helvetica"
let NAME_FONT_LIGHT       =  "Helvetica-Light"
let NAME_FONT_OBLIQUE     =  "Helvetica-Oblique"
let NAME_FONT_LIGHTCOND   =  "Helvetica-LightOblique"
let NAME_FONT_BOLD        =  "Helvetica-Bold"

let robotoLight           = "Roboto-Light"
let robotoThin            = "Roboto-Thin"
let robotoRegular         = "Roboto-Regular"
let robotoBold            = "Roboto-Bold"
let robotoMedium          = "Roboto-Medium"

let arialRegular          = "Arial"

let proximaNovaBoldItalic       = "Proxima-Nova-Bold-Italic"
let proximaNovaBold             = "ProximaNova-Bold"
let proximaNovaLight            = "ProximaNova-Light"
let proximaNovaRegular          = "ProximaNova-Regular"
let proximaNovaSemiBoldItalic   = "Proxima-Nova-Semibold-Italic"
let proximaNovaSemiBold         = "ProximaNova-Semibold"
let proximaNovaThinItalic       = "Proxima-Nova-Thin-Italic"
let proximaNovaThin             = "Proxima-Nova-Thin"

let josefinSansBold             = "JosefinSans-Bold"
let josefinSansBoldItalic       = "JosefinSans-BoldItalic"
//let josefinSansItalic           = "JosefinSans-Italic"
//let josefinSansLight            = "JosefinSans-Light"
//let josefinSansLightItalic      = "JosefinSans-LightItalic"
let josefinSansRegular          = "JosefinSans"
let josefinSansSemibold         = "JosefinSans-SemiBold"
//let josefinSansSemiboldItalic   = "JosefinSans-SemiBoldItalic"
//let josefinSansThin             = "JosefinSans-Thin"
//let josefinSansThinItalic       = "JosefinSans-ThinItalic"

let notificationGetInfo   = "NotificationGetInfo"


//MARK: - Collor
let COLOR_100_100_100_1: UIColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)

let navbarBgColor: UIColor = UIColor(red: 153/255.0, green: 72/255.0, blue: 222/255.0, alpha: 1)

struct MyColor {
  static let violet = UIColor(red: 153/255, green: 72/255, blue: 222/255, alpha: 1)
  static let violetLight = UIColor(red: 242/255, green: 227/255, blue: 255/255, alpha: 1)
  static let blackLight = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
  static let gray = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
  static let hex222222 = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
  static let hex333333 = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
  static let hex777777 = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
  static let hex555555 = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
  static let hexFFFBC4 = UIColor(red: 255/255, green: 251/255, blue: 196/255, alpha: 1)
  static let hexE4DC6A = UIColor(red: 228/255, green: 220/255, blue: 106/255, alpha: 1)
  static let hexCACACA = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
  static let hexE97C05 = UIColor(red: 120/255, green: 204/255, blue: 27/255, alpha: 1)
  static let hex78CC1B = UIColor(red: 233/255, green: 124/255, blue: 5/255, alpha: 1)
  static let hexF0F0F0 = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
  static let hexDDDDDD = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
  static let hex444444 = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
  static let hex8F8E94 = UIColor(red: 143/255, green: 142/255, blue: 148/255, alpha: 1)
}

//MARK: - Size Screen
let screenWidth   = UIScreen.mainScreen().bounds.size.width
let screenHeight  = UIScreen.mainScreen().bounds.size.height

let navbarChangePoint: CGFloat = 50

func changeFontSizeWithDevice(size: CGFloat) -> CGFloat {
  if UIScreen.mainScreen().bounds.size.height == 480 {
    // iPhone 4
    return size
  } else if UIScreen.mainScreen().bounds.size.height == 568 {
    // IPhone 5
    return size
  } else if UIScreen.mainScreen().bounds.size.width == 375 {
    // iPhone 6
    return size + 1
  } else if UIScreen.mainScreen().bounds.size.width == 414 {
    // iPhone 6+
    return size + 2
  } else if UIScreen.mainScreen().bounds.size.width == 768 {
    // iPad
    return size + 2
  }

  return size
}

//MARK: - Font Proxima Nova

func getProximaNovaRegularWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaRegular, size: size)!
}

func getProximaNovaThinWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaThin, size: size)!
}

func getProximaNovaBoldWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaBold, size: size)!
}

func getProximaNovaSemiBoldWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaSemiBold, size: size)!
}

func getProximaNovaLightWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaLight, size: size)!
}

func getProximaNovaThinItalicWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaThinItalic, size: size)!
}

func getProximaNovaBoldItalicWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaBoldItalic, size: size)!
}

func getProximaNovaSemiboldItalicWith(size: CGFloat) -> UIFont {
  return UIFont(name: proximaNovaSemiBoldItalic, size: size)!
}

//MARK: - Font Josefin Sans

func getJosefinSansBoldWith(size: CGFloat) -> UIFont {
  return UIFont(name: josefinSansBold, size: size)!
}

func getJosefinSansBoldItalicWith(size: CGFloat) -> UIFont {
  return UIFont(name: josefinSansBoldItalic, size: size)!
}

//func getJosefinSansItalicWith(size: CGFloat) -> UIFont {
//  return UIFont(name: josefinSansItalic, size: size)!
//}
//
//func getJosefinSansLightWith(size: CGFloat) -> UIFont {
//  return UIFont(name: josefinSansLight, size: size)!
//}
//
//func getJosefinSansLightItalicWith(size: CGFloat) -> UIFont {
//  return UIFont(name: josefinSansLightItalic, size: size)!
//}

func getJosefinSansRegularWith(size: CGFloat) -> UIFont {
  return UIFont(name: josefinSansRegular, size: size)!
}

func getJosefinSansSemiBoldWith(size: CGFloat) -> UIFont {
  return UIFont(name: josefinSansSemibold, size: size)!
}

//func getJosefinSansSemiBoldItalicWith(size: CGFloat) -> UIFont {
//  return UIFont(name: josefinSansSemiboldItalic, size: size)!
//}
//
//func getJosefinSansThinWith(size: CGFloat) -> UIFont {
//  return UIFont(name: josefinSansThin, size: size)!
//}
//
//func getJosefinSansThinItalicWith(size: CGFloat) -> UIFont {
//  return UIFont(name: josefinSansThinItalic, size: size)!
//}

//MARK: - Notification
let notificationEditBookingCompleted = "NotificationEditBookingCompleted"
let notificationLoadListNotifications = "notificationLoadListNotifications"
let notificationHandleNotificationWhenAlready = "notificationHandleNotificationWhenAlready"
let notificationShowImportanceNotification = "notificationShowImportanceNotification"

//MARK: - Time Animation
let TIME_ANIMATION = 3.5

//MARK: - Default banner Collor
let DEFAULT_BACKGROUND_COLOR = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)


//MARK: -  Default Image
let defaultAvatar = UIImage(named: "img_avatar_default.jpg")

//MARK: - Repeat type
enum RepeatType: Int {
  case None = 0
  case Weekly
  case TwoWeeks
  case ThreeWeeks
  case Month
}

struct ObjectType {
  static let Booking = "Booking"
  static let User = "User"
  static let Salon = "Salon"
  static let BookingDetail = "BookingDetail"
  static let Category = "Category"
  static let Hour = "Hour"
  static let Service = "Service"
  static let Package = "Package"
  static let Message = "Message"
  static let Notification = "Notification"

  static let FeedBack = "feedback"
  static let Reminder = "reminder"
  static let Edit = "edit"
  static let General = "general"
  static let Confirm = "confirm"
  static let LastVisit = "lastvisit"
}

let namesRecuringOption = ["None", "Weekly", "2 Weeks", "3 Weeks", "4 Weeks"]

var identifyForAdditionalServicesCategory = "-999999999" // default but we can change it
