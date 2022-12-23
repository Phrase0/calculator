//
//  ViewController.swift
//  calculator
//
//  Created by Peiyun on 2022/12/21.
//

//加入加減乘除enum
enum OpetationType{
    case add
    case subtract
    case multiply
    case divide
    case none
}



import UIKit

class ViewController: UIViewController {

    //顯示的值
    @IBOutlet weak var label: UILabel!
    
    //按鍵的label(用在導圓角上)
    @IBOutlet var numbersLabel: [UIButton]!
    
    //儲存目前畫面上的數字
    var numberOnScreen:Double = 0
    //運算之前畫面上顯現的數字
    var previousNumber:Double = 0
    //記錄目前是不是在運算的過程當中
    var performingMath = false
    
    //紀錄是什麼樣的運算
    var operation:OpetationType = .none
    
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
    @IBAction func add(_ sender: UIButton) {
        label.text = "＋"
        operation = .add
        performingMath = true
        //因為要相加之後的數，故先將numberOnScreen上的數字存入previousNumber
        previousNumber = numberOnScreen
    }
        
    
    @IBAction func subtract(_ sender: UIButton) {
        label.text = "－"
        operation = .subtract
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    
    @IBAction func multiply(_ sender: UIButton) {
        label.text = "×"
        operation = .multiply
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    
    @IBAction func divide(_ sender: UIButton) {
        label.text = "÷"
        operation = .divide
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    
    //等號
    @IBAction func giveMeAnswer(_ sender: UIButton) {
        if performingMath == true{
            switch operation {
            case .add:
                numberOnScreen = previousNumber + numberOnScreen
                makeOKNumberString(from: numberOnScreen)
                
            case .subtract:
                numberOnScreen = previousNumber - numberOnScreen
                makeOKNumberString(from: numberOnScreen)
                
            case .multiply:
                numberOnScreen = previousNumber * numberOnScreen
                makeOKNumberString(from: numberOnScreen)
                
            case .divide:
                numberOnScreen = previousNumber / numberOnScreen
                makeOKNumberString(from: numberOnScreen)
                
            case .none:
                label.text = "0"
            }
            performingMath = false
            startNew = true
        }
    }
      
    
    //AC
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        //所有值回歸初始值
        numberOnScreen = 0
        previousNumber = 0
        performingMath = false
        startNew = true
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
    
    
    //運算結果是整數時，不顯示0
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
    
    
    
    
    
    
    

}
