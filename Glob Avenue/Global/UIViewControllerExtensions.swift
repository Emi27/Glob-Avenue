//
//  UIViewControllerExtensions.swift
//  Meural
//
//  Created by Ross Cooperman on 2/8/17.
//  Copyright © 2017 Meural Inc. All rights reserved.
//

import UIKit
import NotificationBannerSwift

extension UIViewController {

    func checkForUpdateRequestIn(scrollView: UIScrollView) -> Bool {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        return bottomEdge >= scrollView.contentSize.height - (self.view.frame.height / 3)
    }

    private static let meuralBannerColors = MeuralBannerColors()

    func showSuccessBanner(message: String, duration: TimeInterval, onTap: (() -> Void)?) {
        DispatchQueue.main.async {
            let banner = NotificationBanner(title: message, style: .success, colors: MeuralBannerColors())
            banner.onTap = onTap
            banner.titleLabel?.font = .body
            banner.titleLabel?.textColor = .white
            banner.duration = duration
            banner.show()
        }
    }

    func showSuccessBanner(message: String, duration: TimeInterval) {
        showSuccessBanner(message: message, duration: duration, onTap: nil)
    }

    func showSuccessBanner(message: String, onTap: (() -> Void)?) {
        showSuccessBanner(message: message, duration: .bannerDuration, onTap: onTap)
    }

    func showSuccessBanner(message: String) {
        showSuccessBanner(message: message, onTap: nil)
    }

    func showFailBanner(message: String, duration: TimeInterval = .bannerDuration, onTap: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let banner = NotificationBanner(title: message, style: .danger, colors: MeuralBannerColors())
            banner.onTap = onTap
            banner.titleLabel?.font = .body
            banner.titleLabel?.textColor = .white
            banner.duration = duration
            banner.show()
        }
    }

    func handledSendGallery(withMessage message: String) {
        showSuccessBanner(message: message)
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

private class MeuralBannerColors: BannerColorsProtocol {
    func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .danger: return .errorRed
        case .success: return .successGreen
        case .info, .warning : return .clear
        case .customView: return .clear
        }
    }
}

extension TimeInterval {
    static var bannerDuration: TimeInterval { return 2.5 }
}
