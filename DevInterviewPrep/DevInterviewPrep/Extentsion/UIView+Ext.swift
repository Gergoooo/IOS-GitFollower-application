//
//  UIView+Ext.swift
//  DevInterviewPrep
//
//  Created by Gergő  on 2025. 09. 21..
//

import UIKit

extension UIView  {
    
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
