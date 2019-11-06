//
//  ViewController.swift
//  CardSwipe
//
//  Created by Karthi Anandhan on 06/11/19.
//  Copyright © 2019 Karthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardsTableview: UITableView!
    
      var tableData: [String] = ["Christ Redeemer", "Great Wall of China", "Machu Picchu","Petra","Pyramid at Chichén Itzá","Roman Colosseum","Taj Mahal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTablview()
    }
    
    func setUpTablview()  {
        self.cardsTableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.cardsTableview.delegate = self
        self.cardsTableview.dataSource = self
        self.cardsTableview.allowsSelection = false
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.cardsTableview.dequeueReusableCell(withIdentifier: "cell")!

        cell.textLabel?.text = self.tableData[indexPath.row]

        return cell
    }
}


