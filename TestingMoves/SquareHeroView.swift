//
//  SquareHeroView.swift
//  TestingMoves
//
//  Created by Philip Deisinger on 2/4/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class SquareHeroView : UIView {
    var leftX: CGFloat!
    var rightX: CGFloat!
    var topY: CGFloat!
    var bottomY: CGFloat!
    
    func updatePosition() {
        leftX =     self.center.x - 25
        rightX =    self.center.x + 25
        topY =      self.center.y - 25
        bottomY =   self.center.y + 25
    }
}
