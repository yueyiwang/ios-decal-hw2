//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var someDataStructure: [String] = [""]
    var stored: [String] = []
    var input: String = ""
    var curr_operator = ""
    var int_result: Int = 0
    var double_result: Double = 0
    var prev_c = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
       // print("Update me like one of those PCs")
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        if (content.characters.count > 7) {
            resultLabel.text = content[content.startIndex...content.index(content.startIndex, offsetBy: 6)]
        } else {
            resultLabel.text = content
        }
        // print("Update me like one of those PCs")
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        if (!stored[0].contains(".") && !stored[1].contains(".")) {
            let a:Int! = Int(stored[0])
            let b:Int! = Int(stored[1])
            var double = false
            if (curr_operator == "/" && a % b != 0){
                double_result = calculate(a: stored[0], b: stored[1], operation: curr_operator)
                double = true
            } else {
                int_result = intCalculate(a: a!, b: b!, operation: curr_operator)
            }
            var r:String! = ""
            if (double) {
                r = String(double_result)
            } else {
                r = String(int_result)
            }
            updateResultLabel(r!)
            curr_operator = ""
            stored = [r]
            input = ""
            return r
        } else {
            double_result = calculate(a: stored[0], b: stored[1], operation: curr_operator)
            var r:String! = ""
            if (double_result == floor(double_result)) {
                print("converting to int")
                let i: Int! = Int(double_result)
                r = String(i)
            } else {
                print("still a double")
                let floored = floor(double_result)
                let i = Int(double_result)
                print("double: \(double_result)")
                print("floored: \(floored)")
                print("int: \(i)")
                r = String(double_result)
            }
            updateResultLabel(r!)
            curr_operator = ""
            stored = [r]
            input = ""
            return r
        }
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        if (operation == "+") {
            return a + b
        } else if (operation == "-") {
            return a - b
        } else if (operation == "*") {
            return a * b
        } else if (operation == "/") {
            return a / b
        }
        return 0
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        let a:Double! = Double(a)
        let b:Double! = Double(b)
        if (operation == "+") {
            return a + b
        } else if (operation == "-") {
            return a - b
        } else if (operation == "*") {
            return a * b
        } else if (operation == "/") {
            return a / b
        }
        return 0.0
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        if (curr_operator == "") {
            stored = []
        }
        if (curr_operator != "" && stored.count == 2) {
           /* if (!stored[0].contains(".") && !stored[1].contains(".")) {
                let a:Int? = Int(stored[0])
                let b:Int? = Int(stored[1])
                int_result = intCalculate(a: a!, b: b!, operation: curr_operator)
                let r:String? = String(int_result)
                updateResultLabel(r!)
                curr_operator = ""
                stored = []
            } else {
                double_result = calculate(a: stored[0], b: stored[1], operation: curr_operator)
                let r:String? = String(double_result)
                updateResultLabel(r!)
                curr_operator = ""
                stored = []
                
            }*/
        } else {
            input += sender.content
            updateResultLabel(input)
        }
        prev_c = false
        // Fill me in!
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        print("Operater \(sender.content) was pressed")
        if (sender.content == "=") {
            // print ("stored: \(input)")
            stored += [input]
            if (stored.count == 0) {
            } else if (curr_operator != "" && stored.count == 2) {
                print("doing operation")
                calculate()
            }
            prev_c = false
            
        } else if (sender.content == "C") {
            if (prev_c || curr_operator == "") {
                prev_c = true
                updateResultLabel("0")
                input = ""
                stored = []
                curr_operator = ""
            } else {
                prev_c = true
                updateResultLabel(stored[0])
                input = ""
                if (curr_operator == "") {
                    stored = []
                }
            }
        } else if (sender.content == "+/-") {
            let label: String! = resultLabel.text
            if ((input != "" && input[input.startIndex] == "-") ||
                (label != "" && label[label.startIndex] == "-")) {
                print("becoming positive")
                var update = ""
                var count = 0
                for s in input.characters {
                    if (count == 0) {
                        count = count + 1
                    } else {
                        update += String(s)
                    }
                }
                input = update
            } else if (input != "" || label != "") {
                print("becoming negative")
                var update = "-"
                for s in input.characters {
                    update += String(s)
                }
                input = update
            }
            prev_c = false
            updateResultLabel(input)
        } else {
            // print("Num Operator \(sender.content) was pressed")
            if (stored.count == 1 && input == "") {
                curr_operator = sender.content
            } else {
                stored += [input]
            }
            if (curr_operator != "" && stored.count == 2) {
                print("doing operation")
                calculate()
                curr_operator = sender.content
            } else {
                curr_operator = sender.content
                input = ""
                // updateResultLabel("0")
            }
            prev_c = false
        }
        // Fill me in!
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        print("button \(sender.content) pressed")
        if (sender.content == ".") {
            if (!input.contains(".")) {
                input += "."
                updateResultLabel(input)
            }
        } else if (sender.content == "0") {
            if (input != "0") {
                input += "0"
                updateResultLabel(input)
            }
        }
        prev_c = false
        print("check")
       // Fill me in!
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}

