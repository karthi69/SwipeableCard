//
//  ViewController.swift
//  CardSwipe
//
//  Created by Karthi Anandhan on 06/11/19.
//  Copyright © 2019 Karthi. All rights reserved.
//

import UIKit

struct CardModel {
    var name : String
    var cardId : String
    var cardHolderName : String
    var bankName : String
    var bankLogo : String
    var bgColor  : String
}

class ViewController: UIViewController {

    @IBOutlet weak var cardsTableview: UITableView!
    
    @IBOutlet weak var addNewButton: UIButton!
    
    var tableData: [CardModel]?
    
    func getData() -> [CardModel] {
        return      [CardModel.init(name: "Visa", cardId: "7328 4344 4589 22GA", cardHolderName: "Rahul sharma",                   bankName: "SBI", bankLogo: "Stage Bank of India", bgColor: "#A569BD"),
                     CardModel.init(name: "Visa", cardId: "8128 9801 0839 Y2H6", cardHolderName: "Rahul sharma", bankName: "Citi", bankLogo: "Citi India Bank", bgColor: "#C0392B"),
                     CardModel.init(name: "Cred", cardId: "2228 4344 3253 45JK", cardHolderName: "Rahul sharma", bankName: "SBI", bankLogo: "Stage Bank of India", bgColor: "#A569BD"),
                     CardModel.init(name: "Visa", cardId: "3928 2451 4839 26LO", cardHolderName: "Rahul sharma", bankName: "KVB", bankLogo: "Karur Visia Bank", bgColor: "#27AE60"),
                     CardModel.init(name: "Debit", cardId: "9428 4344 4839 91BA", cardHolderName: "Rahul sharma", bankName: "BOI", bankLogo: "Bank of Baroda", bgColor: "#D35400")]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTablview()
        addNewButton.layer.cornerRadius = 12.0
        tableData = getData()
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
        cardsTableview.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.initialAnimation()
        }
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 240
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.cardsTableview.dequeueReusableCell(withIdentifier: "CardTableviewCell", for: indexPath) as? CardTableviewCell else { return UITableViewCell() }
        cell.scrollToCenter()
        if let model = tableData?[indexPath.row] {
           cell.configureView(model:model)
           cell.cellCallBacks = self
        }
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollToCenterAllCells(cardId: nil)
    }
    
    func scrollToCenterAllCells(cardId: String?)  {
        guard let data = tableData else {
            return
        }
        for i in 0...data.count - 1{
            if let cell = cardsTableview.cellForRow(at: NSIndexPath(row: i, section: 0) as IndexPath) as?CardTableviewCell  {
                if  cardId != cell.cardModel?.cardId {
                      cell.scrollToCenter()
                }
            }
        }
    }

    func initialAnimation()  {
        if let cell = cardsTableview.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as? CardTableviewCell {
            cell.scrollToRightEdge()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                cell.scrollToCenter()
            }
        }
    }
    
}

extension ViewController : CellCallBacks {
    func startPayment(model: CardModel) {
        showAlert(title: "Start the payment", detail: model.cardId)
    }
    
    func viewDetails(model: CardModel) {
        showAlert(title: "View  details", detail: model.cardId)
    }
    
    func viewOtherDetails(model: CardModel) {
        showAlert(title: "View other details", detail: model.cardId)
    }
    
    func beginSwipeCell(cardId: String) {
         scrollToCenterAllCells(cardId: cardId)
    }
    
    func showAlert(title : String, detail : String)  {
        // create the alert
        let alert = UIAlertController(title: title, message: "Card ID: " + detail, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}


