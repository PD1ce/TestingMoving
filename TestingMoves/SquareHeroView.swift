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
    var fallingSpeed: UInt8!
    
    //Can't be statically put as 25
    // BUG
    func updatePosition() {
        leftX =     self.center.x - 25
        rightX =    self.center.x + 25
        topY =      self.center.y - 25
        bottomY =   self.center.y + 25
    }
    
    func updateFallingPosition() {
        if fallingSpeed != nil {
            self.center.y += CGFloat(fallingSpeed!)
        }
        leftX =     self.center.x - 25
        rightX =    self.center.x + 25
        topY =      self.center.y - 25
        bottomY =   self.center.y + 25
    }
    
    //** BUG!  When all the way left it can collide! **//
    func detectCollision(square: SquareHeroView) -> Bool {
        if (self.leftX <= square.rightX) && (self.rightX >= square.rightX) && (self.bottomY >= square.topY) {
            return true
        }
        if (self.rightX >= square.leftX) && (self.leftX <= square.leftX) && (self.bottomY >= square.topY) {
            return true
        }
        //Might be all cases?
        
        return false
    }
}
