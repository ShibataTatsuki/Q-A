//
//  ViewController.swift
//  Q&A
//
//  Created by 柴田　樹希 on 2017/07/22.
//  Copyright © 2017年 柴田　樹希. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textfield: UITextField! //投稿のためのTextField
    let saveData :UserDefaults = UserDefaults.standard
    var isCreate = true //データの作成か更新かを判定、trueなら作成、falseなら更新
    var contentArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
         textfield.delegate = self
         textfield.placeholder = "質問を記入"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //selectedSnapがnilならその後の処理をしない
        if saveData.object(forKey: "content") != nil {
            contentArray = saveData.object(forKey: "content") as! [String]
        }
        

        //isCreateをfalseにし、更新するためであることを明示
        isCreate = false
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func add(){
        contentArray.append(textfield.text!)
        print(contentArray)
        saveData.set(contentArray, forKey: "content")
        self.navigationController?.popViewController(animated: true)
    }

    // 改行でキーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}


//extension ViewController: UITextFieldDelegate {
//    
//    //Returnキーを押すと、キーボードを隠す
//    func textfieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}

