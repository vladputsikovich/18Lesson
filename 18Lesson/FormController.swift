//
//  FormController.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 18.12.21.
//

import UIKit

fileprivate struct Constants {
    static let labelLeftBorderX: CGFloat = 20
    static let labelHeight: CGFloat = 40
}

class FormController: UIViewController {
    
    private var nameLabel = UILabel()
    private var femaleLabel = UILabel()
    private var dateLabel = UILabel()
    private var mailLabel = UILabel()
    private var adressLabel = UILabel()
    private var numberLabel = UILabel()

    private var formModel: FormModel
    
    init(model: FormModel) {
        self.formModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createLabels()
    }
    // не должно быть привязки к констане. то есть расположение элементов нужно переделать
    func createLabels() {
        nameLabel = UILabel(
            frame: CGRect(
                x: Constants.labelLeftBorderX,
                y: 20,
                width: self.view.bounds.width - Constants.labelHeight,
                height: Constants.labelHeight
            )
        )
        nameLabel.textAlignment = .center
        nameLabel.text = formModel.name
        self.view.addSubview(nameLabel)
        
        femaleLabel = UILabel(
            frame: CGRect(
                x: Constants.labelLeftBorderX,
                y: 70,
                width: self.view.bounds.width - Constants.labelHeight,
                height: Constants.labelHeight
            )
        )
        femaleLabel.textAlignment = .center
        femaleLabel.text = formModel.female
        self.view.addSubview(femaleLabel)
        
        dateLabel = UILabel(
            frame: CGRect(
                x: Constants.labelLeftBorderX,
                y: 120,
                width: self.view.bounds.width - Constants.labelHeight,
                height: Constants.labelHeight
            )
        )
        dateLabel.textAlignment = .center
        dateLabel.text = formModel.date
        self.view.addSubview(dateLabel)
        
        mailLabel = UILabel(
            frame: CGRect(
                x: Constants.labelLeftBorderX,
                y: 170,
                width: self.view.bounds.width - Constants.labelHeight,
                height: Constants.labelHeight
            )
        )
        mailLabel.textAlignment = .center
        mailLabel.text = formModel.mail
        self.view.addSubview(mailLabel)
        
        adressLabel = UILabel(
            frame: CGRect(
                x: Constants.labelLeftBorderX,
                y: 220,
                width: self.view.bounds.width - Constants.labelHeight,
                height: Constants.labelHeight
            )
        )
        adressLabel.textAlignment = .center
        adressLabel.text = formModel.adress
        self.view.addSubview(adressLabel)
        
        numberLabel = UILabel(
            frame: CGRect(
                x: Constants.labelLeftBorderX,
                y: 270,
                width: self.view.bounds.width - Constants.labelHeight,
                height: Constants.labelHeight
            )
        )
        numberLabel.textAlignment = .center
        numberLabel.text = formModel.number
        self.view.addSubview(numberLabel)
    }
}
