//
//  Data+Extension.swift
//  RssApp
//
//  Created by Eugene Kiselev on 23.09.2020.
//

import Foundation

extension Data {
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
