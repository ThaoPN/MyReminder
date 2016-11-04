//
//  SignInVC.swift
//  MyReminder
//
//  Created by admin on 11/3/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var txfEmail: UITextField!
  @IBOutlet weak var txfPassword: UITextField!

  // MARK: - Variables
  private var ref: FIRDatabaseReference!
  private var _refHandle: FIRDatabaseHandle!

  // MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "SignInVC", bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  // MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureFirebase()
  }

  // MARK: - Public methods

  // MARK: - Private methods
  private func configureFirebase() {
    ref = FIRDatabase.database().reference()

  }

  // MARK: - Actions
  @IBAction func tapToSignin(sender: AnyObject) {
    if txfEmail.text?.characters.count == 0 || txfPassword.text?.characters.count == 0 {
      Common.showAlertWithHUD("Please input Email or Password")
      return
    }

    ref.child("Users").queryOrderedByChild(KeyUser.userEmail).queryEqualToValue(txfEmail.text!).observeSingleEventOfType(.Value, withBlock: {[weak self] (snapshot) in
      guard let strongSelf = self else {return}
      print(snapshot.value)
      if snapshot.childrenCount > 0 {
        for d in snapshot.children.allObjects as! [FIRDataSnapshot] {
          if d.value![KeyUser.userPassword] as! String == strongSelf.txfPassword.text! {
            print("login ok")
            return
          }
        }
        Common.showAlertWithHUD("Email or Password is incorrect!")
      } else {
        Common.showAlertWithHUD("Email or Password is incorrect!")
      }
    })
  }

  @IBAction func tapToSignUp(sender: AnyObject) {
    let vc = SignUpVC()
    presentViewController(vc, animated: true, completion: nil)
  }
}
