//
//  UIView+Ext.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 13.11.2022.
//

import UIKit

extension UIView {
    @discardableResult func prepareForAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
