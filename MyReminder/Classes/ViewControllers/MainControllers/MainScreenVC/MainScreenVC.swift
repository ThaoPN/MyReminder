//
//  MainScreenVC.swift
//  Pack
//
//  Created by Le Kim Tuan on 5/6/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

class MainScreenVC: UIViewController {

  // MARK: - Outlets
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var viewInfoUser: KolodaView!
  @IBOutlet weak var viewContent: UIView!
  @IBOutlet weak var consHeightViewInfoUser: NSLayoutConstraint!
  @IBOutlet weak var consHeightContentView: NSLayoutConstraint!
  @IBOutlet weak var imvNoNote: UIImageView!

  // MARK: - Variables
  private var notes = [Note]()

  // MARK: - Lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "MainScreenVC", bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    (navigationController as? GGNavigationController)?.naviBar?.hidden = true

    viewInfoUser.refreshFirstCard()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configViewDidLoad()
    viewInfoUser.dataSource = self
    viewInfoUser.delegate = self

    loadData()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    if let _ = NSUserDefaults.standardUserDefaults().objectForKey(kTutorialMainScreen) {

    } else {
      NSUserDefaults.standardUserDefaults().setValue("1", forKey: kTutorialMainScreen)
      let vc = TutorialVC(isAddNote: false)
      presentViewController(vc, animated: true, completion: nil)
    }
  }

  // MARK: - Private method
  private func presentStackViewController(parentVC: UIViewController, presentVC: UIViewController, animation: Bool) {
    if let presented = parentVC.presentedViewController {
      presentStackViewController(presented, presentVC: presentVC, animation: animation)
    } else {
      parentVC.presentViewController(presentVC, animated: true, completion: nil)
    }
  }

  private func configViewDidLoad() {
    consHeightContentView.constant = screenHeight
    if Common.isIPhone5() {
      consHeightViewInfoUser.constant = 388
    } else if Common.isIPhone6() {
      consHeightViewInfoUser.constant = 440
    } else if Common.isIPhone4() {
      consHeightViewInfoUser.constant = 388
    } else if Common.isIPhone6plus() {
      consHeightViewInfoUser.constant = 470
    }
    //loadingView.delegate = self
    //loadUsers()
  }

  private func loadData() {
    if let u = AppDelegate.shareInstance().currentUser, ref = u.uRef {
      //      DHIndicator.show()
      //      var task = 2
      ref.child("\(u.uID)/\(KeyUser.userNotes)").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {[weak self] (snapshot) in
        guard let strongSelf = self else { return }
        print(snapshot.value)
        if let note = Mapper<Note>().map(snapshot.value) {
          strongSelf.notes.append(note)
          strongSelf.viewInfoUser.reloadData()
        }
      })
    }
  }

  // MARK: - Actions
  @IBAction func tapToAddNote(sender: AnyObject) {
    let vc = AddNoteVC()
    navigationController?.pushViewController(vc, animated: true)
  }

  @IBAction func tapToRedo(sender: AnyObject) {
    viewInfoUser.revertAction()
  }

  @IBAction func tapToListNotes(sender: AnyObject) {
    let navi = GGNavigationController(rootViewController: ListNotesVC())
    UIView.transitionWithView(AppDelegate.shareInstance().window!,
                              duration:0.5,
                              options: UIViewAnimationOptions.TransitionFlipFromLeft,
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

}



// MARK: - KolodaViewDelegate
extension MainScreenVC: KolodaViewDelegate {
  func koloda(koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {

    print("index card: \(index) direction: \(direction)")
//    if checkForTheFirst(direction) {
//      showTheFirstAlert(direction, index: index)
//    } else {
//      let user = listUser[Int(index)]
//      switch direction {
//      case .Left:
//        api.dislikeUser(user.id)
//      case .Right:
//        targetUser = user
//        api.likeUser(user.id)
//      default:
//        break
//      }
//    }
  }

  func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
    print("Out of card")
//    loadUsers()
    viewInfoUser.resetCurrentCardNumber()
  }

  func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
    print("tap to card")
    let note = notes[Int(index)]
    let vc = DetailsNoteVC(note: note)
    navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - KolodaViewDataSource
extension MainScreenVC: KolodaViewDataSource {

  func koloda(kolodaNumberOfCards koloda: KolodaView) -> UInt {
    if notes.count == 0 {
      imvNoNote.hidden = false
    } else {
      imvNoNote.hidden = true
    }
    return UInt(notes.count)
  }

  func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
    let card = NSBundle.mainBundle().loadNibNamed("CustomSwipeCardView", owner: self, options: nil)[0] as! CustomSwipeCardView
    //let user = listUser[Int(index)]
    //card.setupCard(user)
    let note = notes[Int(index)]
    card.setupCard(note)
    card.delegate = self

    return card
  }

  func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
    return NSBundle.mainBundle().loadNibNamed("OverlayView", owner: self, options: nil)[0] as? OverlayView
  }
}

extension MainScreenVC: CustomSwipeCardViewDelegate {
  func shareNote(note: Note) {
    let vc = ShareForVC(note: note)
    navigationController?.pushViewController(vc, animated: true)
  }
}
