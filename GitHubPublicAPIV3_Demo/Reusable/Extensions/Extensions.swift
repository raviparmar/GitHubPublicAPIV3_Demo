//
//  Extensions.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 03/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit


/*
 *
 *    This class is supposed to be used for all the extentions that are created for default swift class/structs
 *
 */




///  ERROR Ext
enum DataParsingError: Error {
    case couldNotParseData
}
extension DataParsingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .couldNotParseData:
            return NSLocalizedString("Could Not Parse Data", comment: "Invalid data")
        }
    }
}



extension UIView {

  // OUTPUT 1
  func addShadow1(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func addShadow2(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}




//class Extensions: NSObject {
//
//}
