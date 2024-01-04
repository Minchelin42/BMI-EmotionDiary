//
//  ViewController.swift
//  SeSAC_006_EmotionDiary
//
//  Created by 민지은 on 2024/01/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var emotionButton: [UIButton]!
    @IBOutlet var emotionLabel: [UILabel]!
    @IBOutlet var backgroundImage: UIImageView!
    
    let labelTitle: [String] = ["행복해", "사랑해", "좋아해", "당황해",
    "속상해", "우울해", "한심해", "심심해", "씁쓸해"]
    
    var labelCount: [Int] = [UserDefaults.standard.integer(forKey: "count1"),
                             UserDefaults.standard.integer(forKey: "count2"),
                             UserDefaults.standard.integer(forKey: "count3"),
                             UserDefaults.standard.integer(forKey: "count4"),
                             UserDefaults.standard.integer(forKey: "count5"),
                             UserDefaults.standard.integer(forKey: "count6"),
                             UserDefaults.standard.integer(forKey: "count7"),
                             UserDefaults.standard.integer(forKey: "count8"),
                             UserDefaults.standard.integer(forKey: "count9")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonImage(emotionButton)
        setEmotionLabel(emotionLabel)
        setNavigationItem()
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleToFill
    }
    
    func setNavigationItem() {
        navigationItem.title = "감정 다이어리"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @IBAction func emotionTapped(_ sender: UIButton) {
        
        let index = sender.tag
        
//        // 누를 때마다 랜덤한 숫자가 나오도록 하기
//        let randomNum = Int.random(in: 0...20)
//        labelCount[index] = randomNum
//        emotionLabel[index].text = "\(labelTitle[index]) \(labelCount[index])"
        
        // 누를 때마다 count + 1
        let count = UserDefaults.standard.integer(forKey: "count\(index + 1)")
        let newCount = count + 1
        UserDefaults.standard.set(newCount, forKey: "count\(index + 1)")
        emotionLabel[index].text = "\(labelTitle[index]) \(UserDefaults.standard.integer(forKey: "count\(index + 1)"))"
    }
    
    @objc func leftBarButtonClicked() {
        print("leftBarButtonClicked")
    }
    
    @objc func rightBarButtonClicked() {
        print("모든 count를 0으로 재설정")
        
        for index in 0...labelCount.count - 1 {
            UserDefaults.standard.set(0, forKey: "count\(index + 1)")
            emotionLabel[index].text = "\(labelTitle[index]) \(UserDefaults.standard.integer(forKey: "count\(index + 1)"))"
        }
    }
    
    func setButtonImage(_ buttonList: [UIButton]) {
        for index in 0...buttonList.count - 1 {
            buttonList[index].setImage(UIImage(named: "slime\(index+1)"), for: .normal)
        }
    }
    
    func setEmotionLabel(_ labelList: [UILabel]){
        for index in 0...labelList.count - 1 {
            labelList[index].text = "\(labelTitle[index]) \(labelCount[index])"
            labelList[index].textAlignment = .center
            labelList[index].font = .boldSystemFont(ofSize: 14)
        }
    }
    


}

