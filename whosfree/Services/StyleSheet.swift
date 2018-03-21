//
//  StyleSheet.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct Style {
    // Default Colors
    static var backgroundColor = UIColor.white
    static var monthViewLabelColor = UIColor.white
    static var monthViewRightButtonColor = UIColor.white
    static var monthviewLeftButtonColor = UIColor.white
    static var activeCellLabelColor = UIColor.white
    static var highlightedActiveCellLabelColor = UIColor.black
    static var weekdaysLabelColor = UIColor.white
    
    // Colors for Dark Theme
    static func darkTheme(){
        backgroundColor = Stylesheet.Colors.DarkGray
        monthViewLabelColor = Stylesheet.Colors.White
        monthViewRightButtonColor = Stylesheet.Colors.White
        monthviewLeftButtonColor = Stylesheet.Colors.White
        activeCellLabelColor = Stylesheet.Colors.White
        highlightedActiveCellLabelColor = Stylesheet.Colors.Black
        weekdaysLabelColor = Stylesheet.Colors.White
    }
    
    // Colors for Light Theme
    static func lightTheme(){
        backgroundColor = Stylesheet.Colors.White
        monthViewLabelColor = Stylesheet.Colors.Black
        monthViewRightButtonColor = Stylesheet.Colors.Black
        monthviewLeftButtonColor = Stylesheet.Colors.Black
        activeCellLabelColor = Stylesheet.Colors.Black
        highlightedActiveCellLabelColor = Stylesheet.Colors.White
        weekdaysLabelColor = Stylesheet.Colors.Black
    }
}

enum Stylesheet {
    
    enum MyTheme {
        case Light
        case Dark
    }
    
    enum Colors {
        static let White = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
        static let LightGrey = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.00)
        static let Red = UIColor(red: 0.949, green: 0.141, blue: 0, alpha: 1.0)
        static let Orange = UIColor(red: 0.925, green: 0.471, blue: 0.235, alpha: 1.00)
        static let Yellow = UIColor(red: 0.9569, green: 0.8627, blue: 0, alpha: 1.0)
        static let Dark = UIColor(red: 0.184, green: 0.157, blue: 0.118, alpha: 1.00)
        static let RedBg = UIColor(red: 0.8471, green: 0.1608, blue: 0.1608, alpha: 1.0)
        static let Gray = UIColor.gray
        static let LightBlue = UIColor(red: 0.306, green: 0.675, blue: 0.839, alpha: 1.00)
        static let NYCBlue = UIColor(red: 0.267, green: 0.612, blue: 0.843, alpha: 1.00)
        static var DarkGray = UIColor(red: 0.373, green: 0.365, blue: 0.365, alpha: 1.00)
        static var DarkRed = UIColor(red: 0.463, green: 0.176, blue: 0.188, alpha: 1.00)
        static var Black = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
    }
    
    enum Fonts {
        static let AppName = UIFont(name: "HelveticaNeue-CondensedBold", size: 45.0)
        static let PostTitle = UIFont(name: "HelveticaNeue-CondensedBold", size: 25.0)
        static let Regular = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        static let TextfieldFont = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        static let Link = UIFont(name: "HelveticaNeue", size: 15.0)
        static let Bold = UIFont(name: "HelveticaNeue-Medium", size: 17.0)
    }
    
    enum BorderWidths {
        static let Textviews = 0.5
        static let TextfieldEditable = 1
        static let TextfieldCompleted = 0
        static let PostImages = 0.5
        static let UserImages = 0.5
        static let FunctionButtons = 0.5
        static let Buttons = 1
    }
    
    enum ConstraintSizes {
        static let ButtonWidthMult = 0.6
        static let ButtonHeightMult = 0.04
        static let TextfieldWidthMult = 0.8
        static let TextfieldHeight = 40
    }
}

extension Stylesheet {
    
    enum Objects {
        
        enum ImageViews {
            case Clear
            case Opaque
            
            func style(imageView: UIImageView) {
                switch self {
                case .Clear:
                    imageView.backgroundColor = .clear
                    imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
                    imageView.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
                case .Opaque:
                    imageView.backgroundColor = UIColor(red: 0.298, green: 0.278, blue: 0.247, alpha: 1.00)
                    imageView.contentMode = .scaleAspectFit
                }
            }
        }
        
        enum Buttons {
            case Login
            case Link
            case CreateButton
            case ClearButton
            
