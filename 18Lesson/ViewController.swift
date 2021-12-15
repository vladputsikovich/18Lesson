//
//  ViewController.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 11.12.21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {

    //var textField = UITextField()
    var textView = UITextView()
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.createTextField()
//
//        textField.delegate = self
        
    
        self.createTextView()
        self.createSearchBar()
        
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
    
    func changeColor(_ wor: String) -> NSMutableAttributedString{
        let string: NSMutableAttributedString = NSMutableAttributedString(string: textView.text)
        let words: [String] = textView.text.lowercased().components(separatedBy:" ")

        for word in words {
            if word.contains(wor) {
                let range: NSRange = (string.string as NSString).range(of: word)
                string.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: range)
            }
        }
        return string
    }
    
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textView.attributedText = changeColor(searchText.lowercased())
    }
}

