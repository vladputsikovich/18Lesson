//
//  LoginViewController.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 18.12.21.
//

import UIKit

fileprivate struct Constants {
    static let leftBorderX: CGFloat = 20
    static let textFieldHeight: CGFloat = 40
    static let questTextFieldText = "АНКЕТА"
    static let nameTextFieldText = "Имя"
    static let femaleTextFieldText = "Фамилия"
    static let dateTextFieldText = "Дата рождения"
    static let mailTextFieldText = "Емайл"
    static let adressTextFieldText = "Адресс"
    static let numberTextFieldText = "Номер"
    static let applyButtonText = "Подтвердить"
    static let errorAlertText = "Ошибка"
    static let okAlertText = "Ok"
    static let nameAlertText = "Вы не ввели имя"
    static let femaleAlertText = "Вы не ввели фамилию"
    static let dateAlertText = "Вы не ввели дату"
    static let mailAlertText = "Вы не ввели email"
    static let adressAlertText = "Вы не ввели адресс"
    static let numberAlertText = "Вы не ввели номер"
    static let formatPhone = "+XXX (XX) XXX-XX-XX"
    static let validationTypeText = "text"
    static let validationTypeEmail = "email"
    static let keyboardUp: CGFloat = -50
    static let keyboardHeight: CGFloat = 80
}

struct TextFieldForm {
    var validation: String
    var textField: UITextField
    var type: String
    var alertText: String
}

class LoginController: UIViewController {
    
    private var questLabel = UILabel()
    private var nameTextField = UITextField()
    private var femaleTextField = UITextField()
    private var dateTextField = UITextField()
    private var mailTextField = UITextField()
    private var adressTextField = UITextField()
    private var numberTextField = UITextField()
    private var textFields = [TextFieldForm]()
    private var alert = UIAlertController()
    private var applyButton = UIButton()
    
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
        createApplyButton()
        numberTextField.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    //!!! не должно быть привязки к констане. то есть расположение элементов нужно переделать
    func createQuestLabel() {
        questLabel = UILabel(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: 20,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        questLabel.text = Constants.questTextFieldText
        questLabel.textAlignment = .center
        self.view.addSubview(questLabel)
    }
    
    func createNameText() {
        nameTextField = UITextField(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: 70,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        nameTextField.placeholder = Constants.nameTextFieldText
        textFields.append(
            TextFieldForm(
                validation: Constants.validationTypeText,
                textField: nameTextField,
                type: Constants.nameTextFieldText,
                alertText: Constants.nameAlertText
            )
        )
        self.view.addSubview(nameTextField)
    }
    
    func createFemaleText() {
        femaleTextField = UITextField(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: 120,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        femaleTextField.placeholder = Constants.femaleTextFieldText
        textFields.append(
            TextFieldForm(
                validation: Constants.validationTypeText,
                textField: femaleTextField,
                type: Constants.femaleTextFieldText,
                alertText: Constants.femaleAlertText
            )
        )
        self.view.addSubview(femaleTextField)
    }

    func createDateText() {
        dateTextField = UITextField(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: 170,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        dateTextField.placeholder = Constants.dateTextFieldText
        dateTextField.keyboardType = .decimalPad
        textFields.append(
            TextFieldForm(
                validation: Constants.validationTypeText,
                textField: dateTextField,
                type: Constants.dateTextFieldText,
                alertText: Constants.dateAlertText
            )
        )
        self.view.addSubview(dateTextField)
    }

    func createMailText() {
        mailTextField = UITextField(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: 220,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        mailTextField.placeholder = Constants.mailTextFieldText
        mailTextField.keyboardType = .emailAddress
        textFields.append(
            TextFieldForm(
                validation: Constants.validationTypeEmail,
                textField: mailTextField,
                type: Constants.mailTextFieldText,
                alertText: Constants.mailAlertText
            )
        )
        self.view.addSubview(mailTextField)
    }
    
    func createAddressText() {
        adressTextField = UITextField(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: 270,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        adressTextField.placeholder = Constants.adressTextFieldText
        textFields.append(
            TextFieldForm(
                validation: Constants.validationTypeText,
                textField: adressTextField,
                type: Constants.adressTextFieldText,
                alertText: Constants.adressAlertText
            )
        )
        self.view.addSubview(adressTextField)
    }
    
    func createNumberText() {
        numberTextField = UITextField(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: 320,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        numberTextField.placeholder = Constants.numberTextFieldText
        numberTextField.keyboardType = .numberPad
        textFields.append(
            TextFieldForm(
                validation: Constants.validationTypeText,
                textField: numberTextField,
                type: Constants.numberTextFieldText,
                alertText: Constants.numberAlertText
            )
        )
        self.view.addSubview(numberTextField)
    }
    
    @objc func formView(_ button: UIButton) {
        if isValidInput() {
            let formController = FormController(
                model: FormModel(
                    name: nameTextField.text ?? .init(),
                    female: femaleTextField.text ?? .init(),
                    date: dateTextField.text ?? .init(),
                    mail: mailTextField.text ?? .init(),
                    adress: adressTextField.text ?? .init(),
                    number: numberTextField.text ?? .init()
                )
            )
            formController.modalPresentationStyle = .fullScreen
            self.present(formController, animated: true, completion: nil)
        }
    }
    
    func createApplyButton() {
        applyButton = UIButton(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: self.view.bounds.height - Constants.keyboardUp,
                width: self.view.bounds.width - Constants.textFieldHeight,
                height: Constants.textFieldHeight
            )
        )
        applyButton.setTitle(Constants.applyButtonText, for: .normal)
        applyButton.backgroundColor = .green
        applyButton.addTarget(self, action: #selector(formView(_:)), for: .touchUpInside)
        self.view.addSubview(applyButton)
    }
    
    // контстанта
    @objc func keyboardWillShow(_ notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == .zero {
                self.view.frame.origin.y = Constants.keyboardUp
            }
        }

    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != .zero {
                self.view.frame.origin.y = .zero
            }
        }
    }
    
    func isValidInput() -> Bool {
        var isValid = true
        textFields.forEach { textField in
            if textField.validation == "text" {
                if textField.textField.text == "" {
                    alert = UIAlertController(
                        title: Constants.errorAlertText,
                        message: textField.alertText,
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: Constants.okAlertText, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isValid = false
                }
            }
            if textField.validation == "email" {
                guard let mail = mailTextField.text else { return }
                if Format.isValidEmail(mail) {
                    alert = UIAlertController(
                        title: Constants.errorAlertText,
                        message: textField.alertText,
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: Constants.okAlertText, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isValid = false
                }
            }
        }
        return isValid
    }
}

// MARK: UITextFieldDelegate

extension LoginController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = Format.format(with: Constants.formatPhone, phone: newString)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var firstResponder = false
        textFields.forEach { field in
            if field.textField.isFirstResponder {
                field.textField.resignFirstResponder()
                firstResponder = next?.becomeFirstResponder() ?? false
            }
        }
        return firstResponder
    }
}
