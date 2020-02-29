//
//  UIFontExtensions.swift
//  Meural
//
//  Created by Joseph Spadafora on 8/10/17.
//  Copyright © 2017 Meural Inc. All rights reserved.
//

import UIKit

extension UIFont {

    static let libreBaskerville = "LibreBaskerville"
    static let nunitoSans = "NunitoSans"

    private static func libreBaskerville(_ weight: LibreBaskervilleWeight, size: CGFloat) -> UIFont {
        return UIFont(name: libreBaskerville + "-" + weight.rawValue, size: size)!
    }

    private static func nunitoSans(_ weight: NunitoSansWeight, size: CGFloat) -> UIFont {
        return UIFont(name: nunitoSans + "-" +  weight.rawValue, size: size)!
    }

    static let headingXXL = UIFont.libreBaskerville(.bold, size: 66)
    static let headingXL = UIFont.libreBaskerville(.bold, size: 55)
    static let headingL = UIFont.libreBaskerville(.bold, size: 55)
    static let headingM = UIFont.libreBaskerville(.bold, size: 28)
    static let headingS = UIFont.libreBaskerville(.bold, size: 21)
    static let headingXS = UIFont.libreBaskerville(.bold, size: 16)
    static let headingXXSSerif = UIFont.libreBaskerville(.bold, size: 12)
    static let headingXXSSans = UIFont.nunitoSans(.bold, size: 12)

    static let bodyLargeBold = UIFont.nunitoSans(.bold, size: 21)
    static let bodyLarge = UIFont.nunitoSans(.regular, size: 21)
    static let bodyBoldM = UIFont.nunitoSans(.bold, size: 19)
    static let body = UIFont.nunitoSans(.regular, size: 16)
    static let bodyBold = UIFont.nunitoSans(.bold, size: 16)
    static let fine = UIFont.nunitoSans(.regular, size: 12)

    static let editorialSubtitle = UIFont.libreBaskerville(.regular, size: 19)

    enum LibreBaskervilleWeight: String {
        case bold = "Bold"
        case italic = "Italic"
        case regular = "Regular"
    }

    enum NunitoSansWeight: String {
        case black = "Black"
        case blackItalic = "BlackItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case extraBold = "ExtraBold"
        case extraBoldItalic = "ExtraBoldItalic"
        case extraLight = "ExtraLight"
        case extraLightItalic = "ExtraLightItalic"
        case italic = "Italic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case regular = "Regular"
        case semiBold = "SemiBold"
        case semiBoldItalic = "SemiBoldItalic"
    }

    static let lbHeaderM = UIFont.libreBaskerville(.bold, size: 19)

    var pxSize: String {
        return String(Int(pointSize)) + "px"
    }
}
struct FontStyle {
    let font: UIFont

    // Heading
    static let headingsXXL = FontStyle(font: UIFont.boldSystemFont(ofSize: 39))
    static let headingsXL = FontStyle(font: UIFont.boldSystemFont(ofSize: 32))
    static let headingL = FontStyle(font: UIFont.boldSystemFont(ofSize: 27))
    static let headingM = FontStyle(font: UIFont.boldSystemFont(ofSize: 22))
    static let headingS = FontStyle(font: UIFont.boldSystemFont(ofSize: 19))
    static let headingXS = FontStyle(font: UIFont.boldSystemFont(ofSize: 16))

    static let headingXXSSans = FontStyle(font: UIFont.boldSystemFont(ofSize: 13))
    // Body
    static let bodyLarge = FontStyle(font: UIFont.systemFont(ofSize: 19))
    static let body = FontStyle(font: UIFont.systemFont(ofSize: 16))
    static let bodyFine = FontStyle(font: UIFont.systemFont(ofSize: 13))
    static let bodyBold = FontStyle(font: UIFont.boldSystemFont(ofSize: 16))

    // Button
    static let buttonSmall = FontStyle(font: UIFont.boldSystemFont(ofSize: 16))
    static let buttonLarge = FontStyle(font: UIFont.boldSystemFont(ofSize: 19))
}
