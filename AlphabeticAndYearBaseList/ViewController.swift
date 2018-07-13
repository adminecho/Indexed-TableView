//
//  ViewController.swift
//  AlphabeticAndYearBaseList
//
//  Created by Echo Innovate IT on 05/07/18.
//  Copyright © 2018 Echo Innovate IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variable Declaration
    
    /* Label */
    @IBOutlet weak var lblNoData: UILabel!
    
    /* TextField */
    @IBOutlet weak var txtSearch: UITextField!
    
    /* TableView */
    @IBOutlet weak var tblView: UITableView!
    
    /* Local Variable */
    var carsDictionary = [String: [String]]()
    var carSectionTitles = [String]()
    var objCarList = [String]()
    var objList = [String]()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added Dummy Data
        
        objCarList = ["Audi", "Aston Martin","BMW", "Bugatti", "Bentley","Chevrolet", "Cadillac","Dodge","Ferrari", "Ford","Honda","Jaguar","Lamborghini","GMC","Opel","Mercedes", "Mazda","Nissan","Porsche","Rolls Royce","Toyota","Volkswagen","Yulon","Zenvo","ZAZ","Suzuki"]
        
        objList = objCarList
        
        // Dynamic Height
        tblView.estimatedRowHeight = 40;
        tblView.rowHeight = UITableViewAutomaticDimension;
        
        tblView.sectionIndexColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        self.displayData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - TableView Delegate

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return carSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return carSectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let carKey = carSectionTitles[section]
        if let carValues = carsDictionary[carKey] {
            return carValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableCell! = tableView.dequeueReusableCell(withIdentifier: "TableCell") as? TableCell
        
        // Configure the cell...
        let carKey = carSectionTitles[indexPath.section]
        if let carValues = carsDictionary[carKey] {
            cell.lblTitle?.text = carValues[indexPath.row]
        }
 
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return carSectionTitles
    }

}

// MARK: - TextField Delegate

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        /* Check input max lenth */
        let maxLength = (textField.text?.length)! + string.length - range.length;
        return (maxLength > Int(textField.minimumFontSize)) ? false : true;
    }
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        
        if txtSearch.text == nil || txtSearch.text?.length == 0 {
            objList = objCarList
            
        } else {
            
            objList = objCarList.filter {
                return $0.uppercased().contains(txtSearch.text!.uppercased())
            }
        }
        
        lblNoData.isHidden = objList.count > 0
        
        self.displayData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: Private Helper Method

extension ViewController {
    
    func displayData() {
        
        carsDictionary.removeAll()
        
        for car in objList {
            let carKey = String(car.prefix(1))
            if var carValues = carsDictionary[carKey] {
                carValues.append(car)
                carsDictionary[carKey] = carValues
            } else {
                carsDictionary[carKey] = [car]
            }
        }
        
        carSectionTitles = [String](carsDictionary.keys)
        carSectionTitles = carSectionTitles.sorted(by: { $0 < $1 })
        
        tblView.reloadData()
    }
    
}
