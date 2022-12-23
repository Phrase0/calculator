//
//  ViewController.swift
//  calculator
//
//  Created by Peiyun on 2022/12/21.
//


import UIKit

class ViewController: UIViewController {

    //顯示的值
    @IBOutlet weak var label: UILabel!
    
    //按鍵的label(用在導圓角上)
    @IBOutlet var numbersLabel: [UIButton]!
    
    //儲存目前畫面上的數字
    var numberOnScreen:Double = 0
    
    //記錄算式的字串(因先乘除後加減的公式需帶入string，故先建一個字串)
    var equation:String = ""
    
    //記錄目前是不是在運算的過程當中
    var performingMath = false
    
    //加入變數紀錄是重啟新的計算
    var startNew = true
    
    

    //action:
    
    //按鍵0~9
    @IBAction func numbers(_ sender: UIButton) {

        let inputNumber = sender.tag

        if label.text != nil{
            if startNew == true{
                label.text = String(inputNumber)
                startNew = false
            }else{
                // 若label為0，則輸入數字
                if label.text == "0" || label.text == "＋" || label.text == "－" || label.text == "×" || label.text == "÷" {
                    label.text = String(inputNumber)
                }else{
                    // 若label前面有數字，則輸入前面數字+後面數字
                    label.text = label.text! + String(inputNumber)
                }
            }
            //成功則轉型成Double，失敗則存0
            numberOnScreen = Double(label.text!) ?? 0

        }
    }
    
    
    //按鍵加減乘除
    @IBAction func opration(_ sender: UIButton) {
        performingMath = true
        
        switch sender.tag {
        case 1:
            label.text = "＋"
            //ex: equation = 0 numberOnScreen = 3 equation = "0" + "3" + "+"
            //ex: equation = "0" + "3" + "+" numberOnScreen = 2 equation = "0" + "3" + "+" + "2" + "+"
            equation += String(numberOnScreen) + "+"
            print(equation)
            
        case 2:
            label.text = "－"

            equation += String(numberOnScreen) + "-"
            print(equation)
            
        case 3:
            label.text = "×"
            equation += String(numberOnScreen) + "*"
            print(equation)
            
        case 4:
            label.text = "÷"
            equation += String(numberOnScreen) + "/"
            print(equation)

        default:
            return
        }
        
    }
    

    //等號
    @IBAction func giveMeAnswer(_ sender: UIButton) {
        if performingMath == true{
            equation += String(numberOnScreen)
            print(equation)
            
            //解決除以0會失敗的問題
            if equation.contains("/0.0"){
                print("錯誤")
                label.text = "錯誤"
            }else{
 
                //先乘除後加減的公式：
                //let exp: NSExpression = NSExpression(format: 運算式String)
                //let result: Double = exp.expressionValue(with:nil, context: nil) as? Double
                let expression = NSExpression(format: equation)
                if let result = expression.expressionValue(with: nil, context: nil) as? Double{
                    makeOKNumberString(from: result)
                }
                
            }
            
           performingMath = false
            startNew = true
            equation = ""
        }
    }
      
    
    //AC
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        //所有值回歸初始值
        numberOnScreen = 0
        equation = ""
        performingMath = false
        startNew = true
    }
    
    
    //運算結果是整數時，不顯示.0
    func makeOKNumberString(from number:Double){
        
        //出現小數時最多出現第8位
        //加入變數：最後要顯現的文字
        var okText:String
        
        //floor:四捨五入，並回傳小於或等於參數的整數
        if floor(number) == number{
            okText = String(Int(number))
        }else{
            okText = String(number)
        }
        //出現小數時最多出現第8位
        if okText.count >= 8{
            //prefix(7):取前8位
            okText = String(okText.prefix(8))
        }
        
        label.text = okText
    }
    
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //圖片導圓角
    override func viewDidAppear(_ animated: Bool) {
        //不在viewDidLoad()做的原因為畫面大小此時尚未完全確定，讀入時會產生誤差。使用viewDidAppear這方法是畫面已顯示在螢幕上才會執行
       
        for i in 0...18{
            numbersLabel[i].layer.cornerRadius = numbersLabel[i].frame.size.height/2
            numbersLabel[i].clipsToBounds = true
        }
    }
    
    //狀態列白色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}
