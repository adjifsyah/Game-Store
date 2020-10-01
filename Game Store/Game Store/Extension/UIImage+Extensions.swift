//
//  UIImage+Extensions.swift
//  Game Store
//
//  Created by Adji Firmansyah on 30/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import UIKit

extension UIImage {
    var toJpegCompressedData: Data? {
        return jpegData(compressionQuality: 0.0)
    }
    
    var placeholderImage: UIImage {
        return UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .regular))!
    }
}
