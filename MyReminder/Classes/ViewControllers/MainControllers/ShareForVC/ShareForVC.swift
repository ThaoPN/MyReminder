//
//  ShareForVC.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import pop
import Async
import ObjectMapper
import Firebase

class ShareForVC: UIViewController {
  // MARK: - Outlets
  @IBOutlet var viewFinishedShare: UIView!
  @IBOutlet weak var imvCheck: UIImageView!
  @IBOutlet weak var lblShared: UILabel!
  @IBOutlet weak var txfSearch: UITextField!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var consHeightViewFinished: NSLayoutConstraint!
  @IBOutlet weak var consWidthViewFinished: NSLayoutConstraint!

  // MARK: - Variables
  private var users = [User]()
  private var isShowFinished = false
  private var myNote: Note!

  // MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "ShareForVC", bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init(note: Note) {
    self.init(nibName: nil, bundle: nil)
    myNote = note
  }
  // MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")

    txfSearch.layer.cornerRadius = txfSearch.frame.size.height/2
    let leftViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: txfSearch.frame.size.height))
    txfSearch.leftView = leftViewEmail
    txfSearch.leftViewMode = .Always

    consWidthViewFinished.constant = 1
    consHeightViewFinished.constant = 1
    viewFinishedShare.layer.masksToBounds = true
    viewFinishedShare.layer.cornerRadius = 3

    fakeData()
  }

  // MARK: - Public methods

  // MARK: - Private methods
  private func fakeData() {
    let ref = FIRDatabase.database().reference()
    DHIndicator.show()
    
    var handle: FIRDatabaseHandle! = nil
    
    func removeObs() {
      ref.removeObserverWithHandle(handle)
    }
    
    handle = ref.child("Users").queryOrderedByKey().observeEventType(.Value, withBlock: {[weak self] (snapshot) in
      guard let strongSelf = self else { return }

      print(snapshot.value)
      for sn in snapshot.children.allObjects as! [FIRDataSnapshot] {
      if let user = Mapper<User>().map(sn.value) {
        if user.uUsername != AppDelegate.shareInstance().currentUser.uUsername && strongSelf.checkExisted(user) == false {
          strongSelf.users.append(user)
        }
      }
      }
      DHIndicator.hide()
      strongSelf.tableView.reloadData()
    })
    
    

//    for _ in 1...10 {
//      let u = User()
//      u.uUsername = "abc"
//      users.append(u)
//    }
    
  }
  
  private func checkExisted(user: User) -> Bool {
    for u in users {
      if u.uUsername == user.uUsername {
        return true
      }
    }
    return false
  }

  private func showFinishedView() {
    if isShowFinished {
      return
    }
    isShowFinished = true
    viewFinishedShare.alpha = 1
    consWidthViewFinished.constant = 175
    consHeightViewFinished.constant = 175

    UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in

      self.viewFinishedShare.setNeedsLayout()
      self.viewFinishedShare.layoutIfNeeded()
    }) { (finish) -> Void in
      UIView.animateWithDuration(0.3, animations: {
        self.imvCheck.alpha = 1
        self.lblShared.alpha = 1
      })
      //Animation DONE
    }

    Async.main(after: 2) {
      self.hideFinishedView()
    }
  }
  
  private func shareWithIndex(index: Int) {
    let u = users[index]
    showFinishedView()
    postNote(u)
  }

  private func postNote(user: User) {
    
    let UUID = NSUUID().UUIDString
    
    let strNoteTitle = myNote.nTitle
    let strCreateAt = myNote.nCreated
    let info = [KeyNote.noteContent: myNote.nContent,
                KeyNote.noteID: UUID,
                KeyNote.notePriority: myNote.nPriority,
                KeyNote.noteTitle: strNoteTitle,
                KeyNote.noteCreatedAt: strCreateAt,
                KeyNote.noteOwner: AppDelegate.shareInstance().currentUser.uUsername]
    
    //DHIndicator.show()
    if let currentUser = AppDelegate.shareInstance().currentUser, ref = currentUser.uRef {
      ref.child("\(user.uID)/\(KeyUser.userSharedNote)/\(UUID)").setValue(info, withCompletionBlock: {[weak self] (error, noteRef) in
//        guard let strongSelf = self else { return }
        
        //DHIndicator.hide()
        if let error = error {
          print("post note error: \(error.localizedDescription)")
          Common.showAlertWithHUD(error.localizedDescription)
        } else {
//          strongSelf.navigationController?.popViewControllerAnimated(true)
        }
      })
    }
  }
  
  private func hideFinishedView() {
    viewFinishedShare.alpha = 0
    consWidthViewFinished.constant = 0
    consHeightViewFinished.constant = 0
    imvCheck.alpha = 0
    lblShared.alpha = 0
    isShowFinished = false
  }

  // MARK: - Actions
  @IBAction func tapToBack(sender: AnyObject) {
    view.endEditing(true)
    navigationController?.popViewControllerAnimated(true)
  }
}

extension ShareForVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell")

    let u = users[indexPath.row]
    cell?.textLabel?.text = u.uUsername

    let checkImv = UIImageView(image: UIImage(named: "ic_check"))
    if u.isSelected {
      cell?.accessoryView = checkImv
    } else {
      cell?.accessoryView = nil
    }
    cell?.selectionStyle = .None

    return cell!
  }
}

extension ShareForVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    users[indexPath.row].isSelected = true
    tableView.reloadData()
    shareWithIndex(indexPath.row)
  }
}
