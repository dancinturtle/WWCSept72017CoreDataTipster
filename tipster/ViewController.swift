//
//  ViewController.swift
//  tipster
//
//  Created by Anna Propas on 7/6/17.
//  Copyright © 2017 Anna Propas. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var billString = "0"
    var billNum = Double(0.00)
    var model: CoreDataManager!
    
    // add outlets for all targets
    
    @IBOutlet var checkmarks: [UIButton]!
    
    @IBAction func checkMarkWasPressed(_ sender: UIButton) {
        print("Check mark was pressed!")
        for checkmark in checkmarks {
            checkmark.setImage(#imageLiteral(resourceName: "checkmarkbw"), for: .normal)
        }
        sender.setImage(#imageLiteral(resourceName: "checkmarkgreen"), for: .normal)
        var tipPercent: Int = 0
        var total: Double = 0
        switch sender.tag {
        case 1:
            tipPercent = 10
            total = Double(tenPercentTotal.text!)!
        case 2:
            tipPercent = 15
            total = Double(fifteenPercentTotal.text!)!
        case 3:
            tipPercent = 20
            total = Double(twentyPercentTotal.text!)!
        default:
            print("Something went horribly wrong")
        }
        saveAlert(message:"You just spent $\(total).", title: "Confirm save", total: total, tipPercent: tipPercent)
    }
    
    func saveAlert(message: String, title: String, total: Double, tipPercent: Int){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(action) in
            print("Saving")
            if self.model.saveEvent(total: total, tipPercent: tipPercent){
                print("Successfully saved!")
            }
            else {
                print("Could not save")
            }
            alert.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
            print("Canceling save")
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    @IBOutlet weak var billTotal: UILabel!
    @IBOutlet weak var tenPercentTip: UILabel!
    @IBOutlet weak var tenPercentTotal: UILabel!
    @IBOutlet weak var fifteenPercentTip: UILabel!
    @IBOutlet weak var fifteenPercentTotal: UILabel!
    @IBOutlet weak var twentyPercentTip: UILabel!
    @IBOutlet weak var twentyPercentTotal: UILabel!
    @IBOutlet weak var decimalButton: UIButton!
    
    @IBAction func calculatorButtonWasPressed(_ sender: UIButton) {
        if (billString == "0") {
            billString = String(sender.tag)
        } else {
            billString += String(sender.tag)
        }
        updateDisplay()
    }
    
    // add actions for clear and decimal
    @IBAction func clearButtonWasPressed(_ sender: UIButton) {
        billString = "0"
        billNum = 0.00
        decimalButton.isEnabled = true
        updateDisplay()
    }
    @IBAction func decimalButtonWasPressed(_ sender: UIButton) {
        sender.isEnabled = false
        billString += "."
        updateDisplay()
    }
    
    // add function to handle updating the view
    
    func updateDisplay() {
        billNum = Double(billString)!
        
        billTotal.text = billString
        
        tenPercentTip.text = String(billNum * 0.1)
        tenPercentTotal.text = String(billNum * 1.1)
        fifteenPercentTip.text = String(billNum * 0.15)
        fifteenPercentTotal.text = String(billNum * 1.15)
        twentyPercentTip.text = String(billNum * 0.2)
        twentyPercentTotal.text = String(billNum * 1.2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = CoreDataManager()
        for checkmark in checkmarks {
            checkmark.imageView?.contentMode = .scaleAspectFit
        }
        if let expenses = model.fetchEvents() {
            for expense in expenses {
                print("We spent $\(expense.total) on \(String(describing: expense.date!)) and tipped \(expense.tipPercent)%.")
            }
        }
        else {
            print("Nothing in the database")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

