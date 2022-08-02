//
//  UIImageExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-14.
//

import UIKit

// MARK: System Image Initalizers
public extension UIImage {
    
    convenience init?(systemName: String, pointSize: CGFloat) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: pointSize))
    }
    convenience init?(systemName: String, pointSize: CGFloat, weight: UIImage.SymbolWeight) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight))
    }
    convenience init?(systemName: String, pointSize: CGFloat, weight: UIImage.SymbolWeight, scale: UIImage.SymbolScale) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale))
    }
    convenience init?(systemName: String, scale: UIImage.SymbolScale) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(scale: scale))
    }
    convenience init?(systemName: String, textStyle: UIFont.TextStyle) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(textStyle: textStyle))
    }
    convenience init?(systemName: String, textStyle: UIFont.TextStyle, scale: UIImage.SymbolScale) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(textStyle: textStyle, scale: scale))
    }
    convenience init?(systemName: String, weight: UIImage.SymbolWeight) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(weight: weight))
    }
    convenience init?(systemName: String, font: UIFont) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(font: font))
    }
    convenience init?(systemName: String, font: UIFont, scale: UIImage.SymbolScale) {
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(font: font, scale: scale))
    }
    
}

// MARK: Symbol Image Initalizers
public extension UIImage {
    
    convenience init?(symbolName: String) {
        self.init(named: symbolName, in: nil, with: nil)
    }
    
    convenience init?(symbolName: String, pointSize: CGFloat) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(pointSize: pointSize))
    }
    convenience init?(symbolName: String, pointSize: CGFloat, weight: UIImage.SymbolWeight) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight))
    }
    convenience init?(symbolName: String, pointSize: CGFloat, weight: UIImage.SymbolWeight, scale: UIImage.SymbolScale) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale))
    }
    convenience init?(symbolName: String, scale: UIImage.SymbolScale) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(scale: scale))
    }
    convenience init?(symbolName: String, textStyle: UIFont.TextStyle) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(textStyle: textStyle))
    }
    convenience init?(symbolName: String, textStyle: UIFont.TextStyle, scale: UIImage.SymbolScale) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(textStyle: textStyle, scale: scale))
    }
    convenience init?(symbolName: String, weight: UIImage.SymbolWeight) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(weight: weight))
    }
    convenience init?(symbolName: String, font: UIFont) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(font: font))
    }
    convenience init?(symbolName: String, font: UIFont, scale: UIImage.SymbolScale) {
        self.init(
            named: symbolName,
            in: nil,
            with: UIImage.SymbolConfiguration(font: font, scale: scale))
    }
    
}

public extension UIImage {
    
    func resize(to newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image.withRenderingMode(renderingMode)
    }
    
    func crop(rect: CGRect) -> UIImage? {
        var scaledRect = rect
        scaledRect.origin.x *= scale
        scaledRect.origin.y *= scale
        scaledRect.size.width *= scale
        scaledRect.size.height *= scale
        guard let imageRef: CGImage = cgImage?.cropping(to: scaledRect) else {
            return nil
        }
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
}
