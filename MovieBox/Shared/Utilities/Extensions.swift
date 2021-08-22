//
//  Extensions.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x0000_00FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension UITableView {
    func registerNib(_ nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}

extension UICollectionView {
    func registerNib(_ nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        if let nibName = type(of: self).description().components(separatedBy: ".").last {
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as! UIView
        }
        return UIView()
    }
}

extension UIColor {
    static let lightGray = UIColor(hexString: "#E9ECEF")
    static let textBlack = UIColor(hexString: "#2B2D42")
    static let textGray = UIColor(hexString: "#8D99AE")
    static let customYellow = UIColor(hexString: "#E6B91E")
    static let darkGray = UIColor(hexString: "#ADB5BD")
}
