//
//  StringProtocol+Extension.swift
//  RssApp
//
//  Created by Eugene Kiselev on 23.09.2020.
//

import Foundation

extension StringProtocol {
    
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
