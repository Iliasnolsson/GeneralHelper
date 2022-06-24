//
//  CGFloatExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-12.
//

import CoreGraphics

extension Array where Element == CGFloat {
    
    /// - Parameter forPercentage: Total value is retained, Value in range of 0...1.  0 makes no changes, 1 makes all to the same value
    func withSimilarity(forPercentage percentage: CGFloat) -> [CGFloat] {
        let target = 1 / self.count.cgFloat
        let discrepency = 1 - percentage
        return self.map {(($0 - target) * discrepency) + target}
    }
    
}

extension CGFloat {
    
    func inverseScale() -> CGFloat {
        return 1 / self
    }
    
    func minMax(relativeTo otherFloat: CGFloat) -> (min: CGFloat, max: CGFloat) {
        if self > otherFloat {
            return (otherFloat, self)
        }
        return (self, otherFloat)
    }
    
    func string(withDecimals decimals: Int) -> String {
        let maxDecimals = numberOfDecimals()
        if maxDecimals == 0 {
            return Int(self).description
        }
        return String(format: "%.\( maxDecimals > decimals ? decimals : maxDecimals)f", Double(self))
    }
    
    func stringSecondsToHoursMinutesSeconds() -> String {
        let minutesTotal = self / 60
        let hours: Double = Double(Int(minutesTotal/60))
        let minutes = Double(Int(minutesTotal - (hours * 60)))
        let seconds = (minutesTotal - minutes - (hours * 60)) * 60
        let strings = [hours, minutes, seconds].map({(Int($0))}).map({$0 >= 10 ? String($0) : "0\($0)"})
        return "\(strings[0]):\(strings[1]):\(strings[2])"
    }
    
    func numberOfDecimals() -> Int {
        let asString = self.description
        var decimalsCounted = 0
        if let commaIndex = asString.firstIndex(of: ".") {
            let stringAfterComma = asString.substring(fromIndex: commaIndex.utf16Offset(in: asString) + 1)
            for character in stringAfterComma {
                if character == "0" {break}
                decimalsCounted += 1
            }
        }
        return decimalsCounted
    }
    
    func pixels2xToPoints() -> CGFloat {
        return self / 2
    }
    
    func pointsToPixels2x() -> CGFloat {
        return self * 2
    }
    
    func pointsToInches() -> CGFloat {
        return self * 72
    }
    
    func transistion(to toFloat: CGFloat, percentage: CGFloat) -> CGFloat {
        return self + ((toFloat - self) * percentage)
    }
    
}

extension CGFloat {
    
    func applyResistance(naturalCenterValue: CGFloat, maxIncreaseDecrease: CGFloat) -> CGFloat {
        let valueRelativeToCenter = naturalCenterValue - self
        return naturalCenterValue + valueRelativeToCenter.rubberContain(-maxIncreaseDecrease...maxIncreaseDecrease)
    }
    
    func rubberContain(_ inside: ClosedRange<CGFloat>, percentage: CGFloat) -> CGFloat {
        let lenght = abs(inside.upperBound) * percentage
        if self < 0 {
            let positiveFloat = abs(self)
            let a = abs(inside.lowerBound)
            let b = log10(positiveFloat / lenght + 1)
            return -(a * b)
        }
        let a = abs(inside.upperBound)
        let b = log10(self / lenght + 1)
        return a * b
    }
    
    func rubberContain(_ inside: ClosedRange<CGFloat>) -> CGFloat {
        let lenght = abs(inside.upperBound) * 0.9
        if self < 0 {
            let positiveFloat = abs(self)
            let a = abs(inside.lowerBound)
            let b = log10(positiveFloat / lenght + 1)
            return -(a * b)
        }
        let a = abs(inside.upperBound)
        let b = log10(self / lenght + 1)
        return a * b
    }
    
    func resist(byThreshold threshold: CGFloat, lenght: CGFloat) -> CGFloat {
        let positiveFloat = abs(self)
        let b = log10(positiveFloat / lenght + 1)
        let dampend = threshold * b
        return self < 0 ? -dampend : dampend
    }
    
    func round(nearest: CGFloat) -> CGFloat {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}

extension CGFloat {
  
  func isInRangeOrEqual(_ from: CGFloat, _ to: CGFloat) -> Bool {
    return (from <= self && self <= to)
  }
  
