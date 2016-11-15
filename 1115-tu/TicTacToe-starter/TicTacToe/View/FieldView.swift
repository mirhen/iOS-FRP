//
//  FieldView.swift
//  TicTacToe
//
//  Created by Nikolas Burk on 05/10/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit

class FieldView: UILabel {
  
  enum State: String {
    case x = "X"
    case o = "O"
    case empty = ""
  }
  
  let xPosition: Int // range: [0, 1, 2]
  let yPosition: Int // range: [0, 1, 2]
  
  var state: State = .empty {
    didSet {
      text = state.rawValue
    }
  }
  
  init(frame: CGRect, xPosition: Int, yPosition: Int) {
    assert(xPosition >= 0 && xPosition <= 2, "value '\(xPosition)' is not allowed for x position of field")
    assert(yPosition >= 0 && yPosition <= 2, "value '\(yPosition)' is not allowed for y position of field")
    self.xPosition = xPosition
    self.yPosition = yPosition
    super.init(frame: frame)
    isUserInteractionEnabled = true
    textAlignment = .center
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let font = adaptiveFont()
    self.font = font
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension FieldView {
  
  func adaptiveFont(minSize: CGFloat = 1.0) -> UIFont {
    var tmpFontSize: CGFloat = 1.0
    
    var textStillFits = true
    while textStillFits {
      tmpFontSize = tmpFontSize + 1
      let font = UIFont.systemFont(ofSize: tmpFontSize)
      // TODO: improve algorithm
      let label = UILabel(frame: CGRect.zero)
      label.font = font
      label.text = FieldView.State.o.rawValue
      label.sizeToFit()
      let textFrame = label.frame
      let difference = bounds.size.height - textFrame.size.height
      if difference > 0.0 {
        textStillFits = true
      }
      else {
        textStillFits = false
      }
    }
    
    return UIFont.systemFont(ofSize: tmpFontSize)
  }
  
}





