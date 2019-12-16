//
//  Animation.swift
//  MarvelSuperHeroes
//
//  Created by Miguel Vicario on 11/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

//MARK: - Animation
public class Animation {
    
    //MARK: - Instance Properties
    private let label: UILabel!
    private let text: String!
    
    //MARK: - Init
    public init(label: UILabel, text: String) {
        self.label = label
        self.text = text
    }
    
    //MARK: - Methods
    public func animation() {
        UIView.transition(with: label,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.label.text = self?.text }, completion: nil)
    }
}
