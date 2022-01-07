//
//  ViewController.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 11.12.21.
//

import UIKit

fileprivate struct Constants {
    static let leftBorderX: CGFloat = 20
    static let countOfRows: CGFloat = 8
    static let textViewHeight: CGFloat = 300
    static let textViewY: CGFloat = 80
    static let searchBarHeight: CGFloat = 40
    static let addButtonText = "Перейти"
}

class ViewController: UIViewController {

    private var textView = UITextView()
    private var searchBar = UISearchBar()
    private var buttonLogin = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextView()
        createSearchBar()
        addButton()
        searchBar.delegate = self
    }
    
    func createTextView() {
        textView = UITextView(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: Constants.textViewY,
                width: self.view.bounds.width - self.view.bounds.width / Constants.countOfRows,
                height: Constants.textViewHeight
            )
        )
        self.view.addSubview(textView)
    }
    
    func createSearchBar() {
        searchBar = UISearchBar(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: Constants.leftBorderX,
                width: self.view.bounds.width - self.view.bounds.width / Constants.countOfRows,
                height: Constants.searchBarHeight
            )
        )
        self.view.addSubview(searchBar)
    }
    
    @objc func loginView(_ sender: UIButton) {
        let loginContoller = LoginController()
        loginContoller.modalPresentationStyle = .fullScreen
        self.present(loginContoller, animated: true, completion: nil)
    }
    
    func addButton() {
        buttonLogin = UIButton(
            frame: CGRect(
                x: Constants.leftBorderX,
                y: self.view.bounds.height - self.view.bounds.height / Constants.countOfRows,
                width: self.view.bounds.width - self.view.bounds.width / Constants.countOfRows,
                height: Constants.searchBarHeight
            )
        )
        buttonLogin.backgroundColor = .blue
        buttonLogin.setTitle(Constants.addButtonText, for: .normal)
        buttonLogin.addTarget(self, action: #selector(loginView(_:)), for: .touchUpInside)
        self.view.addSubview(buttonLogin)
    }
}

// MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textView.attributedText = Search().searchWord(
            search: searchText.lowercased(),
            searchInText: textView.text
        )
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
}
