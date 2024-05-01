//
//  RoundedCornerView.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import UIKit

class RoundedCornerView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
//    @IBInspectable var shadowOpacity: CGFloat = 0 {
//        didSet {
//            layer.shadowOpacity = 0
//        }
//    }
//    @IBInspectable var shadowRadius: CGFloat = 0 {
//        didSet {
//            layer.shadowRadius = 0
//        }
//    }
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.masksToBounds = false
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOpacity = 0.7
            layer.shadowOffset = .init(width: 2, height: 3)
            layer.shadowRadius = 2
            layer.shouldRasterize = true
            layer.rasterizationScale = true ? UIScreen.main.scale : 1
        }
    }
//    @IBInspectable var shadowOffset: CGSize = .zero {
//        didSet {
//            layer.shadowOffset = .zero
//        }
//    }
    
}