            func style(button: UIButton) {
                switch self {
                case .Login:
                    button.setTitleColor(Stylesheet.Colors.LightGrey, for: .normal)
                    button.titleLabel?.font = Stylesheet.Fonts.Bold
                    button.backgroundColor = Stylesheet.Colors.Red
                    button.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
                    button.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.Buttons)
                    button.showsTouchWhenHighlighted = true
                case .Link:
                    button.setTitleColor(Stylesheet.Colors.Orange, for: .normal)
                    button.titleLabel?.font = Stylesheet.Fonts.Link
                    button.backgroundColor = .clear
                    button.showsTouchWhenHighlighted = true
                case .CreateButton:
                    button.setTitleColor(Stylesheet.Colors.White, for: .normal)
                    button.titleLabel?.font = Stylesheet.Fonts.Bold
                    button.backgroundColor = Stylesheet.Colors.LightBlue
                    button.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    button.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.Buttons)
                    button.showsTouchWhenHighlighted = false
                case .ClearButton:
                    button.backgroundColor = .clear
                    button.contentMode = .scaleAspectFit
                    button.tintColor = Stylesheet.Colors.Orange
                }
            }
        }
        
        enum Labels {
            case Regular
            case AppName
            case PostCategory
            case PostTitle
            case PostUsername
            
            func style(label: UILabel) {
                switch self {
                case .Regular:
                    label.font = Stylesheet.Fonts.Regular
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .center
                    label.numberOfLines = 0
                case .AppName:
                    label.font = Stylesheet.Fonts.AppName
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .center
                    label.numberOfLines = 0
                case .PostCategory:
                    label.font = Stylesheet.Fonts.Bold
                    label.textColor = Stylesheet.Colors.Red
                    label.backgroundColor = .clear
                    label.textAlignment = .left
                    label.numberOfLines = 1
                case .PostTitle:
                    label.font = Stylesheet.Fonts.PostTitle
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .left
                    label.numberOfLines = 0
                case .PostUsername:
                    label.font = Stylesheet.Fonts.Bold
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .left
                    label.numberOfLines = 1
                    
                }
            }
        }
        
        enum Textviews {
            case Completed
            case Editable
            
            func style(textview: UITextView) {
                switch self {
                case .Completed:
                    textview.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.TextfieldCompleted)
                    textview.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textview.backgroundColor = Stylesheet.Colors.White
                    textview.textAlignment = .natural
                    textview.isEditable = false
                    textview.textColor = Stylesheet.Colors.Dark
                    textview.font = Stylesheet.Fonts.Regular
                    textview.adjustsFontForContentSizeCategory = true
                    textview.isScrollEnabled = true
                case .Editable:
                    textview.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.TextfieldEditable)
                    textview.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textview.backgroundColor = Stylesheet.Colors.White
                    textview.textAlignment = .natural
                    textview.isEditable = true
                    textview.textColor = Stylesheet.Colors.Dark
                    textview.font = Stylesheet.Fonts.Regular
                    textview.adjustsFontForContentSizeCategory = true
                    textview.isScrollEnabled = true
                }
            }
        }
        
        enum Textfields {
            case Address
            case LoginEmail
            case LoginPassword
            
            func style(textfield: UITextField) {
                switch self {
                case .Address:
                    textfield.borderStyle = UITextBorderStyle.bezel
                    textfield.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textfield.backgroundColor = Stylesheet.Colors.White
                    textfield.textAlignment = NSTextAlignment.left
                    textfield.font = Stylesheet.Fonts.TextfieldFont
                    textfield.textColor = Stylesheet.Colors.Dark
                    textfield.adjustsFontSizeToFitWidth = true
                    textfield.autocapitalizationType = .words
                    textfield.autocorrectionType = .no
                    textfield.keyboardType = .asciiCapable
                    textfield.returnKeyType = .default
                    textfield.placeholder = "Optional Address"
                case .LoginEmail:
                    textfield.borderStyle = UITextBorderStyle.bezel
                    textfield.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textfield.backgroundColor = Stylesheet.Colors.White
                    textfield.textAlignment = NSTextAlignment.left
                    textfield.font = Stylesheet.Fonts.TextfieldFont
                    textfield.textColor = Stylesheet.Colors.Dark
                    textfield.adjustsFontSizeToFitWidth = true
                    textfield.autocapitalizationType = .none
                    textfield.autocorrectionType = .no
                    textfield.keyboardType = .emailAddress
                    textfield.returnKeyType = .default
                    textfield.placeholder = "Email Address"
                case .LoginPassword:
                    textfield.borderStyle = UITextBorderStyle.bezel
                    textfield.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textfield.backgroundColor = Stylesheet.Colors.White
                    textfield.textAlignment = NSTextAlignment.left
                    textfield.font = Stylesheet.Fonts.TextfieldFont
                    textfield.textColor = Stylesheet.Colors.Dark
                    textfield.adjustsFontSizeToFitWidth = true
                    textfield.autocapitalizationType = .none
                    textfield.autocorrectionType = .no
                    textfield.keyboardType = .asciiCapable
                    textfield.returnKeyType = .default
                    textfield.placeholder = "Password"
                    textfield.isSecureTextEntry = true
                }
            }
        }
    }
}
