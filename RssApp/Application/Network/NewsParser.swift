//
//  NewsParser.swift
//  RssApp
//
//  Created by Eugene Kiselev on 23.09.2020.
//

import Foundation

// download xml from a server
// parse xml to foundation objects
// call back
class NewsParser: NSObject, XMLParserDelegate {
    
    private var rssNews = [News]()
    // save key
    private var currentElement = ""
    private var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            currentDescription = currentDescription.description.html2String
        }
    }
    private var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    // stop parse
    private var parserCompletionHandler: (([News]) -> ())?
    
    func parseNews(url: String, completionHandler: (([News]) -> ())?) {
        
        parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            // parse our xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
    }
    
    // MARK: XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title" : currentTitle += string
        case "description" : currentDescription += string
        case "pubDate" : currentPubDate += string
        default : break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            
            let rssNews = News(nameNewsTitle: currentTitle, dateNewsTitle: currentPubDate, contentNews: currentDescription)
            self.rssNews.append(rssNews)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssNews)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
