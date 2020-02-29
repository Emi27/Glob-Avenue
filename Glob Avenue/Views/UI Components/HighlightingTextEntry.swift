//
//  HighlightingTextEntry.swift
//  Meural
//
//  Created by Joe Spadafora on 2/14/18.
//  Copyright © 2018 Meural Inc. All rights reserved.
//

import UIKit

struct ValidationResult {
    let isValid: Bool
    let errorMessage: String?
}

typealias Validation = ((String?) -> ValidationResult)

protocol HighlightingTextEntry: AnyObject {
    var isRequired: Bool { get set }
    var validation: Validation? { get }
    var enteredText: String? { get set }

    // Colors
    var focusedTint: UIColor { get set }
    var borderTint: UIColor { get set }
    var errorTint: UIColor { get set }
    var titleTint: UIColor { get set }
    var textTint: UIColor { get set }

    // Fonts
    var titleFont: UIFont { get set }
    var errorFont: UIFont { get set }
    var textFont: UIFont { get set }

    // Title
    var title: String? { get set }
    var titleLabel: UILabel { get }

    // Error
    var error: String? { get set }
    var errorLabel: UILabel { get }

    // Setup
    func setupObservers(onBeginEditing: @escaping (() -> Void),
                        onEndEditing: @escaping (() -> Void),
                        onTextChanged: @escaping (() -> Void))
    func setupInitial()
    func setupConstraints()
    func setupTints()
}

extension HighlightingTextEntry {
    static var defaultCornerRadius: CGFloat { return 2 }
    static var defaultBorderColor: UIColor { return .gray }
    static var defaultFocusColor: UIColor { return .darkText }
    static var defaultErrorColor: UIColor { return .red }
    static var defaultTitleColor: UIColor { return .darkText }
    static var defaultTextColor: UIColor { return .darkText }

    static var defaultErrorFont: UIFont { return .systemFont(ofSize: 12) }
    static var defaultTitleFont: UIFont { return .boldSystemFont(ofSize: 14) }
    static var defaultTextFont: UIFont { return .systemFont(ofSize: 14) }
}

extension HighlightingTextEntry where Self: UIView {

    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            updateTitleLabel(text: newValue)
        }
    }

    var error: String? {
        get {
            return errorLabel.text
        }

        set {
            errorLabel.text = newValue
        }
    }

    var titleFont: UIFont {
        get {
            return titleLabel.font
        }

        set {
            titleLabel.font = newValue
        }
    }

    var errorFont: UIFont {
        get {
            return errorLabel.font
        }

        set {
            errorLabel.font = newValue
        }
    }

    func updateTitleLabel(text: String?) {
        titleLabel.attributedText = attributedTitle(forText: text)
    }

    func setupInitial() {
        setupBorder()
        setupFonts()
        setupObservers(onBeginEditing: makeFocused, onEndEditing: loseFocus, onTextChanged: validate)
    }

    func setupConstraints() {
        setupTitleConstraints()
        setupErrorConstraints()
    }

    private func setupFonts() {
        errorLabel.font = Self.defaultErrorFont
        titleLabel.font = Self.defaultTitleFont
        setupTints()
    }

    private func setupBorder() {
        layer.cornerRadius = Self.defaultCornerRadius
        layer.borderColor = borderTint.cgColor
        layer.borderWidth = 1
    }

    private func setupTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        superview?.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
    }

    private func setupErrorConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        superview?.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
    }

    private func attributedTitle(forText text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        let title = NSAttributedString(string: text)
        if isRequired {
            let full = NSMutableAttributedString()
            let required = NSAttributedString(string: " *", attributes: [.foregroundColor: errorTint])
            full.append(title)
            full.append(required)
            return full
        } else {
            return title
        }
    }

    func makeFocused() {
        animateBorder(toColor: focusedTint, duration: 0.2)
    }

    func loseFocus() {
        animateBorder(toColor: borderTint, duration: 0.1)
    }

    func validate() {
        if let validation = validation {
            let result = validation(enteredText)
            errorLabel.text = result.isValid ? nil : result.errorMessage

        }
    }

    private func animateBorder(toColor color: UIColor, duration: Double) {
        let keyPath = "borderColor"
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = layer.borderColor
        animation.toValue = color.cgColor
        animation.duration = duration
        animation.repeatCount = 1
        layer.borderColor = color.cgColor
        layer.add(animation, forKey: keyPath)
    }
}

