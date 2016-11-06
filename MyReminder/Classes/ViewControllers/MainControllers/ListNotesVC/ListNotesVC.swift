//
//  ListNotesVC.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

class ListNotesVC: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var btnMyNotes: UIButton!
  @IBOutlet weak var btnSharedNotes: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var imvNoNotes: UIImageView!

  // MARK: - Variables
  private var myNotes = [Note]()
  private var sharedNotes = [Note]()
  private var isMyNote = true
  private var _refHandleMyNotes: FIRDatabaseHandle!
  private var _refHandleSharedNotes: FIRDatabaseHandle!

  // MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "ListNotesVC", bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  deinit {

  }

  // MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()

    btnMyNotes.selected = true

    let nib = UINib(nibName: "NoteCell", bundle: nil)
    tableView.registerNib(nib, forCellReuseIdentifier: "NoteCell")
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200
    tableView.contentInset.top = 10
    tableView.contentInset.bottom = 10

    loadData()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    (navigationController as? GGNavigationController)?.naviBar?.hidden = true
  }
  // MARK: - Public methods

  // MARK: - Private methods
  private func loadData() {
    if let u = AppDelegate.shareInstance().currentUser, ref = u.uRef {
//      DHIndicator.show()
//      var task = 2
      _refHandleMyNotes = ref.child("\(u.uID)/\(KeyUser.userNotes)").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {[weak self] (snapshot) in
        guard let strongSelf = self else { return }
        if let note = Mapper<Note>().map(snapshot.value) {
          strongSelf.myNotes.append(note)
          if strongSelf.isMyNote {
            strongSelf.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: strongSelf.myNotes.count - 1, inSection: 0)], withRowAnimation: .Automatic)
          }
        }
//        task -= 1
//        if task <= 0 {
//          DHIndicator.hide()
//        }

      })

      _refHandleSharedNotes = ref.child("\(u.uID)/\(KeyUser.userSharedNote)").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {[weak self] (snapshot) in
        guard let strongSelf = self else { return }
        if let note = Mapper<Note>().map(snapshot.value) {
          strongSelf.sharedNotes.append(note)
          if strongSelf.isMyNote == false {
            strongSelf.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: strongSelf.sharedNotes.count - 1, inSection: 0)], withRowAnimation: .Automatic)
          }
        }
//        task -= 1
//        if task <= 0 {
//          DHIndicator.hide()
//        }

        })
    }
  }


  // MARK: - Actions

  @IBAction func tapToGoListCards(sender: AnyObject) {
    let navi = GGNavigationController(rootViewController: MainScreenVC())
    UIView.transitionWithView(AppDelegate.shareInstance().window!,
                              duration:0.5,
                              options: UIViewAnimationOptions.TransitionFlipFromRight,
                              animations: {
                                let oldState: Bool = UIView.areAnimationsEnabled()
                                UIView.setAnimationsEnabled(false)
                                AppDelegate.shareInstance().window?.rootViewController = navi

                                UIView.setAnimationsEnabled(oldState)
      },
                              completion: {
                                finished in

    })
  }
  @IBAction func tapToMyNotes(sender: AnyObject) {
    isMyNote = true
    btnMyNotes.selected = true
    btnSharedNotes.selected = false
    tableView.reloadData()
  }
  @IBAction func tapToSharedNotes(sender: AnyObject) {
    isMyNote = false
    btnMyNotes.selected = false
    btnSharedNotes.selected = true
    tableView.reloadData()
  }

  @IBAction func tapToSetting(sender: AnyObject) {
    let alertView: UIAlertController = UIAlertController(title: "", message: "Do you want to log out?", preferredStyle:UIAlertControllerStyle.ActionSheet)
    let actionLogout = UIAlertAction(title: "Log Out", style: .Default) { (action) in

      AppDelegate.shareInstance().currentUser = nil

      let navi = GGNavigationController(rootViewController: SignInVC())
      UIView.transitionWithView(AppDelegate.shareInstance().window!,
                                duration:0.5,
                                options: UIViewAnimationOptions.TransitionCurlDown,
                                animations: {
                                  let oldState: Bool = UIView.areAnimationsEnabled()
                                  UIView.setAnimationsEnabled(false)
                                  AppDelegate.shareInstance().window?.rootViewController = navi

                                  UIView.setAnimationsEnabled(oldState)
        },
                                completion: {
                                  finished in

      })
    }
    let actionCancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
    }
    alertView.addAction(actionCancel)
    alertView.addAction(actionLogout)
    presentViewController(alertView, animated: true, completion: nil)
  }
}

extension ListNotesVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isMyNote {
      if myNotes.count == 0 {
        imvNoNotes.hidden = false
      } else {
        imvNoNotes.hidden = true
      }
      return myNotes.count
    }
    if sharedNotes.count == 0 {
      imvNoNotes.hidden = false
    } else {
      imvNoNotes.hidden = true
    }
    return sharedNotes.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell") as! NoteCell

    var note: Note!
    if isMyNote == true {
      note = myNotes[indexPath.row]
    } else {
      note = sharedNotes[indexPath.row]
    }
    cell.setData(note)

    return cell
  }
}

extension ListNotesVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    var note: Note!
    if isMyNote {
      note = myNotes[indexPath.row]
    } else {
      note = sharedNotes[indexPath.row]
    }

    let vc = DetailsNoteVC(note: note, isMyNote: isMyNote)
    navigationController?.pushViewController(vc, animated: true)
  }
}
