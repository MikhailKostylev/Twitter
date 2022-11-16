//
//  UIViewController+Ext.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 16.11.2022.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func presentAlert(
        title: String,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        buttonTitle: String = "OK",
        buttonStyle: UIAlertAction.Style = .cancel,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        var alertStyle = style
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertStyle = .alert
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let action = UIAlertAction(title: buttonTitle, style: buttonStyle, handler: handler)

        alert.addAction(action)
        present(alert, animated: true)
    }
}
