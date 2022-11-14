//
//  UIView+Ext.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 13.11.2022.
//

import UIKit

public extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return frame.size.height + frame.origin.y
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return frame.size.width + frame.origin.x
    }
    
    @discardableResult func prepareForAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

