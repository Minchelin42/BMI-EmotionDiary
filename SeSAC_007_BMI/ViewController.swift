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
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var heightView: UIView!
    @IBOutlet var weightView: UIView!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    
    @IBOutlet var hideButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    //브랜치바꿈
    /* 체크리스트
     1. 키/몸무게에 숫자가 아닌 다른 것을 입력했을 경우
     2. 공백이나 빈칸 처리
     => guard let을 통해서 해결
     3. 키/몸무게 범위가 이상한 경우
     => case문을 통해서 조정
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewDesign()
        
        inputLabelDesign(heightLabel, text: "키가 어떻게 되시나요?")
        inputLabelDesign(weightLabel, text: "몸무게는 어떻게 되시나요?")
        
        textFieldDesign(heightTextField)
        textFieldDesign(weightTextField)
        textFieldViewDesign(heightView)
        textFieldViewDesign(weightView)
        
        hideButtonDesign()
        randomButtonDesign()
        resultButtonDesign()
  
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

        let alert = UIAlertController(title: "[ 결과 ]", message: "\(result)", preferredStyle: .alert)
        
        let clearButton = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(clearButton)
        
        present(alert, animated: true)
        
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        
        let weight = String(format: "%.1f", Double.random(in: 40...120))
        let height = String(format: "%.1f", Double.random(in: 150...200))

        //print(height, weight)
        
        heightTextField.text = height
        weightTextField.text = weight
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
        resultButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
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
        subTitleLabel.text = "당신의 BMI 지수를 \n알려드릴게요."
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        imageView.image = UIImage(named: "purpleGirl")
    }
    
    func inputLabelDesign(_ label: UILabel, text: String){
        label.text = text
        label.font = .systemFont(ofSize: 15, weight: .semibold)
    }


}

