//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-13.
//

import UIKit

public struct DynamicColor: Color  {
    
    private var colors = [ColorTheme : any Color]()
    
    public init(_ colors: Item...) {
        for item in colors {
            self.colors[item.colorTheme] = item.color
        }
    }
    
    public static func initalize(rgba: RGBA) -> DynamicColor {
        return DynamicColor(
            .light(rgba))
    }
    
    public func rgba() -> RGBA {
        return get(for: .current ?? .light)?.rgba() ?? .black
    }
    
    public struct Item {
        
        fileprivate let colorTheme: ColorTheme
        fileprivate let color: any Color
        
        private init(colorTheme: ColorTheme, color: any Color) {
            self.colorTheme = colorTheme
            self.color = color
        }
        
        public static func dark(_ color: any Color) -> Item {
            return .init(colorTheme: .dark, color: color)
        }
        
        public static func dark(_ present: ColorPresent) -> Item {
            return .init(colorTheme: .dark, color: present.rgba())
        }
        
        public static func light(_ color: any Color) -> Item {
            return .init(colorTheme: .light, color: color)
        }
        
        public static func light(_ present: ColorPresent) -> Item {
            return .init(colorTheme: .light, color: present.rgba())
        }
    }
    
}

public extension DynamicColor {
    
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
