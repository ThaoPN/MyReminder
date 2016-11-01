//
//  Helpers.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 8/27/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import Foundation

func resetBookingStatus() {
  AppDelegate.shareInstance().isEditing = false
  AppDelegate.shareInstance().tmpBook = nil
}

func getRepeatTypeFromRepeatID(id: Int) -> String {
  var strType = ""
  switch id {
  case 1:
    strType = "Weekly"
  case 2:
    strType = "2 Weeks"
  case 3:
    strType = "3 Weeks"
  case 4:
    strType = "4 Weeks"
  default:
    break
  }
  return strType
}

func getServiceName(categories: [Category]) -> [String] {

  var servicesName = [String]()
  for category in categories {
    if category.categoryIsPackage && category.categoryPackages.count > 0 {
      servicesName.append(category.categoryPackages[0].pName)
    } else if category.categoryIsAdditional {
      for service in category.categoryServices {
        if service.sIsDependent == false {
          servicesName.append(service.name)
        }
      }
    } else {
      for service in category.categoryServices {
        servicesName.append(service.name)
      }
      for service in category.categoryAdditionals {
        servicesName.append(service.name)
      }
    }
  }

  return servicesName
}

public extension String {
//  func encoding() -> String{
//    //Encode Url String
//    let customAllowedSet =  NSCharacterSet(charactersInString:"=\"#%/<>?@\\^`{|} ").invertedSet
//    let urlStringEncoded = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
//    return urlStringEncoded!
//  }
}
