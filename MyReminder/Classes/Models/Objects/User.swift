//
//  User.swift
//  MyReminder
//
//  Created by admin on 11/2/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import ObjectMapper
import Firebase

class User: NSObject, Mappable {
  var uRef: FIRDatabaseReference!
  var uID = ""
  var uUsername = ""
  var uPassword = ""
  var uNotes = [Note]()
  var uSharedNotes = [Note]()

  var isSelected = false

  required convenience init?(_ map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    uID <- map[KeyUser.userID]
    uUsername <- map[KeyUser.userName]
    uPassword <- map[KeyUser.userPassword]
    uNotes <- map[KeyUser.userNotes]
    uSharedNotes <- map[KeyUser.userSharedNote]
  }
}
