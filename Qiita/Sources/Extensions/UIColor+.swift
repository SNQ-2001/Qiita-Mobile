//
//  UIColor+.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit

extension UIColor {
    // UIColor(hex: カラーコード, alpha: CGFloat)
    convenience init(hex: String, alpha: CGFloat) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
