//
//  UIView+Layout.swift
//  fk_3
//
//  Created by George Weaver on 08.05.2023.
//

import UIKit

extension UIView {
    
    func addSubviewWithoutAutoresizing(_ subviews: UIView...) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
