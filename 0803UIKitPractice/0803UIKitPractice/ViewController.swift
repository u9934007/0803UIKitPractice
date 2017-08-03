//
//  ViewController.swift
//  0803UIKitPractice
//
//  Created by 楊采庭 on 2017/8/3.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView!
    var searchController: UISearchController!
    var websites = ["Google", "FaceBook", "Slack", "Github"]
    var searchResult: [String] = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var passURL: String?

    let fullScreenSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        // 導覽列標題
        self.title = "書籤"
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor = UIColor.skyBlue
        // 導覽列按鈕字體顏色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 加入導覽列左邊按鈕
        let leftButton = UIBarButtonItem(
            image: UIImage(named:"0726-3"),
            style:.plain ,
            target:self ,
            action: #selector(sayHi))

        self.navigationItem.leftBarButtonItem = leftButton

        //建一個TableView
        self.tableView = UITableView(frame: CGRect(
            x: 0, y: 0,
            width: fullScreenSize.width,
            height: fullScreenSize.height - 20),
            style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)

        // 建立 UISearchController 並設置搜尋控制器為 nil
        self.searchController = UISearchController(searchResultsController: nil)

        // 將更新搜尋結果的對象設為 self
        self.searchController.searchResultsUpdater = self

        // 搜尋時是否隱藏 NavigationBar
        self.searchController.hidesNavigationBarDuringPresentation = false

        // 搜尋時是否使用燈箱效果 (會將畫面變暗以集中搜尋焦點)
        self.searchController.dimsBackgroundDuringPresentation = false

        // 搜尋框的樣式
        self.searchController.searchBar.searchBarStyle = .prominent

        // 設置搜尋框的尺寸為自適應
        // 因為會擺在 tableView 的 header
        // 所以尺寸會與 tableView 的 header 一樣
        self.searchController.searchBar.sizeToFit()

        // 將搜尋框擺在 tableView 的 header
        self.tableView.tableHeaderView = self.searchController.searchBar

    }

    func sayHi() {

        print("Hi")

    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //決定TableView Cell數量
        if self.searchController.isActive {
            return self.searchResult.count
        } else {
            return self.websites.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

            if self.searchController.isActive {

                cell.selectionStyle = .none
                cell.textLabel?.text = self.searchResult[indexPath.row]
                return cell

            } else {

                cell.selectionStyle = .none
                cell.textLabel?.text =
                    self.websites[indexPath.row]
                return cell

        }

    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var selectedResult = ""

        if self.searchController.isActive {

            selectedResult = searchResult[indexPath.row]

        } else {

            selectedResult = websites[indexPath.row]
        }

        switch selectedResult {

        case "Google":
            passURL = "https://www.google.com.tw/"

        case "FaceBook":
            passURL = "https://www.facebook.com/"

        case "Slack":
            passURL = "https://asicalumni.slack.com/"

        default:
            passURL = "https://github.com"

        }

        let nextiewController = WKWebViewController()
        nextiewController.websiteURL = passURL
        //轉場前如果如果不把SearchController啟動狀態改成false他會跟著出現在下一頁
        self.searchController.isActive = false
        self.navigationController?.pushViewController(nextiewController, animated: true)

    }

}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        // 取得搜尋文字
        guard let searchText = searchController.searchBar.text else {
                return
        }

        // 使用陣列的 filter() 方法篩選資料
        self.searchResult = self.websites.filter({ (fruit) -> Bool in
                // 將文字轉成 NSString 型別
                let fruitText: NSString = fruit as NSString

                // 比對這筆資訊有沒有包含要搜尋的文字
                return (fruitText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location)
                    != NSNotFound
        })
    }
}
