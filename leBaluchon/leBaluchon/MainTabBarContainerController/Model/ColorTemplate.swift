//
//  ColorTemplate.swift
//  leBaluchon
//
//  Created by Mathieu Janneau on 18/04/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//
import UIKit

// Can’t use the shorthand syntax for UIColor raw values

enum ColorTemplate {
  case green
  case red
}

// But it’s no problem with manual RawRepresentable conformance
extension ColorTemplate: RawRepresentable {
  typealias RawValue = UIColor

  init?(rawValue: RawValue) {
    switch rawValue {
    case #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1): self = .green
    case #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1): self = .red
    default: return nil
    }
  }

  var rawValue: RawValue {
    switch self {
    case .red: return #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4078431373, alpha: 1)
    case .green: return #colorLiteral(red: 0.2588235294, green: 0.8039215686, blue: 0.768627451, alpha: 1)

    }
  }
}
