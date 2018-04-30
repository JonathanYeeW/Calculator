//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Yee on 4/30/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//
// sender tags = 0-9 -> 0-9, 10 -> AC, 11 -> C, 12 -> +/-
//  13 -> +, 14 -> -, 15 -> *, 16 -> /, 17 -> =
//
// Ways to be improved:
// 1. Numbers that are too big cause an error
// 2. I would like to include a way to incorporate the decimal point

import UIKit
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        print("xX_ ViewController _Xx")
        print("## viewDidLoad ##")
        super.viewDidLoad()
        for button in buttonCollection { button.layer.cornerRadius = 32 }
        for button in buttomButtonCollection { button.layer.cornerRadius = 32 }
        updateNumberFieldLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Variables
    let Jonathan = Math()
    var a = 0.0
    var b = 0.0
    var mathfunction: Double?
    var resetEqual = false
    
    //Outlets
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var buttomButtonCollection: [UIButton]!
    @IBOutlet weak var numberFieldLabel: UILabel!
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        print("@@ numberButtonPressed @@")
        print("The button pressed is \(sender.tag)")
        //Conditional below prevents crashing from too large an number being inputed
        if a < 99999999999999999 {
            a = a * 10 + Double(sender.tag)
        }
        updateNumberFieldLabel()
    }//End numberButtonPressed
    
    @IBAction func mathButtonPressed(_ sender: UIButton) {
        print("@@ mathButtonPressed @@")
        print("The button pressed is \(sender.tag)")
        if sender.tag == 10 {
            //AC button has been pressed
            //So we want to clear All Values in the calculator
            a = 0.0
            b = 0.0
            mathfunction = 90909090 //a number that will never be a sender tag
        } else if sender.tag == 11 {
            //C button has been pressed
            //We want only the current a to be cleared
            a = 0.0
        } else if sender.tag == 12 {
            //The +/- button was pressed
            a = a * -1
        } else {
            mathfunction = Double(sender.tag)
            b = a
            a = 0.0
        }
        resetEqual = false
        updateNumberFieldLabel()
    }//End mathButtonPressed
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        print("@@ equalButtonPressed @@")
        printInfo()
        if resetEqual == true {
            if mathfunction == 13 {
                print("Addition, not first time equal pressed")
                a = Jonathan.add(a: b, b: a)
            } else if mathfunction == 14{
                print("Subtraction, not first time equal pressed")
                a = Jonathan.subtract(a: a, b: b)
            } else if mathfunction == 15 {
                print("Multiply, not first time equal pressed")
                a = Jonathan.multiply(a: b, b: a)
            } else if mathfunction == 16 {
                print("Divide, not first time equal pressed")
                a = Jonathan.divide(a: a, b: b)
            }
        } else {
            resetEqual = true
            let temp = a
            if mathfunction == 13 {
                print("Addition")
                a = Jonathan.add(a: b, b: a)
            } else if mathfunction == 14{
                print("Subtraction")
                a = Jonathan.subtract(a: b, b: a)
            } else if mathfunction == 15 {
                print("Multiply")
                a = Jonathan.multiply(a: b, b: a)
            } else if mathfunction == 16 {
                print("Divide")
                if a == 0.0 {
                    resetEqual = false
                    numberFieldLabel.text = "Err"
                    return
                } else {
                    a = Jonathan.divide(a: b, b: a)
                }
            }
            b = temp
        }
        printInfo()
        updateNumberFieldLabel()
    }//End equalButtonPressed()
    
    //Functions
    func updateNumberFieldLabel(){
        print("## updateNumberFieldLabel ##")
        numberFieldLabel.text = String(a)
    }//End updateNumberFieldLabel()
    
    func printInfo(){
        print("")
        print("a is \(a), b is \(b), resetEqual is \(resetEqual)")
        print("")
    }//End printInfo()
}//End Class

