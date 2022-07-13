//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-13.
//

import UIKit

struct DynamicColor {
    
    private var colors = [ColorTheme : any Color]()
    
    init(_ colors: (theme: ColorTheme, color: any Color)...) {
        for (theme, color) in colors {
            self.colors[theme] = color
        }
    }
    
    func get(for theme: ColorTheme) -> (any Color)? {
        return colors[theme]
    }
    
    mutating func set(for theme: ColorTheme, _ color: any Color) {
        colors[theme] = color
    }
    
    func uiColor() -> UIColor {
        return UIColor { trait in
            let colorForTrait = get(for: .from(trait.userInterfaceStyle))?.uiColor()
            return (colorForTrait ?? colors.first?.value)?.uiColor() ?? UIColor.white
        }
    }
    
}
