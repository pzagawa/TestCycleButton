//
//  ViewController.swift
//  TestCycleButton
//
//  Created by Piotr on 22/11/2016.
//  Copyright © 2016 Piotr Zagawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var cycleButton1: PZCycleButton!
    @IBOutlet weak var cycleButton2: PZCycleButton!
    @IBOutlet weak var cycleButton3: PZCycleButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.cycleButton1.cycleItems =
        [
            
            PZCycleButton.CycleItem(color: UIColor(colorLiteralRed: 1, green: 0.7, blue: 0.7, alpha: 1), text: "RED"),
            PZCycleButton.CycleItem(color: UIColor(colorLiteralRed: 0.2, green: 0.9, blue: 0.5, alpha: 1), text: "GREEN"),
            PZCycleButton.CycleItem(color: UIColor(colorLiteralRed: 0.5, green: 0.7, blue: 1, alpha: 1), text: "BLUE"),
        ]

        self.cycleButton2.cycleItems =
        [
            PZCycleButton.CycleItem(color: UIColor(colorLiteralRed: 0.2, green: 0.9, blue: 0.5, alpha: 1), text: "GREEN"),
            PZCycleButton.CycleItem(color: UIColor(colorLiteralRed: 1, green: 0.7, blue: 0.7, alpha: 1), text: "RED"),
            PZCycleButton.CycleItem(color: UIColor(colorLiteralRed: 0.5, green: 0.7, blue: 1, alpha: 1), text: "BLUE"),
            PZCycleButton.CycleItem(color: UIColor(colorLiteralRed: 1.0, green: 0.75, blue: 0.5, alpha: 1), text: "ORANGE"),
        ]
        
        self.cycleButton3.textString = "CYCLE NOT SET"

        //MARK: example BeforeClick usage
        self.cycleButton1.onBeforeClickBlock =
        {
            (sender: PZCycleButton, cycleItemIndex: UInt) in

            //handle tap event before cycleItemIndex is updated
        }

        self.cycleButton1.onAfterClickBlock =
        {
            (sender: PZCycleButton, cycleItemIndex: UInt) in
            
            self.informationLabel.text = "BUTTON 1. STATE: \(cycleItemIndex)"
        }

        self.cycleButton2.onAfterClickBlock =
        {
            (sender: PZCycleButton, cycleItemIndex: UInt) in
            
            self.informationLabel.text = "BUTTON 2. STATE: \(cycleItemIndex)"
        }

        self.cycleButton3.onAfterClickBlock =
        {
            (sender: PZCycleButton, cycleItemIndex: UInt) in
            
            self.informationLabel.text = "BUTTON 3. STATE: \(cycleItemIndex)"
        }

    }

}

