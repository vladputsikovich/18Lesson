//
//  Search.swift
//  18Lesson
//
//  Created by Владислав Пуцыкович on 7.01.22.
//

import UIKit

struct Search {
    func searchWord(search: String, searchInText: String) -> NSMutableAttributedString {
        let string: NSMutableAttributedString = NSMutableAttributedString(string: searchInText)
        let words: [String] = searchInText.lowercased().components(separatedBy:" ")

        for word in words {
            if word.contains(search) {
                let rangeFirst: NSRange = (word as NSString).range(of: search)
                let rangeSecond: NSRange = (string.string as NSString).range(of: word)
                var range: NSRange = NSRange(
                    location: rangeSecond.location + rangeFirst.location,
                    length: rangeFirst.length
                )
                // баг вылет
                if range.location > string.length {
                    range.location = .zero
                }
                string.addAttribute(
                    NSAttributedString.Key.backgroundColor,
                    value: UIColor.yellow,
                    range: range
                )
            }
        }
        return string
    }
}
