//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-06-24.
//

import Foundation

public enum ColorFormatDenominator {
  case One
  case OneHundred
  case TwoFiftyFive

  public var value: Double {
    switch self {
    case .One:
      return 1.0
    case .OneHundred:
      return 100.0
    case .TwoFiftyFive:
      return 255.0
    }
  }
}
