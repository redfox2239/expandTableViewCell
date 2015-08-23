
//
//  MainViewController.swift
//  expandTableViewCell
//
//  Created by HARADA REO on 2015/08/21.
//  Copyright (c) 2015年 reo harada. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // tableView
    @IBOutlet weak var mainTableView: UITableView!
    
    // タイトルデータの配列
    var dataTitleArray: Array<String> = []
    // 詳細データの配列
    var dataDetailArray: Array<String> = []
    // ボタンが押されているかどうかのフラグ
    var dataFlag: Array<Bool> = []
    // 押したボタンをどれか判別するためのクラス変数
    var tapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableViewのdelegate
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self

        // dataSourceを設定
        for(var i=0;i<100;i++){
            self.dataTitleArray.append("タイトル\(i)")
            self.dataDetailArray.append("詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細詳細\(i)")
            self.dataFlag.append(false)
        }
        
        // ExpandTableViewCellをtableViewにregist
        let nib = UINib(nibName: "ExpandTableViewCell", bundle: nil)
        self.mainTableView.registerNib(nib, forCellReuseIdentifier: "ExpandTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTitleArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell: ExpandTableViewCell = self.mainTableView.dequeueReusableCellWithIdentifier("ExpandTableViewCell") as! ExpandTableViewCell

        // cell内のタイトルラベルと詳細ラベルの横幅を設定
        // ぎりぎりの幅だと、最後の文字が切れてしまうため、-5している
        cell.titleLabelWidth.constant = self.view.frame.size.width - 5
        cell.detailLabelWidth.constant = self.view.frame.size.width - 5

        // cellの高さを計算
        var height: CGFloat = 0;
        if(self.dataFlag[indexPath.row]){
            // フラグがtrueのものは詳細のLabelの高さを考慮
            height = cell.estmateHeight(self.dataTitleArray[indexPath.row], detail:self.dataDetailArray[indexPath.row])
        }else{
            // フラグがfalseのものは詳細のLabelの高さを0にする
            height = cell.estmateHeight(self.dataTitleArray[indexPath.row], detail:"")
        }
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.mainTableView.dequeueReusableCellWithIdentifier("ExpandTableViewCell", forIndexPath: indexPath) as! ExpandTableViewCell
        
        // cell内のタイトルラベルと詳細ラベルの横幅を設定
        // ぎりぎりの幅だと、最後の文字が切れてしまうため、-5している
        cell.titleLabelWidth.constant = self.view.frame.size.width - 5
        cell.detailLabelWidth.constant = self.view.frame.size.width - 5
        
        // cellにデータをセット
        cell.cellTitleTextLabel.text = self.dataTitleArray[indexPath.row]
        cell.expandButton.tag = indexPath.row
        cell.expandButton.addTarget(self, action: "expandCell:", forControlEvents: UIControlEvents.TouchDown)
        if(self.dataFlag[indexPath.row]){
            // フラグがtrueのものは詳細を入力
            cell.cellDetailTextLabel!.text = self.dataDetailArray[indexPath.row]
        }else{
            // フラグがfalseのものは詳細に空を入力
            cell.cellDetailTextLabel!.text = ""
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(self.tapButton == nil){
            return
        }
        // animateWithDurationを利用して、ボタンを押された時は詳細のLabelをフェードで表示する
        if(indexPath.row == self.tapButton.tag){
            let cell: ExpandTableViewCell = cell as! ExpandTableViewCell
            cell.cellDetailTextLabel.alpha = 0
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                cell.cellDetailTextLabel.alpha = 1.0
            })
        }
    }

    // expandのボタンが押された時の処理
    func expandCell(sender:UIButton){
        let numKey = sender.tag
        // フラグを切り替える
        self.dataFlag[numKey] = !self.dataFlag[numKey]
        // どのボタンを押したかを登録しておく
        self.tapButton = sender
        // tableViewをreloadする
        self.mainTableView.reloadData()
    }
}
