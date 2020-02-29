//
//  UITextConfiguration.swift
//  Meural
//
//  Created by Joe Spadafora on 3/21/19.
//  Copyright © 2019 Meural Inc. All rights reserved.
//

import UIKit

protocol TextStyleConfiguring: AnyObject {
    var text: String? { get set }
    func apply(color: StyleColor, fontStyle: FontStyle)
}

extension TextStyleConfiguring {
    @discardableResult func applying(color: StyleColor, fontStyle: FontStyle, text: String? = nil) -> Self {
        apply(color: color, fontStyle: fontStyle)
        self.text = text
        return self
    }
}

protocol ButtonStyleConfiguring {
    func apply(color: StyleColor, fontStyle: FontStyle, for state: UIControl.State)
}

extension ButtonStyleConfiguring {
    @discardableResult func applying(color: StyleColor, fontStyle: FontStyle, for state: UIControl.State) -> Self {
        apply(color: color, fontStyle: fontStyle, for: state)
        return self
    }
}

extension UILabel: TextStyleConfiguring {
    func apply(color: StyleColor, fontStyle: FontStyle) {
        self.textColor = color.uiColor
        self.font = fontStyle.font
    }

    func apply(color: StyleColor, fontStyle: FontStyle, textAlignment: NSTextAlignment) {
        apply(color: color, fontStyle: fontStyle)
        self.textAlignment = textAlignment
    }
}

extension UIButton: ButtonStyleConfiguring {
    func apply(color: StyleColor, fontStyle: FontStyle, for state: UIControl.State) {
        setTitleColor(color.uiColor, for: state)
        titleLabel?.font = fontStyle.font
    }
}
