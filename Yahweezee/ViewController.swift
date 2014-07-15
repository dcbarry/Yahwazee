//
//  ViewController.swift
//  Yahweezee
//
//  Created by David Barry on 7/1/14.
//  Copyright (c) 2014 David Barry. All rights reserved.
//

import UIKit

func randomInt(#max:UInt32) ->Int {
    return Int(arc4random_uniform(max+1)) + 1
}

func randomIntRange(#min: UInt32, #max: UInt32) -> Int {
    //TODO add code to test for larger/smaller
    return Int((arc4random_uniform((max+1) - min)) + min)
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   

        rollSet = [6,6,6]
        diceSet = 0
        loadDiceSet(diceSet)
        paintTheDice(rollSet)
        

        lblResults.text = "Let's Roll!"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet var Die1: UIImageView
    @IBOutlet var Die2: UIImageView
    @IBOutlet var Die3: UIImageView

    @IBOutlet var lblResults: UILabel
    
    
    @IBOutlet var btnRoll_x: UIView  // refers to same label below - works but bad idea??

    @IBAction func btnRoll(sender: AnyObject) {
         doFancyDiceRoll()
    }

    @IBAction func btnSwapDice(sender: AnyObject) {
        swapDice()
    }
    
    
    var timer : NSTimer? = nil
    var rolls : Int = 0
    var PipsImg:UIImage[] = []
    
    var diceSet : Int = 0
    
    var rollSet : Int[] = []
    
    
    
    func doFancyDiceRoll() {
        
        //hiding is bad UI, but until i know how to "disable & dim"
        btnRoll_x.hidden = true
        
        lblResults.text = "Rolling......"
        
        rollSet = [ ]

        //timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "preRollAnimation", userInfo: nil, repeats: true);
        // preRollAnimation()
        
        rollSet.append(randomIntRange(min:0, max:6))
        rollSet.append(randomIntRange(min:0, max:6))
        rollSet.append(randomIntRange(min:0, max:6))

        println("Rollset is: \(rollSet)")
        
        paintTheDice(rollSet)
        
        //hiding is bad UI, but until i know how to "disable & dim"
        btnRoll_x.hidden = false
        
        lblResults.text = "Sorry, try again....."
        
        lblResults.text = "\(rollSet[0]) and \(rollSet[1]) and \(rollSet[2])"

        
        if ( (rollSet[0] == rollSet[1] ) && (rollSet[1] == rollSet[2] ) ) {
                    lblResults.text = "Jackpot!!!!"
        }
        
    }


    
    func preRollAnimation(){
        Die1.image = PipsImg[randomIntRange(min:0, max:6)]
        Die2.image = PipsImg[randomIntRange(min:0, max:6)]
        Die3.image = PipsImg[randomIntRange(min:0, max:6)]
    
        if (++rolls > 15 ) {
            timer?.invalidate()
            timer = nil
            rolls = 0   // DCB added this presumed missing line
        }
    }
    
    
    func paintTheDice(diceSet:Int[]){
        
        println("paintthedice \(diceSet)")
        Die1.image = PipsImg[diceSet[0]]
        Die2.image = PipsImg[diceSet[1]]
        Die3.image = PipsImg[diceSet[2]]
        
    }
    
    

 
    func loadDiceSet(set:Int) {
        
        switch set{

            case 0: PipsImg =
                    [   (UIImage(named: "goofy")),
                        (UIImage(named: "pip-1")),(UIImage(named: "pip-2")),
                        (UIImage(named: "pip-3")),(UIImage(named: "pip-4")),
                        (UIImage(named: "pip-5")),(UIImage(named: "pip-6"))   ]
            
            case 1: PipsImg =
                    [   (UIImage(named: "goofy")),
                        (UIImage(named: "LiamGQ")),(UIImage(named: "HarryGQ")),
                        (UIImage(named: "LouisGQ")),(UIImage(named: "NiallGQ")),
                        (UIImage(named: "ZaynGQ")),(UIImage(named: "Team"))   ]
            
            default: break
        }

    }

    
    func swapDice(){
        
        diceSet = ++diceSet % 2
        loadDiceSet(diceSet)
        paintTheDice(rollSet)
        
    }
}



