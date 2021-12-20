//
//  ViewController.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 11.12.21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {

    var textView = UITextView()
    var searchBar = UISearchBar()
    var buttonLogin = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createTextView()
        self.createSearchBar()
        self.addButton()
        
        searchBar.delegate = self
    }
    
    func createTextView() {
        textView = UITextView(frame: CGRect(x: 20, y: 80, width: self.view.bounds.width - self.view.bounds.width / 8, height: 300))
        self.view.addSubview(textView)
    }
    
    func createSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 20, y: 20, width: self.view.bounds.width - self.view.bounds.width / 8, height: 40))
        self.view.addSubview(searchBar)
    }
    
    @objc func loginView(_ sender: UIButton) {
        let loginContoller = LoginController()
        loginContoller.modalPresentationStyle = .fullScreen
        self.present(loginContoller, animated: true, completion: nil)
    }
    
    func addButton() {
        buttonLogin = UIButton(frame: CGRect(x: 20, y: self.view.bounds.height - self.view.bounds.height / 8 , width: self.view.bounds.width - self.view.bounds.width / 8, height: 40))
        buttonLogin.backgroundColor = .blue
        buttonLogin.setTitle("Перейти", for: .normal)
        buttonLogin.addTarget(self, action: #selector(loginView(_:)), for: .touchUpInside)
        self.view.addSubview(buttonLogin)
    }
    
    func changeColor(_ wor: String) -> NSMutableAttributedString{
        let string: NSMutableAttributedString = NSMutableAttributedString(string: textView.text)
        let words: [String] = textView.text.lowercased().components(separatedBy:" ")

        for word in words {
            if word.contains(wor) {
                let rangeFirst: NSRange = (word as NSString).range(of: wor)
                let rangeSecond: NSRange = (string.string as NSString).range(of: word)
                var range: NSRange = NSRange(location: rangeSecond.location + rangeFirst.location, length: rangeFirst.length)
                if range.location > string.length {
                    range.location = 0
                }
                string.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: range)
            }
        }
        return string
    }
    
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textView.attributedText = changeColor(searchText.lowercased())
    }
}

