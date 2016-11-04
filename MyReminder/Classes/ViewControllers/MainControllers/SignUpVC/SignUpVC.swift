//
//  SignUpVC.swift
//  MyReminder
//
//  Created by admin on 11/2/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
// MARK: - Outlets
  @IBOutlet weak var txfEmail: UITextField!
  @IBOutlet weak var txfPassword: UITextField!

// MARK: - Variables
  private var ref: FIRDatabaseReference!
  private let users = [User]()
  private var usersTmp = [FIRDataSnapshot]()
  private var _refHandle: FIRDatabaseHandle!

// MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "SignUpVC", bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  deinit {
    ref.child("Users").removeObserverWithHandle(_refHandle)
  }

// MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()

    ref = FIRDatabase.database().reference()

    DHIndicator.show()
    _refHandle = ref.child("Users").queryOrderedByKey().observeEventType(.Value, withBlock: {[weak self] (snapshot) in
      guard let strongSelf = self else { return }

      strongSelf.usersTmp.append(snapshot)
      print(strongSelf.usersTmp)
      DHIndicator.hide()
    })
  }
// MARK: - Public methods

// MARK: - Private methods
  private func signUpWith(email: String, password: String) {
    let uuid = NSUUID().UUIDString

    let info = [KeyUser.userID: uuid,
                KeyUser.userEmail: email,
                KeyUser.userPassword: password]
    let path = "Users/\(uuid)"

    ref.child(path).setValue(info)
  }

// MARK: - Actions
  @IBAction func tapToSignUp(sender: AnyObject) {
    if txfEmail.text?.characters.count == 0 || txfPassword.text?.characters.count == 0 {
      Common.showAlertWithHUD("Please input Email or Password")
      return
    }

    ref.child("Users").queryOrderedByChild(KeyUser.userEmail).queryEqualToValue(txfEmail.text!).observeSingleEventOfType(.Value, withBlock: {[weak self] (snapshot) in
      guard let strongSelf = self else { return }
      
      if snapshot.childrenCount > 0 {
        Common.showAlertWithHUD("Your email is existed!")
      } else {
        strongSelf.signUpWith(strongSelf.txfEmail.text!, password: strongSelf.txfPassword.text!)
      }
    })
  }
  
  @IBAction func tapToClose(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
