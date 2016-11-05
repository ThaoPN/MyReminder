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

class User: NSObject {
  var uRef: FIRDatabaseReference!
  var uID = ""
  var uFullName = ""
  var uEmail = ""
  var uPassword = ""
  var uNotes = [Note]()
}