class HighlightingTextField: UITextField, HighlightingTextEntry {
    var isRequired: Bool = false {
        didSet {
            updateTitleLabel(text: title)
        }
    }
    var validation: Validation?
    var enteredText: String? {
        get {
            return text
        }
        set {
            text = newValue
        }
    }
    // Colors
    var borderTint: UIColor = HighlightingTextField.defaultBorderColor
    var errorTint: UIColor = HighlightingTextField.defaultErrorColor
    var focusedTint: UIColor = HighlightingTextField.defaultFocusColor
    var titleTint: UIColor = HighlightingTextField.defaultTitleColor
    var textTint: UIColor = HighlightingTextField.defaultTextColor

    var textFont: UIFont {
        get {
            return font ?? HighlightingTextField.defaultTextFont
        }
        set {
            font = newValue
        }
    }

    var textInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    let titleLabel: UILabel = {
        let newTitleLabel = UILabel()
        newTitleLabel.textAlignment = .left
        return newTitleLabel
    }()

    let errorLabel: UILabel = {
        let newTitleLabel = UILabel()
        newTitleLabel.textAlignment = .right
        return newTitleLabel
    }()

    override func updateConstraints() {
        super.updateConstraints()
        setupConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitial()
        textFont = HighlightingTextField.defaultTextFont
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitial()
        textFont = HighlightingTextField.defaultTextFont
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    func setupTints() {
        errorLabel.textColor = errorTint
        titleLabel.textColor = titleTint
        textColor = textTint
    }

    func setupObservers(onBeginEditing: @escaping (() -> Void),
                        onEndEditing: @escaping (() -> Void),
                        onTextChanged: @escaping (() -> Void)) {
        let center = NotificationCenter.default
        _ = center.addObserver(forName: UITextField.textDidBeginEditingNotification, object: self, queue: nil) { _ in
            onBeginEditing()
        }

        _ = center.addObserver(forName: UITextField.textDidEndEditingNotification, object: self, queue: nil) { _ in
            onEndEditing()
        }

        _ = center.addObserver(forName: UITextField.textDidChangeNotification, object: self, queue: nil) { _ in
            onTextChanged()
        }
    }

}

class HighlightingTextView: UITextView, HighlightingTextEntry {
    var isRequired: Bool = false {
        didSet {
            updateTitleLabel(text: title)
        }
    }

    var validation: Validation?
    var enteredText: String? {
        get {
            return text
        }
        set {
            text = newValue
        }
    }
    // Colors
    var borderTint: UIColor = HighlightingTextView.defaultBorderColor
    var errorTint: UIColor = HighlightingTextView.defaultErrorColor
    var focusedTint: UIColor = HighlightingTextView.defaultFocusColor
    var titleTint: UIColor = HighlightingTextView.defaultTitleColor
    var textTint: UIColor = HighlightingTextView.defaultTextColor

    var textFont: UIFont {
        get {
            return font ?? HighlightingTextView.defaultTextFont
        }
        set {
            font = newValue
        }
    }

    var textInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    let titleLabel: UILabel = {
        let newTitleLabel = UILabel()
        newTitleLabel.textAlignment = .left
        newTitleLabel.font = HighlightingTextView.defaultTitleFont
        return newTitleLabel
    }()

    let errorLabel: UILabel = {
        let newTitleLabel = UILabel()
        newTitleLabel.textAlignment = .right
        return newTitleLabel
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupInitial()
        textContainerInset = textInset
        textFont = HighlightingTextView.defaultTextFont
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitial()
        textContainerInset = textInset
        textFont = HighlightingTextView.defaultTextFont
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setupTints() {
        errorLabel.textColor = errorTint
        titleLabel.textColor = titleTint
        textColor = textTint

    }

    func setupObservers(onBeginEditing: @escaping (() -> Void),
                        onEndEditing: @escaping (() -> Void),
                        onTextChanged: @escaping (() -> Void)) {
        let center = NotificationCenter.default
        _ = center.addObserver(forName: UITextView.textDidBeginEditingNotification, object: self, queue: nil) { _ in
            onBeginEditing()
        }

        _ = center.addObserver(forName: UITextView.textDidEndEditingNotification, object: self, queue: nil) { _ in
            onEndEditing()
        }

        _ = center.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: nil) { _ in
            onTextChanged()

            // Updates content size to correctly resize to hold all the text
            let width = self.frame.size.width
            let size = self.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
            self.contentSize = size
        }
    }
}