  func isInRange(_ from: CGFloat, _ to: CGFloat) -> Bool {
    return (from < self && self < to)
  }
  
  var squared: CGFloat {
    return self * self
  }
  
  var cubed: CGFloat {
    return self * self * self
  }
  
  var cubicRoot: CGFloat {
    return CGFloat(pow(Double(self), 1.0 / 3.0))
  }
  
  fileprivate static func SolveQuadratic(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat) -> CGFloat {
    var result = (-b + sqrt(b.squared - 4 * a * c)) / (2 * a);
    guard !result.isInRangeOrEqual(0, 1) else {
      return result
    }
    
    result = (-b - sqrt(b.squared - 4 * a * c)) / (2 * a);
    guard !result.isInRangeOrEqual(0, 1) else {
      return result
    }
    
    return -1;
  }
  
  fileprivate static func SolveCubic(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat, _ d: CGFloat) -> CGFloat {
    if (a == 0) {
      return SolveQuadratic(b, c, d)
    }
    if (d == 0) {
      return 0
    }
    let a = a
    var b = b
    var c = c
    var d = d
    b /= a
    c /= a
    d /= a
    var q = (3.0 * c - b.squared) / 9.0
    let r = (-27.0 * d + b * (9.0 * c - 2.0 * b.squared)) / 54.0
    let disc = q.cubed + r.squared
    let term1 = b / 3.0
    
    if (disc > 0) {
      var s = r + sqrt(disc)
      s = (s < 0) ? -((-s).cubicRoot) : s.cubicRoot
      var t = r - sqrt(disc)
      t = (t < 0) ? -((-t).cubicRoot) : t.cubicRoot
      
      let result = -term1 + s + t;
      if result.isInRangeOrEqual(0, 1) {
        return result
      }
    } else if (disc == 0) {
      let r13 = (r < 0) ? -((-r).cubicRoot) : r.cubicRoot;
      
      var result = -term1 + 2.0 * r13;
      if result.isInRangeOrEqual(0, 1) {
        return result
      }
      
      result = -(r13 + term1);
      if result.isInRangeOrEqual(0, 1) {
        return result
      }
      
    } else {
      q = -q;
      var dum1 = q * q * q;
      dum1 = acos(r / sqrt(dum1));
      let r13 = 2.0 * sqrt(q);
      
      var result = -term1 + r13 * cos(dum1 / 3.0);
      if result.isInRangeOrEqual(0, 1) {
        return result
      }
      result = -term1 + r13 * cos((dum1 + 2.0 * .pi) / 3.0);
      if result.isInRangeOrEqual(0, 1) {
        return result
      }
      result = -term1 + r13 * cos((dum1 + 4.0 * .pi) / 3.0);
      if result.isInRangeOrEqual(0, 1) {
        return result
      }
    }
    
    return -1;
  }
  
  func cubicBezierInterpolate(_ P0: CGPoint, _ P1: CGPoint, _ P2: CGPoint, _ P3: CGPoint) -> CGFloat {
    var t: CGFloat
    if (self == P0.x) {
      // Handle corner cases explicitly to prevent rounding errors
      t = 0
    } else if (self == P3.x) {
      t = 1
    } else {
      // Calculate t
      let a = -P0.x + 3 * P1.x - 3 * P2.x + P3.x;
      let b = 3 * P0.x - 6 * P1.x + 3 * P2.x;
      let c = -3 * P0.x + 3 * P1.x;
      let d = P0.x - self;
      let tTemp = CGFloat.SolveCubic(a, b, c, d);
      if (tTemp == -1) {
        return -1;
      }
      t = tTemp
    }
    
    // Calculate y from t
    return (1 - t).cubed * P0.y + 3 * t * (1 - t).squared * P1.y + 3 * t.squared * (1 - t) * P2.y + t.cubed * P3.y;
  }
  
  func cubicBezier(_ t: CGFloat, _ c1: CGFloat, _ c2: CGFloat, _ end: CGFloat) -> CGFloat {
    let t_ = (1.0 - t)
    let tt_ = t_ * t_
    let ttt_ = t_ * t_ * t_
    let tt = t * t
    let ttt = t * t * t
    
    return self * ttt_
      + 3.0 *  c1 * tt_ * t
      + 3.0 *  c2 * t_ * tt
      + end * ttt;
  }
  
}
