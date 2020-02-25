//
//  BRSPickerView.swift
//  BRSPickerView
//
//  Created by Bindu R S on 24/02/20.
//  Copyright © 2020 Bindu R S. All rights reserved.
//

import UIKit

fileprivate var pickerFont = UIFont()
fileprivate  var dataArray = [String]()
fileprivate  var titleString : String = ""
fileprivate var titleFont = UIFont()

class PickerView: UIView {
    
    var didDonePressed: ((String) -> Void)?
    
    var stackView = UIStackView()
    var cancelButton = UIButton(type: .custom)
    var titleLabel = UILabel()
    var doneButton = UIButton(type: .custom)
    var pickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 50)
        pickerView.frame = CGRect(x: 0, y: stackView.frame.size.height + stackView.frame.origin.y, width: bounds.size.width, height: bounds.size.height - (stackView.frame.size.height + stackView.frame.origin.y))
        
    }
    private func commonInit() {
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        clipsToBounds = false
        
        stackView.spacing = 10
        stackView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 50)
        stackView.axis = .horizontal
        addSubview(stackView)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.heightAnchor.constraint(equalToConstant: stackView.frame.size.height).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        cancelButton.addTarget(self, action: #selector(cancelButtonPresssed(_:)), for: .touchUpInside)
        cancelButton.isUserInteractionEnabled = true
        stackView.addArrangedSubview(cancelButton)
        
        
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.text = ""
        titleLabel.heightAnchor.constraint(equalToConstant: stackView.frame.size.height).isActive = true
        stackView.addArrangedSubview(titleLabel)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.heightAnchor.constraint(equalToConstant: stackView.frame.size.height).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        doneButton.addTarget(self, action: #selector(donButtonPressed(_:)), for: .touchUpInside)
        doneButton.isUserInteractionEnabled = true
        stackView.addArrangedSubview(doneButton)
        
        pickerView.frame = CGRect(x: 0, y: stackView.frame.size.height + stackView.frame.origin.y, width: bounds.size.width, height: bounds.size.height - (stackView.frame.size.height + stackView.frame.origin.y))
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)
        
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                cancelButton.setTitleColor(UIColor.label, for: .normal)
                doneButton.setTitleColor(UIColor.label, for: .normal)
                titleLabel.textColor = UIColor.label
            } else {
                cancelButton.setTitleColor(UIColor.black, for: .normal)
                doneButton.setTitleColor(UIColor.black, for: .normal)
                titleLabel.textColor = UIColor.black
            }
        } else {
            cancelButton.setTitleColor(UIColor.black, for: .normal)
            doneButton.setTitleColor(UIColor.black, for: .normal)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBInspectable var pickerTitle: String {
        get {
            return titleString
        }
        set {
            titleString = newValue
            titleLabel.text = titleString
        }
    }
    @IBInspectable var pickerTitleFont: UIFont {
        get {
            return titleFont
        }
        set {
            titleFont = newValue
        }
    }
    
    private func setTitleFont()  {
        titleLabel.font = titleFont
    }
    
    @IBInspectable var pickerViewFont: UIFont {
        get {
            return pickerFont
        }
        set {
            pickerFont = newValue
            setPickerFont()
        }
    }
    
    @IBInspectable var pickerViewDataArray: [String] {
        get {
            return dataArray
        }
        set {
            dataArray = newValue
        }
    }
    
    private func setPickerFont()  {
        cancelButton.titleLabel?.font = pickerViewFont
        
        doneButton.titleLabel?.font =  pickerViewFont
    }
    
    @objc func donButtonPressed(_ sender: UIButton) {
        
        let selectedValue = dataArray[pickerView.selectedRow(inComponent: 0)]
        didDonePressed!(selectedValue)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.heightAnchor.constraint(equalToConstant: 250).isActive = false
            self.layoutIfNeeded()
        }, completion: { (isCompleted) in
            self.isHidden = true
        })
    }
    
    @objc func cancelButtonPresssed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.heightAnchor.constraint(equalToConstant: 250).isActive = false
            self.layoutIfNeeded()
        }, completion: { (isCompleted) in
            self.isHidden = true
        })
    }
    
}

extension PickerView : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewDataArray.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerContentView = UIView()
        
        let title = UILabel(frame: CGRect(x: 5, y: 0, width: pickerView.frame.size.width - 10, height: 30))
        title.text = pickerViewDataArray[row]
        title.font = pickerViewFont
        title.textAlignment = .center
        pickerContentView.addSubview(title)
        
        return pickerContentView
    }
}
