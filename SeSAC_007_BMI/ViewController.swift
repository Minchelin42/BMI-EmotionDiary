//
//  ViewController.swift
//  SeSAC_007_BMI
//
//  Created by 민지은 on 2024/01/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var nameView: UIView!
    @IBOutlet var heightView: UIView!
    @IBOutlet var weightView: UIView!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var hideButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewDesign()
        
        inputLabelDesign(nameLabel, text: "성함이 어떻게 되시나요?")
        inputLabelDesign(heightLabel, text: "키가 어떻게 되시나요?")
        inputLabelDesign(weightLabel, text: "몸무게는 어떻게 되시나요?")
        
        nameTextField.borderStyle = .none
        
        textFieldDesign(heightTextField)
        textFieldDesign(weightTextField)
        
        textFieldViewDesign(nameView)
        textFieldViewDesign(heightView)
        textFieldViewDesign(weightView)
        
        hideButtonDesign()
        randomButtonDesign()
        resultButtonDesign()
        resetButtonDesign()
        
        setUserInfo()
  
    }
    
    func setUserInfo() {
        let myName = UserDefaults.standard.string(forKey: "name")
        let myHeight = UserDefaults.standard.double(forKey: "height")
        let myWeight = UserDefaults.standard.double(forKey: "weight")
        
        nameTextField.text = myName
        
        if myHeight == 0.0 && myWeight == 0.0 {
            heightTextField.text = ""
            weightTextField.text = ""
        } else if myHeight == 0.0 {
            heightTextField.text = ""
            weightTextField.text = "\(myWeight)"
        } else if myWeight == 0.0 {
            heightTextField.text = "\(myHeight)"
            weightTextField.text = ""
        } else {
            heightTextField.text = "\(myHeight)"
            weightTextField.text = "\(myWeight)"
        }
    }
    
    
    @IBAction func inputClear(_ sender: UITextField) {
        // 2개의 정보 중 한가지만 입력 후 앱을 종료하더라도 저장을 해놓기 위함
        if let height = Double(heightTextField.text ?? ""){
            UserDefaults.standard.set(height, forKey: "height")
        }
        
        if let weight = Double(weightTextField.text ?? "") {
            UserDefaults.standard.set(weight, forKey: "weight")
        }
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func resultButtonTapped(_ sender: UIButton) {
        guard let height = Double(heightTextField.text ?? ""), let weight = Double(weightTextField.text ?? "") else {
            let alert = UIAlertController(title: "BMI 결과", message: "키와 몸무게를 제대로 입력해주세요", preferredStyle: .alert)
            
            let clearButton = UIAlertAction(title: "확인", style: .cancel)
            
            alert.addAction(clearButton)
            
            present(alert, animated: true)
            
            return
        }
        
        
        let result = "\(getBMI(height: height / 100, weight: weight))"
        
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(weight, forKey: "weight")

        let alert = UIAlertController(title: "[ 결과 ]", message: "\(result)", preferredStyle: .alert)
        
        let clearButton = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(clearButton)
        
        present(alert, animated: true)
        
        topViewDesign()
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        
        let weight = String(format: "%.1f", Double.random(in: 40...120))
        let height = String(format: "%.1f", Double.random(in: 150...200))
        
        heightTextField.text = height
        weightTextField.text = weight
    }
    
    @IBAction func nameInput(_ sender: UITextField) {
        // Did end on Exit
        view.endEditing(true)
    }
    
    @IBAction func nameInputClear(_ sender: Any) {
        // Editing Did End
        UserDefaults.standard.set(nameTextField.text!, forKey: "name")
        topViewDesign()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {

        let alert = UIAlertController(title: "데이터 전체 삭제", message: "삭제하시면 복구하실 수 없습니다\n삭제를 진행하시겠습니까?", preferredStyle: .alert)

        let DeleteButton = UIAlertAction(title: "삭제", style: .destructive) { action in
            UserDefaults.standard.set("", forKey: "name")
            UserDefaults.standard.set(0.0, forKey: "bmi")
            UserDefaults.standard.set(0.0, forKey: "height")
            UserDefaults.standard.set(0.0, forKey: "weight")
            
            self.topViewDesign()
            self.setUserInfo()
        }
        let CancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(DeleteButton)
        alert.addAction(CancelButton)

        present(alert, animated: true)
    
    }
    
    @IBAction func hideButtonTapped(_ sender: UIButton) {
        if weightTextField.isSecureTextEntry {
            weightTextField.isSecureTextEntry = false
        } else {
            weightTextField.isSecureTextEntry = true
        }
        
        hideButtonDesign()
    }
    
    func hideButtonDesign() {
        if weightTextField.isSecureTextEntry {
            hideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            hideButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        hideButton.tintColor = .gray
    }
    
    func getBMI(height: Double, weight: Double) -> String{
        let BMI = weight / (height * height)
        
        UserDefaults.standard.set(BMI, forKey: "bmi")
        
        let stringBMI = String(format: "%.1f", BMI)
        
        var result = ""
        
        switch BMI {
        case ..<12: result = "BMI: \(stringBMI)로, 너무 낮습니다\n키와 몸무게를 다시 확인해주세요"
        case 12..<18.5: result = "BMI: \(stringBMI)\n저체중"
        case 18.5..<25: result = "BMI: \(stringBMI)\n정상"
        case 25..<30: result = "BMI: \(stringBMI)\n과체중"
        case 30..<35: result = "BMI: \(stringBMI)\n1급 비만"
        case 35..<40: result = "BMI: \(stringBMI)\n2급 비만"
        case 40..<43: result = "BMI: \(stringBMI)\n3급 비만"
        case 43...: result = "BMI: \(stringBMI)로, 너무 높습니다\n키와 몸무게를 다시 확인해주세요"
        default: result = "오류가 발생하였습니다"
        }
        
        return result
    }
    
    func randomButtonDesign() {
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        randomButton.setTitleColor(UIColor(named: "randomBT"), for: .normal)
    }
    
    func resultButtonDesign() {
        resultButton.backgroundColor = UIColor(named: "resultBT")
        resultButton.layer.cornerRadius = 15
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func resetButtonDesign() {
        resetButton.backgroundColor = UIColor(named: "resetBT")
        resetButton.layer.cornerRadius = 15
        resetButton.setTitle("데이터 전체 삭제", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func textFieldViewDesign(_ view: UIView){
        view.layer.cornerRadius = 18
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.5
    }
    
    func textFieldDesign(_ textField: UITextField){
        textField.keyboardType = .decimalPad
        textField.borderStyle = .none
    }
    
    func topViewDesign() {
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .systemFont(ofSize: 27, weight: .bold)
        
        let nickName = UserDefaults.standard.string(forKey: "name")!
        let BMI = UserDefaults.standard.double(forKey: "bmi")
        
        let stringBMI = String(format: "%.1f", BMI)
        
        if nickName != "" {
            if BMI != 0.0 {
                subTitleLabel.text = "\(nickName)님의\n최근 BMI 지수는\n\(stringBMI)입니다"
            } else {
                subTitleLabel.text = "\(nickName)님의 BMI 지수를 알려드릴게요"
            }
        } else {
            subTitleLabel.text = "당신의 BMI 지수를 \n알려드릴게요."
        }
        
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        imageView.image = UIImage(named: "purpleGirl")
    }
    
    func inputLabelDesign(_ label: UILabel, text: String){
        label.text = text
        label.font = .systemFont(ofSize: 15, weight: .semibold)
    }


}

