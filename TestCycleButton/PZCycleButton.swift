//
//  PZCycleButton.swift
//  TestCycleButton
//
//  Created by Piotr on 22/11/2016.
//  Copyright © 2016 Piotr Zagawa. All rights reserved.
//

import UIKit

class PZCycleButton: UIView
{
    struct CycleItem
    {
        let color: UIColor
        let text: String
    }
    
    typealias OnClickBlock = (_ sender: PZCycleButton, _ cycleItemIndex: UInt) -> Void

    var onBeforeClickBlock: OnClickBlock? = nil
    var onAfterClickBlock: OnClickBlock? = nil

    private weak var labelView: UILabel?
    
    private var defaultCycleItem = CycleItem(color: UIColor.gray, text: "Button Title")

    private var currentCycleItem: CycleItem
    {
        get
        {
            if (self.cycleItems.count > 0) && (self.cycleItemIndex <= self.maxCycleItemIndex)
            {
                return self.cycleItems[Int(self.cycleItemIndex)]
            }
            
            return self.defaultCycleItem
        }
    }
    
    var cycleItemIndex: UInt = 0
    {
        didSet
        {
            if self.maxCycleItemIndex == 0
            {
                cycleItemIndex = 0

                return
            }
            
            if self.cycleItemIndex > self.maxCycleItemIndex
            {
                self.cycleItemIndex = 0
            }

            let cycleItem = self.currentCycleItem
            
            self.colorValue = cycleItem.color
            self.textString = cycleItem.text
        }
    }
    
    var maxCycleItemIndex: UInt
    {
        if self.cycleItems.count == 0
        {
            return 0
        }
        
        return UInt(self.cycleItems.count - 1)
    }
    
    var cycleItems: [CycleItem] = []
    {
        didSet
        {
            self.cycleItemIndex = 0
        }
    }
    
    var cornerRadius: CGFloat
    {
        get
        {
            return self.layer.cornerRadius
        }
        set
        {
            self.layer.cornerRadius = newValue
        }
    }

    var colorValue: UIColor?
    {
        didSet
        {
            DispatchQueue.main.async
            {
                [weak self] in
                
                UIView.animate(withDuration: 0.2, animations:
                {
                    self?.backgroundColor = self?.colorValue
                })
            }
        }
    }

    var textString: String?
    {
        didSet
        {
            DispatchQueue.main.async
            {
                [weak self] in
                
                if let label = self?.labelView
                {
                    label.text = self?.textString
                }
            }
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        
        self.initialize()
    }
    
    private func initialize()
    {
        self.backgroundColor = UIColor.gray
        
        self.isOpaque = false
        self.cornerRadius = 5
        
        //set view shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1

        //add label view
        let labelView = self.createLabelView()
        
        self.addSubview(labelView)
        
        self.labelView = labelView
        
        //add gesture handling
        let tapHandleSelector = #selector(handleTapGesture(sender:))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: tapHandleSelector)
        
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func createLabelView() -> UILabel
    {
        let rect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        
        let labelView = UILabel(frame: rect)
        
        labelView.textColor = UIColor.white
        labelView.font = UIFont(name: "Helvetica Light", size: 20)
        labelView.textAlignment = NSTextAlignment.center
        
        labelView.translatesAutoresizingMaskIntoConstraints = true
        labelView.autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleTopMargin, .flexibleHeight]
        
        labelView.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        labelView.numberOfLines = 1
        labelView.text = "Button Title"
        
        labelView.layer.shadowColor = UIColor.black.cgColor
        labelView.layer.shadowOffset = CGSize(width: 0, height: 0)
        labelView.layer.shadowRadius = 2
        labelView.layer.shadowOpacity = 0.3
        
        return labelView
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer)
    {
        if sender.state == .ended
        {
            //call BeforeClick event
            if let block = self.onBeforeClickBlock
            {
                print("[PZCycleButton] onBeforeClickBlock [\(self.restorationIdentifier)] cycleItemIndex: \(self.cycleItemIndex)")
                
                block(self, self.cycleItemIndex)
            }
            else
            {
                print("[PZCycleButton] onBeforeClickBlock not set")
            }

            //advance cycle
            self.cycleItemIndex += 1
            
            //call AfterClick event
            if let block = self.onAfterClickBlock
            {
                print("[PZCycleButton] onAfterClickBlock [\(self.restorationIdentifier)] cycleItemIndex: \(self.cycleItemIndex)")

                block(self, self.cycleItemIndex)
            }
            else
            {
                print("[PZCycleButton] onAfterClickBlock not set")
            }
        }
    }

}

