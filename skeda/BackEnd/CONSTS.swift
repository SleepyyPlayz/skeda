//
//  CONSTS.swift
//  skeda
//
//  Created by 蒋汪正 on 7/13/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import Foundation

struct CONSTS{
    struct Colors{
        static let BrandAzure = "BrandAzure"
        static let BrandLightBlue = "BrandLightBlue"
        static let PseudoWhite = "PseudoWhite"
        static let BrandLightOrange = "BrandLightOrange"
        
        static let BackgroundBlue = "BackgroundBlue"
        static let BackgroundGreen = "BackgroundGreen"
        static let BackgroundTurquoise = "BackgroundTurquoise"
        static let BackgroundGrey = "BackgroundGrey"
        static let BackgroundDeepBlue = "BackgroundDeepBlue"
        static let BackgroundPurple = "BackgroundPurple"
        static let BackgroundOrange = "BackgroundOrange"
        static let BackgroundRed = "BackgroundRed"
        
        static let White = "White"
    }
    struct CloseButtons{
        static let Blue = "CloseButtonBlue"
        static let Green = "CloseButtonGreen"
        static let Turquoise = "CloseButtonTurquoise"
        static let Grey = "CloseButtonGrey"
        static let DeepBlue = "CloseButtonDeepBlue"
        static let Purple = "CloseButtonPurple"
        static let Orange = "CloseButtonOrange"
        static let Red = "CloseButtonRed"
    }
    struct ArrowIcons{
        static let White = "WhiteArrow"
        
        static let Blue = "BlueArrow"
        static let Green = "GreenArrow"
        static let Turquoise = "TurquoiseArrow"
        static let Grey = "GreyArrow"
        static let DeepBlue = "DeepBlueArrow"
        static let Purple = "PurpleArrow"
        static let Orange = "OrangeArrow"
        static let Red = "RedArrow"
    }
    struct TagTypes{
        static let Default = "Default"
        static let UserCreated = "UserCreated"
    }
    
    struct TaskTypes{
        static let Point = "Point"
        static let Line = "Line"
        static let Routine = "Routine"
        static let RoutineLine = "RoutineLine"
    }
    struct SubtaskTypes{
        static let Point = "Point"
        static let Line = "Line"
    }
    
    
    enum VariableNullErrors: Error{
        case indexForEditIsNull
        case noColorFound
    }
}
