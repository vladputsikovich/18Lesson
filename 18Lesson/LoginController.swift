//
//  LoginViewController.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 18.12.21.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    var questLabel = UILabel()
    var nameTextField = UITextField()
    var femaleTextField = UITextField()
    var dateTextField = UITextField()
    var mailTextField = UITextField()
    var adressTextField = UITextField()
    var numberTextField = UITextField()
    
    var alert = UIAlertController()
    
    var applyButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        createQuestLabel()
        
        createNameText()
        
        createFemaleText()
        
        createDateText()
        
        createMailText()
        
        createAddressText()
        
        createNumberText()
        numberTextField.delegate = self
        
        createApplyButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func createQuestLabel() {
        questLabel = UILabel(frame: CGRect(x: 20, y: 20, width: self.view.bounds.width - 40, height: 40))
        questLabel.text = "АНКЕТА"
        questLabel.textAlignment = .center
        self.view.addSubview(questLabel)
    }
    
    func createNameText() {
        nameTextField = UITextField(frame: CGRect(x: 20, y: 70, width: self.view.bounds.width - 40, height: 40))
        nameTextField.placeholder = "Имя"
        self.view.addSubview(nameTextField)
    }
    
    func createFemaleText() {
        femaleTextField = UITextField(frame: CGRect(x: 20, y: 120, width: self.view.bounds.width - 40, height: 40))
        femaleTextField.placeholder = "Фамилия"
        self.view.addSubview(femaleTextField)
    }
    
    func createDateText() {
        dateTextField = UITextField(frame: CGRect(x: 20, y: 170, width: self.view.bounds.width - 40, height: 40))
        dateTextField.placeholder = "Дата рождения"
        numberTextField.keyboardType = .decimalPad
        self.view.addSubview(dateTextField)
    }
    
    func createMailText() {
        mailTextField = UITextField(frame: CGRect(x: 20, y: 220, width: self.view.bounds.width - 40, height: 40))
        mailTextField.placeholder = "Емайл"
        numberTextField.keyboardType = .emailAddress
        self.view.addSubview(mailTextField)
    }
    
    func createAddressText() {
        adressTextField = UITextField(frame: CGRect(x: 20, y: 270, width: self.view.bounds.width - 40, height: 40))
        adressTextField.placeholder = "Адресс"
        self.view.addSubview(adressTextField)
    }
    
    func createNumberText() {
        numberTextField = UITextField(frame: CGRect(x: 20, y: 320, width: self.view.bounds.width - 40, height: 40))
        numberTextField.placeholder = "Номер"
        numberTextField.keyboardType = .numberPad
        self.view.addSubview(numberTextField)
    }
    
    @objc func formView(_ button: UIButton) {
        if isValidInput() {
            let formController = FormController()
            formController.modalPresentationStyle = .fullScreen
            formController.name = nameTextField.text ?? ""
            formController.female = femaleTextField.text ?? ""
            formController.mail = mailTextField.text ?? ""
            formController.adress = adressTextField.text ?? ""
            formController.date = dateTextField.text ?? ""
            formController.number = numberTextField.text ?? ""
            self.present(formController, animated: true, completion: nil)
        }
    }
    
    func createApplyButton() {
        applyButton = UIButton(frame: CGRect(x: 20, y: self.view.bounds.height - 80, width: self.view.bounds.width - 40, height: 40))
        applyButton.setTitle("Подтвердить", for: .normal)
        applyButton.backgroundColor = .green
        applyButton.addTarget(self, action: #selector(formView(_:)), for: .touchUpInside)
        self.view.addSubview(applyButton)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y = -50
            }
        }

    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameTextField.isFirstResponder {
            nameTextField.resignFirstResponder()
            return femaleTextField.becomeFirstResponder()
        }
        if femaleTextField.isFirstResponder {
            femaleTextField.resignFirstResponder()
            return dateTextField.becomeFirstResponder()
        }
        if dateTextField.isFirstResponder {
            dateTextField.resignFirstResponder()
            return mailTextField.becomeFirstResponder()
        }
        if mailTextField.isFirstResponder {
            mailTextField.resignFirstResponder()
            return adressTextField.becomeFirstResponder()
        }
        if mailTextField.isFirstResponder {
            mailTextField.resignFirstResponder()
            return adressTextField.becomeFirstResponder()
        }
        if adressTextField.isFirstResponder {
            adressTextField.resignFirstResponder()
            return numberTextField.becomeFirstResponder()
        }
        return numberTextField.resignFirstResponder()
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+XXX (XX) XXX-XX-XX", phone: newString)
        return false
    }
    func isValidInput() -> Bool {
        
        if nameTextField.text == "" {
            alert = UIAlertController(title: "Ошибка", message: "Вы не ввели имя", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if femaleTextField.text == "" {
            alert = UIAlertController(title: "Ошибка", message: "Вы не ввели фамилию", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if adressTextField.text == "" {
            alert = UIAlertController(title: "Ошибка", message: "Вы не ввели адресс", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if dateTextField.text == "" {
            alert = UIAlertController(title: "Ошибка", message: "Вы не ввели дату", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if numberTextField.text == "" {
            alert = UIAlertController(title: "Ошибка", message: "Вы не ввели номер", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        guard let mail = mailTextField.text else {return false}
        if isValidEmail(mail) {
            alert = UIAlertController(title: "Ошибка", message: "Вы не ввели email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

