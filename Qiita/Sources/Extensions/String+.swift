//
//  String+.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/14.
//

import Foundation

// Font Awesome
extension String {
    static func FontAwesome(unicode: String) -> String {
        guard let unicode = Int(unicode, radix: 16) else { return String(format: "%C", 0x0000) }
        return String(format: "%C", unicode)
    }
}

// 正規表現 抽出
extension String {
    func match(_ pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern), let matched = regex.firstMatch(in: self, range: NSRange(location: 0, length: self.count))
        else { return [] }
        print(matched)
        return (0 ..< matched.numberOfRanges).map {
            NSString(string: self).substring(with: matched.range(at: $0))
        }
    }
}
