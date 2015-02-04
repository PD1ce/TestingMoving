//
//  ViewController.swift
//  TestingMoves
//
//  Created by Philip Deisinger on 2/4/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var squareLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    var squareView: SquareHeroView!
    
    var highScore: UInt8!
    
    var updateTimer: NSTimer!
    var createSquareTimer: NSTimer!
    
    var tapRecognizer: UITapGestureRecognizer!
    var screenPressRecognizer: UILongPressGestureRecognizer!
    
    var fallingObjects: [SquareHeroView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScore = 0
        tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
        screenPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("holdSquare:"))
        screenPressRecognizer.delegate = self
        screenPressRecognizer.minimumPressDuration = 0.05
        self.view.addGestureRecognizer(screenPressRecognizer)
        
        tapRecognizer.enabled = false
        screenPressRecognizer.enabled = false
        
        squareView = SquareHeroView(frame: CGRect(x: 162.5, y: 617, width: 50, height: 50))
        squareView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        
        // Actually displays now
        self.view.addSubview(squareView)
        squareView.hidden = false
    }
    
    func updatePositions() {
        for object in fallingObjects {
            object.updateFallingPosition()
            
            //Place Holder, makes sense but yuck
            //Doesnt work with variable speed
            if object.topY >= 667 {
                highScore!++
                object.removeFromSuperview()
                fallingObjects.removeAtIndex(0)
            }
        }
        squareView.updatePosition()
        //println("leftX: \(squareView.leftX), rightX:\(squareView.rightX), topY: \(squareView.topY), bottomY: \(squareView.bottomY)")
    }
    
    func handleCollisions() {
        for object in fallingObjects {
            if object.detectCollision(squareView) {
                println("Collision detected")
                // Exit Game
                
                //necessary?
                for object in fallingObjects {
                    object.removeFromSuperview()
                }
            
                updateTimer.invalidate()
                createSquareTimer.invalidate()
                
                fallingObjects.removeAll(keepCapacity: false)
                tapRecognizer.enabled = false
                screenPressRecognizer.enabled = false
                
                squareLabel.text = "You lose! Score: \(highScore)"
                highScore = 0
                squareLabel.hidden = false
                startGameButton.titleLabel?.text = "Try Again?"
                startGameButton.hidden = false
            }
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

    @IBAction func startGameTapped(sender: AnyObject) {
        // Move all this to start!
        
        fallingObjects = [SquareHeroView]()
        let newFallingObject = SquareHeroView()
        newFallingObject.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        fallingObjects.append(newFallingObject)
        
        /** Enabling of Gesture Recognizers **/
        tapRecognizer.enabled = true
        screenPressRecognizer.enabled = true
        
        //Remove button and such
        //squareLabel.removeFromSuperview()
        //startGameButton.removeFromSuperview()
        
        squareLabel.hidden = true
        startGameButton.hidden = true
        
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "fireUpdater:", userInfo: nil, repeats: true)
         createSquareTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "fireSquareCreator:", userInfo: nil, repeats: true)
        
        //println("Timer should be initialized")
        //println("\(timer)")
        
    }
    
    func fireUpdater(timer: NSTimer) {
        updatePositions()
        handleCollisions()
        //println("Updater Fired")
    }
    func fireSquareCreator(timer: NSTimer) {
        let xVal = CGFloat(arc4random_uniform(326))
        let yVal = CGFloat(-50)
        let randWidth = CGFloat(arc4random_uniform(50) + 50)
        let randHeight = CGFloat(arc4random_uniform(50) + 50)
        let red = CGFloat(arc4random_uniform(2))
        let green = CGFloat(arc4random_uniform(2))
        //let fallingSpeed = UInt8(arc4random_uniform(10) + 6)
        let fallingSpeed = UInt8(10 + highScore)
        var enemySquare = SquareHeroView(frame: CGRect(x: xVal, y: yVal, width: randWidth, height: randHeight))
        enemySquare.backgroundColor = UIColor(red: red, green: green, blue: 0, alpha: 1)
        enemySquare.fallingSpeed = fallingSpeed
        self.view.addSubview(enemySquare)
        fallingObjects.append(enemySquare)
        //println("Square Creator Fired")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

