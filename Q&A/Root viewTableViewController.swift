//
//  Root viewTableViewController.swift
//  Q&A
//
//  Created by 柴田　樹希 on 2017/07/23.
//  Copyright © 2017年 柴田　樹希. All rights reserved.
//

import UIKit


class Root_viewTableViewController: UITableViewController {

    //@IBOutlet weak var table: UITableView! //送信したデータを表示するTableView
    var answerArray:[String] = []
    var selectedcell: String!
    var contentArray: [String] = []
    var selectedcellnumber: Int!
    let saveData :UserDefaults = UserDefaults.standard
  /*  @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var logoBackView: UIImageView!
 */
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RootviewTableViewCell" ,bundle: nil), forCellReuseIdentifier: "cell")
        
        tableView.delegate = self //デリゲートをセット
        tableView.dataSource = self //デリゲートをセット
//        self.table.estimatedRowHeight = 10
//        self.table.rowHeight = UITableViewAutomaticDimension

    }
    func nothing(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if answerArray != nil{
            let RootViewTablecell:UITableViewCell = tableView.cellForRow(at:indexPath)!
            RootViewTablecell.accessoryType = UITableViewCellAccessoryType.checkmark
            
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if saveData.object(forKey: "content") != nil {
            contentArray = saveData.object(forKey: "content") as! [String]
        }
        
        tableView.reloadData()
        
        //Cellの高さを調節
        //table.estimatedRowHeight = 56
        //table.rowHeight = UITableViewAutomaticDimension
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func delete(deleteIndexPath indexPath: IndexPath) {
    
        contentArray.remove(at: indexPath.row)
    }
    func getDate(_ number: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: number)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
//    //ViewControllerへの遷移
//    func transition() {
//        self.performSegue(withIdentifier: "toView", sender: self)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Cell が選択された場合
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedcell  = contentArray[indexPath.row]
        selectedcellnumber = indexPath.row
    let RootViewTablecell:UITableViewCell = tableView.cellForRow(at: indexPath)!
     RootViewTablecell.accessoryType = UITableViewCellAccessoryType.checkmark
        
        if selectedcell != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "openViewController",sender: nil)
        }
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "openViewController") {
            let subVC: openViewController = (segue.destination as? openViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            subVC.question = selectedcell
            subVC.selectedAnswerNumber = selectedcellnumber
        }
    }
    //cellの数
    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int
        ) -> Int {
        return contentArray.count
    }
       override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell" ,for:indexPath) as! RootviewTableViewCell
        
        cell.contentLabel.text = String(contentArray[indexPath.row])
    
        return cell
    }
 
    //アニメーションの実装
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let slideInTransform = CATransform3DTranslate(CATransform3DIdentity, -510, 15, 0)
        
        cell.layer.transform = slideInTransform
        
        UIView.animate(withDuration: 0.3) { () -> Void in
            
            cell.layer.transform = CATransform3DIdentity
            
        }
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contentArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData.set(contentArray, forKey: "content")
            //contentArray = saveData.object(forKey: "content") as! [String]
        }
    }

  /*  override func viewDidAppear(_ animated: Bool) {
        //少し縮小するアニメーション
        UIView.animate(withDuration: 1.3,
                       delay: 1.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: { () in
                        self.logoImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { (Bool) in
            
            
            //拡大させて、消えるアニメーション
            UIView.animate(withDuration: 1.2,
                           delay: 0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { () in
                            self.logoImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                            self.logoImageView.alpha = 0
                            self.logoBackView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                            
                            self.logoBackView.alpha = 0
                            
            }, completion: { (Bool) in
                self.logoImageView.removeFromSuperview()
            })
            
        })
    */

    }

    


