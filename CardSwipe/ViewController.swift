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
    
    @IBOutlet weak var addNewButton: UIButton!
    
    var tableData: [String] = ["Christ Redeemer", "Great Wall of China", "Machu Picchu","Petra","Pyramid at Chichén Itzá","Roman Colosseum","Taj Mahal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTablview()
        addNewButton.layer.cornerRadius = 12.0
    }
    
    func setUpTablview()  {
        let identifier = "CardTableviewCell"
        if  Bundle.main.path(forResource: identifier  , ofType: "nib") != nil {
             let nib =  UINib(nibName: identifier , bundle: nil)
            self.cardsTableview.register(nib, forCellReuseIdentifier: identifier)
        }
        self.cardsTableview.delegate = self
        self.cardsTableview.dataSource = self
        self.cardsTableview.allowsSelection = false
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 240
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.cardsTableview.dequeueReusableCell(withIdentifier: "CardTableviewCell", for: indexPath) as? CardTableviewCell else { return UITableViewCell() }
        cell.scrollToCenter()
        return cell
    }
    
}


