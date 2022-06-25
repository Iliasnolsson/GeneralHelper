//
//  UIImageExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-14.
//

import UIKit

public extension UIImage {
    
    static func systemImage(name: String, color: UIColor, pointSize: CGFloat, weight: UIImage.SymbolWeight = .medium, scale: SymbolScale = .medium) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        return UIImage(systemName: name, withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal).withTintColor(color)
    }
    
    static func systemImage(name: String, pointSize: CGFloat, weight: UIImage.SymbolWeight = .medium, scale: SymbolScale = .medium) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        return UIImage(systemName: name, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate)
    }
    
    static func symbolImage(name: String, pointSize: CGFloat, weight: UIImage.SymbolWeight = .medium, scale: SymbolScale = .medium) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        return UIImage(named: name, in: nil, with: configuration)?.withRenderingMode(.alwaysTemplate)
    }
    
    static func symbolImage(name: String, color: UIColor, pointSize: CGFloat, weight: UIImage.SymbolWeight = .medium, scale: SymbolScale = .medium) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        return UIImage(named: name, in: nil, with: configuration)?.withRenderingMode(.alwaysOriginal).withTintColor(color)
    }
    
    
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
