//
//  DetailController.swift
//  InterestCalculator
//
//  Created by Appa Rao Mulpuri on 13/10/17.
//  Copyright © 2017 Appa Rao Mulpuri. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var lendingDate: UITextField!
    @IBOutlet weak var interestRate: UITextField!
    
    
    @IBOutlet weak var totalAmt: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var principleLabel: UILabel!
    @IBOutlet weak var interestPerMonthLabel: UILabel!
    
    @IBOutlet weak var computeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.amount.text = ""
        self.lendingDate.text = ""
        self.interestRate.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clear(_ sender: UIButton) {
        self.amount.resignFirstResponder()
        self.lendingDate.resignFirstResponder()
        self.interestRate.resignFirstResponder()
       
        self.amount.text = ""
        self.lendingDate.text = ""
        self.interestRate.text = ""
        self.duration.text = ""
        self.interestLabel.text = ""
        self.principleLabel.text = ""
        self.interestPerMonthLabel.text = ""
        self.totalAmt.text = ""
    }

    @IBAction func computeInterest(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let fromDate = dateFormatter.date(from: (self.lendingDate.text)!)

        let noOfDays =   (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: fromDate!, to: Date(), options: NSCalendar.Options.searchBackwards).day
        

        let years = noOfDays!/365
        let months = (noOfDays!%365)/30
        let days = (noOfDays!%365)%30
        
        if years>0
        {
            self.duration.text = "\(years) years, \(months) months, \(days) days"
        }
        else
        {
            self.duration.text = "\(months) months \(days) days"
        }

        
        let totalAmt = Float(self.amount.text!)
        var totalInterest = 0

        if (years > 0)
        {
            let temp: Float = totalAmt!*((Float(self.interestRate.text!))!/12)
            totalInterest = (Int(temp) * (years*12))/100
        }
        
        //100*24*(13/12)/100
        if months > 0
        {
            let temp: Float = totalAmt!*((Float(self.interestRate.text!))!/12)
            totalInterest += (Int(temp) * months)/100
        }
        
        if days > 0 {
            let dayInterest: Float = totalAmt!*(((Float(self.interestRate.text!))!/12)/30)
            totalInterest += (Int(dayInterest) * days)/100
        }
        
        let temp: Float = (totalAmt)!*((Float(self.interestRate.text!))!/12)
        let intPerMonth = (Int(temp))/100

        let totalAmoutWithInterest = Int(totalAmt!)+totalInterest

        if let totalAmt = totalAmt {
            self.interestPerMonthLabel.text = "\(intPerMonth)"
            self.interestLabel.text = "\(totalInterest)"
            self.principleLabel.text = "\(Int(totalAmt))"
            
            self.totalAmt.text = "\(totalAmoutWithInterest)"
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.computeInterest(self.computeButton)
    }

}
