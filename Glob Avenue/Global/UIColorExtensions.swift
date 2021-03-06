//
//  UIColorExtensions.swift
//  Glob Avenue
//
//  Created by Imran Malik on 26/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

extension UIColor {

    // MARK: Colors
    static let brandPurple = UIColor(red: 115/255, green: 19/255, blue: 178/255, alpha: 1)
    static let errorRed = UIColor(red: 212/255, green: 99/255, blue: 99/255, alpha: 1)
    static let cautionYellow = UIColor(red: 237/255, green: 180/255, blue: 94/255, alpha: 1)
    static let successGreen = UIColor(red: 121/255, green: 201/255, blue: 156/255, alpha: 1)
    static let accentOrage = UIColor(red: 237/255, green: 180/255, blue: 94/255, alpha: 1)

    // MARK: Gray
    static let strongGray = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1) // #333333
    static let slateGray = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1) // #666666
    static let secondaryGray = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    static let separatorGray = UIColor(white: 237.0 / 255.0, alpha: 1.0)

    static let placeHolderGray = UIColor(red: 218/255, green: 220/255, blue: 229/255, alpha: 1)
    static let darkText = UIColor(red: 22/255, green: 4/255, blue: 36/255, alpha: 1)
    static let mutedGrayText = UIColor(red: 161/255, green: 164/255, blue: 178/255, alpha: 1)
    static let bgGray = UIColor(red: 245/255, green: 246/255, blue: 248/255, alpha: 255/255)

    // MARK: Brightness controls
    static let brightnessControlsBackground = UIColor(red: 44/255, green: 28/255, blue: 58/255, alpha: 1)
    static let brightnessDisabledIconColor = UIColor(red: 86/255, green: 73/255, blue: 97/255, alpha: 1)

    // MARK: Overlay
    static let whiteMostlyOpaque = UIColor.white.withAlphaComponent(0.85)

    // MARK: Helpers
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let r = Float(components[0]) // swiftlint:disable:this identifier_name
        let g = Float(components[1]) // swiftlint:disable:this identifier_name
        let b = Float(components[2]) // swiftlint:disable:this identifier_name
        var a = Float(1.0)           // swiftlint:disable:this identifier_name

        if components.count >= 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX",
                          lroundf(r * 255),
                          lroundf(g * 255),
                          lroundf(b * 255),
                          lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX",
                          lroundf(r * 255),
                          lroundf(g * 255),
                          lroundf(b * 255))
        }
    }
}

// Generated by Zeplin
enum StyleColor: String {
    case textBlack
    case textGray
    case brandColor

    var uiColor: UIColor {
        return UIColor(named: rawValue)!
    }
}
