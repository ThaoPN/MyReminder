//
//  Note.swift
//  MyReminder
//
//  Created by admin on 11/2/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import ObjectMapper
import Firebase

class Note: NSObject, Mappable {
  var nID = ""
  var nTitle = ""
  var nContent = ""
  var nPriority = ""
  var nOwner = ""
  var nCreated = ""

  required convenience init?(_ map: Map) {
    self.init()
  }

  func mapping(map: Map) {
    nID <- map[KeyNote.noteID]
    nTitle <- map[KeyNote.noteTitle]
    nContent <- map[KeyNote.noteContent]
    nPriority <- map[KeyNote.notePriority]
    nCreated <- map[KeyNote.noteCreatedAt]
    nOwner <- map[KeyNote.noteOwner]
  }
}
