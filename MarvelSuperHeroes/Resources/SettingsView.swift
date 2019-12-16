//
//  SettingsView.swift
//  MarvelSuperHeroes
//
//  Created by Miguel Vicario on 11/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

//MARK: - CornerView
@IBDesignable open class CornerView: UIView {
    
    //MARK: - @IBInspectable Properties
    @IBInspectable var cornerRadius: Double {
        get { return Double(self.layer.cornerRadius) }
        set { self.layer.cornerRadius = CGFloat(newValue) }
    }
    
    override open func awakeFromNib() {
        
    }
}
