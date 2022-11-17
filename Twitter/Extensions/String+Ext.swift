//
//  String+Ext.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 17.11.2022.
//

import Foundation

extension String {
    private static let firstPart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
    private static let serverPart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
    private static let emailRegex = firstPart + "@" + serverPart + "[A-Za-z]{2,6}"
    
    public var isValidEmail: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type(of:self).emailRegex)
        return predicate.evaluate(with: self)
    }
}
