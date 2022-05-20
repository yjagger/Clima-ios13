//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    let weatherManager = WeatherManager();
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print("searchPressed invoked. searchTextField value = \(searchTextField.text!)");
        searchTextField.endEditing(true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn invoked. searchTextField value = \(searchTextField.text!)");
        searchTextField.endEditing(true);
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else{
            textField.placeholder = "Type something here";
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing invoked. searchTextField value = \(searchTextField.text!)");
        
        if let city = searchTextField.text {
            cityLabel.text = searchTextField.text;
            weatherManager.fetchWeather(city);
        }
        
        searchTextField.text = "";

        
    }


}

