//
//  SwipeCardPersonalView.swift
//  Pack
//
//  Created by admin on 6/3/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit

class SwipeCardPersonalView: UIView {
  var personalString = ""
  var isBegin = false

  override func layoutSubviews() {
    if isBegin == false {
      isBegin = true
      setupPersonalitiesView(personalString)
    }
  }

  // MARK: - Private
  private func setupPersonalitiesView(interests: String) {
    if interests.characters.count == 0 {
      return
    }

    let personalities = interests.componentsSeparatedByString("|")
    if personalities.count == 0 {
      return
    }

    var labelPersonalities = [UILabel]()
    for personal in personalities {
      let lbl = UILabel()
      lbl.text = personal
      makeupButton(lbl)
      labelPersonalities.append(lbl)
    }
    let space: CGFloat = 10.0
    let pading: CGFloat = 0.0
    let currentY: CGFloat = pading
    var lastPoint = CGPoint.zero
    var lastFrame = CGRect.zero

    for l in labelPersonalities {

      if lastFrame == CGRect.zero {
        lastPoint = CGPoint(x: pading, y: currentY)
        l.frame.origin = lastPoint
        lastFrame = l.frame
      } else {
        if lastFrame.maxX + space + CGRectGetWidth(l.frame) > bounds.width - pading {
          return
        } else {
          lastPoint = CGPoint(x: lastFrame.maxX + space, y: currentY)
        }
        l.frame.origin = lastPoint
        lastFrame = l.frame
      }
      addSubview(l)
    }
  }

  private func makeupButton(label: UILabel) {
    label.font = UIFont.systemFontOfSize(12)
    label.textColor = UIColor.whiteColor()
    let widthButton = getWidthText(label.text!, font: label.font)
    label.frame = CGRect(x: 0, y: 0, width: widthButton + 30, height: 32)
    label.textAlignment = .Center
    label.backgroundColor = UIColor(red: 81/255, green: 156/255, blue: 1, alpha: 1)
    label.layer.cornerRadius = 16
    label.layer.masksToBounds = true
  }

  private func getWidthText(str: String, font: UIFont) -> CGFloat {
    let lbl = UILabel()
    lbl.font = font
    lbl.text = str
    return lbl.sizeThatFits(CGSize(width: 10000, height: 40)).width
  }
}
