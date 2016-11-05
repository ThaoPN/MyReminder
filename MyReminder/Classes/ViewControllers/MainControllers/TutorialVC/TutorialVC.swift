//
//  TutorialVC.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit

let kTutorialAddNote = "kTutorialAddNote"
let kTutorialNoteDetail = "kTutorialNoteDetail"
let kTutorialMainScreen = "kTutorialMainScreen"

class TutorialVC: UIViewController {
  @IBOutlet weak var imvTutorial: UIImageView!

  private var isAddNote = false

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "TutorialVC", bundle: nibBundleOrNil)
    modalPresentationCapturesStatusBarAppearance = true
    modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
    modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init(isAddNote: Bool = false) {
    self.init(nibName: nil, bundle: nil)
    self.isAddNote = isAddNote
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    if isAddNote == true {
      imvTutorial.image = UIImage(named: "Add note")
    } else {
      imvTutorial.image = UIImage(named: "Notes")
    }
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
