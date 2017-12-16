//
//  openViewController.swift
//  Q&A
//
//  Created by 柴田　樹希 on 2017/10/21.
//  Copyright © 2017年 柴田　樹希. All rights reserved.
//

import UIKit

class openViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var returnTextField: UITextField!
    @IBOutlet var returnTableView: UITableView!
    var answerArray: [[String]] = [[]]
    var question: String!
    var selectedAnswerNumber: Int!
    @IBOutlet var cellLabel: UILabel!
    let saveData :UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnTableView.register(UINib(nibName: "AnswerTableViewCell" ,bundle: nil), forCellReuseIdentifier: "cells")
        cellLabel.text = String(question)
        
        //returnTextField.delegate = self
        returnTableView.delegate = self
        returnTableView.dataSource = self //デリゲートをセット
        returnTextField.placeholder = "Answer"
        // Do any additional setup after loading the view.
           }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //selectedSnapがnilならその後の処理をしない
        if saveData.object(forKey: "answer") != nil {
            answerArray = saveData.object(forKey: "answer") as! [[String]]
            
            
        }
        //answerArray.append(["test"])
        print(answerArray.count)
    }
    //投稿ボタン
    @IBAction func answer() {
        if answerArray.isEmpty {
            answerArray.append([returnTextField.text!])
        } else {
            answerArray[selectedAnswerNumber].append(returnTextField.text!)
        }
        print(answerArray)
        saveData.set(answerArray, forKey: "answer")
        returnTableView.reloadData()
    }
    
    //cellの数
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int
        ) -> Int {
        return answerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cells = returnTableView.dequeueReusableCell(withIdentifier: "cells" ,for:indexPath) as! AnswerTableViewCell
        
       if answerArray[selectedAnswerNumber].isEmpty {
            cells.answerLabel.text = String("")
        } else  {
            cells.answerLabel.text = String(answerArray[selectedAnswerNumber][indexPath.row])
        }
        
        return cells
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            answerArray.remove(at: indexPath.row)
            returnTableView.deleteRows(at: [indexPath], with: .fade)
            saveData.set(answerArray, forKey: "answer")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 改行でキーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
