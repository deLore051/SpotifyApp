//
//  Extensions.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 29.7.21..
//

import UIKit

extension UIView {
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        return dateFormater
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormantter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

/// Extension that we use to formate the date we get from the response of an API call, and we present it in album header section 
extension String {
    static func formatedDate(with string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else { return string }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}
