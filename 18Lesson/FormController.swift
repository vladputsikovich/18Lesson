//
//  FormController.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 18.12.21.
//

import UIKit

class FormController: UIViewController {
    
    var nameLabel = UILabel()
    var femaleLabel = UILabel()
    var dateLabel = UILabel()
    var mailLabel = UILabel()
    var adressLabel = UILabel()
    var numberLabel = UILabel()
    
    var name = ""
    var female = ""
    var date = ""
    var mail = ""
    var adress = ""
    var number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createLabels()
    }
    
    func createLabels() {
        nameLabel = UILabel(frame: CGRect(x: 20, y: 20, width: self.view.bounds.width - 40, height: 40))
        nameLabel.textAlignment = .center
        nameLabel.text = name
        self.view.addSubview(nameLabel)
        
        femaleLabel = UILabel(frame: CGRect(x: 20, y: 70, width: self.view.bounds.width - 40, height: 40))
        femaleLabel.textAlignment = .center
        femaleLabel.text = female
        self.view.addSubview(femaleLabel)
        
        dateLabel = UILabel(frame: CGRect(x: 20, y: 120, width: self.view.bounds.width - 40, height: 40))
        dateLabel.textAlignment = .center
        dateLabel.text = date
        self.view.addSubview(dateLabel)
        
        mailLabel = UILabel(frame: CGRect(x: 20, y: 170, width: self.view.bounds.width - 40, height: 40))
        mailLabel.textAlignment = .center
        mailLabel.text = mail
        self.view.addSubview(mailLabel)
        
        adressLabel = UILabel(frame: CGRect(x: 20, y: 220, width: self.view.bounds.width - 40, height: 40))
        adressLabel.textAlignment = .center
        adressLabel.text = adress
        self.view.addSubview(adressLabel)
        
        numberLabel = UILabel(frame: CGRect(x: 20, y: 270, width: self.view.bounds.width - 40, height: 40))
        numberLabel.textAlignment = .center
        numberLabel.text = number
        self.view.addSubview(numberLabel)
    }
}
