//
//  ImageView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-10.
//

import UIKit

public class ImageView: UIImageView {
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

