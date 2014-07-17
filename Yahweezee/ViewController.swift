//
//  ViewController.swift
//  Yahweezee
//
//  Created by David Barry on 7/1/14.
//  Copyright (c) 2014 David Barry. All rights reserved.
//

import UIKit

func randomInt(#max:UInt32) ->Int {
    return Int(arc4random_uniform(max+1))
}

func randomInt(#min: UInt32, #max: UInt32) -> Int {
    //TODO add code to test for larger/smaller
    return Int((arc4random_uniform((max+1) - min)) + min)
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dieImg = [Die1,Die2,Die3,Die4,Die5]
        rollSet = [5,4,3,2,1]
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
    @IBOutlet var Die4: UIImageView
    @IBOutlet var Die5: UIImageView

    @IBOutlet var lblResults: UILabel
    @IBOutlet var btnRoll_x: UIView  // refers to same label below - works but bad idea??

    @IBAction func btnRoll(sender: AnyObject) {
         doFancyDiceRoll()
    }

    @IBAction func btnSwapDice(sender: AnyObject) {
        swapDice()
    }
    
    var allDice:Int = 5   //how many dice in a single roll
                                // this will need to match with dieImg in viewDidLoad()
    var timer : NSTimer? = nil

    var rolls : Int = 0
    var diceSet : Int = 0       //which dice - regular or faces?
    
    var PipsImg:[UIImage] = []  //the images for the dice set
    
    var rollSet : [Int] = []    //Array with the values of the current rolls
    
    var dieImg:[UIImageView] = []   //Array of the displayed rolls
    
    
    func doFancyDiceRoll() {
        
        //hiding is bad UI, but until i know how to "disable & dim"
        btnRoll_x.hidden = true
        
        lblResults.text = "Rolling......"
        
        rollSet = [ ]

        //timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "preRollAnimation", userInfo: nil, repeats: true);
        // preRollAnimation()
        
        for i in 0 ..< allDice {
            rollSet.append(randomInt(min:1, max:6))
        }

        
        println("Rollset is: \(rollSet)")
        
        paintTheDice(rollSet)
        
        //hiding is bad UI, but until i know how to "disable & dim"
        btnRoll_x.hidden = false
  
        lblResults.text = evalHand(rollSet)
        
    }

    
    func preRollAnimation(){
        for i in 0 ..< allDice {
            dieImg[i].image = PipsImg[randomInt(min: 0, max: 6)]
            
        }
    
        if (++rolls > 15 ) {
            timer?.invalidate()
            timer = nil
            rolls = 0   // DCB added this presumed missing line
        }
    }
    
    
    func paintTheDice(diceSet:[Int]){
        
        println("paintthedice \(diceSet)")
        for i in 0 ..< allDice {
            dieImg[i].image = PipsImg[diceSet[i]]
        }
        
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
    
    
    func evalHand(z:[Int]) -> String {
        
        
            var die:[Int]
        
            die = z
        
            die.sort { $0 < $1 }
        
        println("sorted is \(die)")
            
        if      (die[0] == die[4]){
            return "5 of a kind!!!"}
        
        else if (die[0] == die [3] ||
                 die[1] == die [4]){
            return "4 of a kind!!!"}
        
        else if ((die[0] == die [2]) && (die[3] == die [4])) ||
                ((die[0] == die [1]) && (die[2] == die [4])) {
            return "Full house!!"}
        
        else if (die[0] == die [2]) ||
                (die[1] == die [3]) ||
                (die[2] == die [4]) {
            return "3 of a kind!!!"}
    
        else if ((die[0] == die [1]) && (die[2] == die [3])) ||
                ((die[0] == die [1]) && (die[3] == die [4])) ||
                ((die[1] == die [2]) && (die[3] == die [4])) {
            return "Two Pair!!"}
        
        else if (die[0] == die [1]) ||
                (die[1] == die [2]) ||
                (die[2] == die [3]) ||
                (die[3] == die [4]) {
                return "Pair!"}
        else {
                return "Zilcho!"}
        }
    
    
    

    
    func swapDice(){
        
        diceSet = ++diceSet % 2
        loadDiceSet(diceSet)
        paintTheDice(rollSet)
        
    }
}



