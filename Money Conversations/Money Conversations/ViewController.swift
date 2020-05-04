//
//  ViewController.swift
//  Money Conversations
//
//  Created by Obinna Ezekwesili on 5/4/20.
//  Copyright © 2020 Obinna Ezekwesili. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0;
    
    //Connect Elements
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
    //Creating My picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return myCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        activeCurrency = myValues[row]
    }
    //Button
    @IBAction func action(_ sender: Any)
    {
        if (input.text != "")
        {
            output.text = String(Double(input.text!)! * activeCurrency)

        }
    }
    
    override func viewDidLoad()
    {
        //Receiving Data
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            let url = URL(string: "http://data.fixer.io/api/latest?access_key=528341f85dad3fd05e07266ed292b46d")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                
                if error != nil
                {
                 print ("ERROR")
            }
            else
            {
                if let content = data
                {
                   do
                {
                    let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                        for (key, value) in rates
                        {
                            self.myCurrency.append((key as? String)!)
                            self.myValues.append((value as? Double)!)
                            }
                    }
                }
                catch
                {
            
                }
            }
        }
            self.pickerView.reloadAllComponents()
    }
        task.resume()
    }


}


