//
//  ListNotesVC.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit

class ListNotesVC: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var btnMyNotes: UIButton!
  @IBOutlet weak var btnSharedNotes: UIButton!
  @IBOutlet weak var tableView: UITableView!

  // MARK: - Variables

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
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    (navigationController as? GGNavigationController)?.naviBar?.hidden = true
  }
  // MARK: - Public methods

  // MARK: - Private methods

  // MARK: - Actions
  @IBAction func tapToBack(sender: AnyObject) {
  }
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
    btnMyNotes.selected = true
    btnSharedNotes.selected = false
  }
  @IBAction func tapToSharedNotes(sender: AnyObject) {
    btnMyNotes.selected = false
    btnSharedNotes.selected = true
  }
}

extension ListNotesVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell") as! NoteCell

    return cell
  }
}
