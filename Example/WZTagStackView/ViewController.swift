//
//  ViewController.swift
//  WZTagStackView
//
//  Created by ppqx on 04/24/2020.
//  Copyright (c) 2020 ppqx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var dataArray: [[TestLabel]] = [[TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel()],[TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel(),TestLabel()]]
    
    private lazy var tableView: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = UITableViewAutomaticDimension
        $0.estimatedRowHeight = 10
        $0.tableFooterView = UIView()
        $0.tableHeaderView = UIView()
        $0.sectionFooterHeight = 0
        $0.sectionHeaderHeight = 0
        $0.register(TestTableViewCell.self, forCellReuseIdentifier: "TestTableViewCell")
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TestTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell") as! TestTableViewCell
        let arr = dataArray[indexPath.row]
        cell.upload(tags: arr)
        return cell
    }
    
}
