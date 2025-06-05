//
//  extensions.swift
//  microtransitions
//
//  Created by Rajayogan on 05/06/25.
//

import Foundation
import SwiftUI

//Font helper extension
extension Font {
    static func montserrat(fontStyle: Font.TextStyle = .body, fontWeight: Weight = .regular, fontSize: CGFloat = 16) -> Font {
        return Font.custom(montserratfont(weight: fontWeight).rawValue, size: fontSize)
    }
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 34
        case .title: return 30
        case .title2: return 22
        case .title3: return 20
        case .headline: return 18
        case .body: return 16
        case .callout: return 15
        case .subheadline: return 14
        case .footnote: return 13
        case .caption: return 12
        case .caption2: return 11
        @unknown default: return 8
        }
    }
}

enum montserratfont: String {
    case regular = "Montserrat-Regular"
    case bold = "Montserrat-Bold"
    case light = "Montserrat-Light"
    case medium = "Montserrat-Medium"
    
    init(weight: Font.Weight) {
        switch weight {
        case .regular:
            self = .regular
        case .bold:
            self = .bold
        case .light:
            self = .light
        case .medium:
            self = .medium
        default:
            self = .regular
        }
    }
}
