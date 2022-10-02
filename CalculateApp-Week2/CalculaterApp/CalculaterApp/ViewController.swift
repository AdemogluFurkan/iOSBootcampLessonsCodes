//
//  ViewController.swift
//  CalculaterApp
//
//  Created by Furkan Ademoğlu on 27.09.2022.
//

import UIKit
final class ViewController: UIViewController {
    
    var didOperandButtonTapped = false
    
    var result : Double = .zero{
        didSet{
            resultLabel.text = "\(result)"
        }
    }
    
    var numbers = [Double]()
    
    var displayValue : String? {
        get {
            resultLabel.text
        }
        set {
            guard let newValue = newValue else{
                return
            }
            if resultLabel.text == "0" {
                resultLabel.text! = newValue
            }else{
                resultLabel.text! += newValue
            }
        }
    }

    @IBOutlet private weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction private func didTapSevenDigitButton(_ sender:UIButton){
        
        if didOperandButtonTapped{
            resultLabel.text = "0"
            didOperandButtonTapped = false
        }
        guard let currentTitle = sender.currentTitle else {return}
        displayValue = currentTitle
    }
    
    @IBAction private func didTapOperandButton(_ sender: UIButton){
        didOperandButtonTapped = true
        guard let currentTitle = sender.currentTitle else {return}
        
        switch currentTitle {
        case "*":
            if numbers.count>1{
                guard let firstNumber = numbers.popLast(),
                      let secondNumber = numbers.popLast() else {return}
                let result = multiply(firstNumber: firstNumber, secondNumber: secondNumber)
                self.result = result
                numbers.append(result)
            }else{
                guard let displayValueDouble = Double(displayValue ?? "0") else {
                    return
                }

                numbers.append(displayValueDouble)
            }
        case "/":
            if numbers.count>1{
                guard let firstNumber = numbers.popLast(),
                      let secondNumber = numbers.popLast() else {return}
                let result = divide(firstNumber: firstNumber, secondNumber: secondNumber)
                self.result = result
                numbers.append(result)
            }else{
                guard let displayValueDouble = Double(displayValue ?? "0") else {
                    return
                }

                numbers.append(displayValueDouble)
            }
        case "-":
            if numbers.count>1{
                guard let firstNumber = numbers.popLast(),
                      let secondNumber = numbers.popLast() else {return}
                let result = subtract(firstNumber: firstNumber, secondNumber: secondNumber)
                self.result = result
                numbers.append(result)
            }else{
                guard let displayValueDouble = Double(displayValue ?? "0") else {
                    return
                }

                numbers.append(displayValueDouble)
            }
        case "+":
            if numbers.count>1{
                guard let firstNumber = numbers.popLast(),
                      let secondNumber = numbers.popLast() else {return}
                let result = sum(firstNumber: firstNumber,
                                 secondNumber: secondNumber)
                self.result = result
                numbers.append(result)
            }else{
                guard let displayValueDouble = Double(displayValue ?? "0") else {
                    return
                }

                numbers.append(displayValueDouble)
            }
        case "=":
            guard let displayValueDouble = Double(displayValue ?? "0") else {
                return
            }
            resultLabel.text = "\(numbers.popLast() ?? 0)"
            numbers.append(displayValueDouble)
        default:
            break
        }
    }
    
    @IBAction private func didTapClearButton(_ sender: UIButton){
        resultLabel.text = "0"
        numbers.removeAll()
    }
    
    func sum<T:Numeric>(firstNumber:T,secondNumber:T)->T{
        firstNumber + secondNumber
        
    }
    
    func subtract<T:Numeric>(firstNumber:T,secondNumber:T)->T{
        firstNumber - secondNumber
    }
    func divide(firstNumber:Double,secondNumber:Double) -> Double{
        if secondNumber==0{
            let alert = UIAlertController(title: "Alert", message: "Invalid Action!", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
            return Double(0)
        }else{
            firstNumber / secondNumber
        }
    return Double(0)
    }
    
    func multiply(firstNumber:Double,secondNumber:Double)->Double{
        firstNumber * secondNumber
    }


}

