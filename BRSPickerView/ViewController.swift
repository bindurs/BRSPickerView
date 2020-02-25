//
//  ViewController.swift
//  BRSPickerView
//
//  Created by Bindu R S on 24/02/20.
//  Copyright © 2020 Bindu R S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectedNumberButton: UIButton!
    @IBOutlet weak var pickerView: PickerView!
    var heightOfPickerView : CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.pickerTitle = "Select numbers"
        pickerView.pickerTitleFont = UIFont.systemFont(ofSize: 22)
        pickerView.pickerViewFont = UIFont.boldSystemFont(ofSize: 14)
        pickerView.pickerViewDataArray = ["1", "2", "3", "4", "5"]
        pickerView.didDonePressed = dismissedMethodInRating(selectedString:)
        pickerView.heightAnchor.constraint(equalToConstant: heightOfPickerView).isActive = false
        pickerView.isHidden = true
        pickerView.layer.shadowColor = UIColor.gray.cgColor
        pickerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        pickerView.layer.shadowRadius = 5.0
        pickerView.layer.shadowOpacity = 0.5
        pickerView.clipsToBounds = false
        
    }
    @IBAction func selectNumberButtonPressed(_ sender: UIButton) {
        
        pickerView.isHidden = false
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.pickerView.heightAnchor.constraint(equalToConstant: self.heightOfPickerView).isActive = true
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.frame = CGRect(x: 0, y: view.bounds.size.height - heightOfPickerView, width: view.bounds.size.width, height: heightOfPickerView)
    }
    
    func dismissedMethodInRating(selectedString: String) {
        selectedNumberButton.setTitle("Selected Number \(selectedString)", for: .normal)
    }
    
}

