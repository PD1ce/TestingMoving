//
//  ViewController.swift
//  TestingMoves
//
//  Created by Philip Deisinger on 2/4/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var squareView: SquareHeroView!
    var oldPos: CGPoint!
    var fallingObjects: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squareView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        
        /** Setup of Gesture Recognizers **/
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
        let screenPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("holdSquare:"))
        screenPressRecognizer.delegate = self
        screenPressRecognizer.minimumPressDuration = 0.05
        self.view.addGestureRecognizer(screenPressRecognizer)
        fallingObjects.append(squareView)
       
    }
    
    func updatePositions() {
        for object in fallingObjects {
            if object.isKindOfClass(SquareHeroView) {
                
            }
        }
    }
    
    func handleCollisions() {
        for object in fallingObjects {
            
        }
    }
    
    func holdSquare(recognizer: UILongPressGestureRecognizer) {
        var tapPoint = recognizer.locationInView(self.view)
        self.squareView?.center.x = tapPoint.x
        //recognizer.view?.center.x = tapPoint.x
        if squareView?.center.x < 25 {
            squareView?.center.x = 25
            //recognizer.enabled = false
        } else if squareView?.center.x > 350 {
            squareView?.center.x = 350
            //recognizer.enabled = false
        }
        //println("x: \(tapPoint.x), y: \(tapPoint.y)")
        //recognizer.enabled = true
    }

    func handleTap(recognizer: UITapGestureRecognizer) {
        println("User Tapped, Fire!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

