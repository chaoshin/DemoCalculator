//
//  CalculatorViewController.swift
//  DemoCalculator
//
//  Created by Chao Shin on 2018/3/31.
//  Copyright © 2018 Chao Shin. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var tempString = "0" // 暫存用的字串
    var isOperator = false  // 是否已經按下operator(+-*/)
    var isStatus = false // 狀態列是否有顯示資訊
    var operatorState = "" // 記錄哪個operator被按下
    var result:Double = 0.0    // 儲存計算結果
    let numberLength = 12 // 螢幕顯示最多12個數字，從0開始所以到11
    
    
    @IBAction func percentageButtonPress(_ sender: UIButton) {
        result = Double(resultLabel.text!)! / 100
        tempString = result.description // 結果回存到暫存字串
        resultLabel.text = result.description // 螢幕顯示結果
        operatorState = "" // 清除Operator
        isOperator = false // 現在輸入的％，不是operator
        statusLabel.text = "" // 清除狀態列上的狀態
        print("Use press %.")
    }
    @IBAction func reverseButtonPress(_ sender: UIButton) {
        result = Double(resultLabel.text!)! * -1 // 反相
        tempString = result.description // 反相結果回存到暫存字串
        resultLabel.text = result.description   // 螢幕顯示結果
        operatorState = "" // 清除Operator
        isOperator = false // 現在輸入的+/-，不是operator
        statusLabel.text = "" // 清除狀態列上的狀態
        print("Use press +/-.")
    }
    @IBAction func acButtonPress(_ sender: UIButton) {
        // 回復成預設值
        tempString = "0"
        isOperator = false
        isStatus = false
        operatorState = ""
        result = 0.0
        resultLabel.text = "0"
        statusLabel.text = ""
        print("Use press AC.")
    }
    @IBAction func operatorButtonPress(_ sender: UIButton) {
        if tempString.count < numberLength { // 限制使用者輸入最多幾位數
            if operatorState != "" && isOperator == false { // Operator為+-x/的哪一個，isOperator需要是false，代表不是重複按Operator
                switch operatorState {
                case "+":
                    result = result + Double(tempString)!
                    
                case "-":
                    result = result - Double(tempString)!
                    
                case "x":
                    result = result * Double(tempString)!
                    
                case "/":
                    result = result / Double(tempString)!
                    
                case "=":
                    print("Operator is \"=\". Do nothing.")
                    
                default:
                    print("Error. Please check you program.")
                    break
                    
                }
            }else {
                result = Double(tempString)! // 重複按下Operator，所以要顯示的還是原先的數值
            }
            
            operatorState = sender.currentTitle!
            print("User input operator is \(operatorState).")
            statusLabel.text = operatorState
            isOperator = true   // 紀錄Operator已經按過
            
            if result.description.count >= numberLength {
                statusLabel.text = "Max \(numberLength) digits." // 在狀態列顯示超過輸入範圍
                tempString = "0"
                resultLabel.text = "Error"
                //tempString = (result.description as NSString).substring(to: numberLength) // 將計算結果取到numberLength的值
            }else {
                if result.truncatingRemainder(dividingBy: 1.0) == 0 { // 判斷計算結果是否有小數，對浮點數取餘數要用truncatingRemainder
                    tempString = (result.description as NSString).substring(to: result.description.count - 2) // 去除小數點與0
                }else{
                    tempString = result.description
                }
            }
            resultLabel.text = tempString // 顯示在螢幕
        }else {
            tempString = "0"
            resultLabel.text = "Error"
        }
    }
    @IBAction func numButtonPress(_ sender: UIButton) {
        let number = sender.currentTitle!
        print("User input number is \(number).")
        
        if tempString == "0" || isOperator {
            if tempString == "0" && number == "00"{ // 現在暫存值為0，輸入00還是需要顯示0
                tempString = "0"
            }else {
                tempString = number // 將輸入的新數字儲存到暫存字串
            }
            if operatorState == "=" {
                if number == "00" { // 當=按下後等於重新開始
                    tempString = "0"
                }
                statusLabel.text = "" // 清除狀態列上的"="，使用者重新輸入數字
                operatorState = "" // 清除operator回到初始值，因為重新計算
                print("Clean up the status bar information.")
            }
            isOperator = false // 現在輸入的是數字，不是operator
        }else {
            if tempString.count < numberLength { // 限制使用者輸入最多幾位數
                if tempString == "0" && number == "00"{ // 現在暫存值為0，輸入00還是需要顯示0
                    tempString = "0"
                }else {
                    tempString += number    // 將輸入的數字加入暫存的字串中
                }
            }else {
                statusLabel.text = "Max \(numberLength) digits."    // 在狀態列顯示超過輸入範圍
                print("Input over the display range. Max \(numberLength) digits.") // 輸入的數字已經超過處理範圍
            }
        }
        resultLabel.text = tempString // 顯示在螢幕
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
