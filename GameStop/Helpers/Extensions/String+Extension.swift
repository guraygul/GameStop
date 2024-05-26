//
//  String+Extension.swift
//  GameStop
//
//  Created by Güray Gül on 25.05.2024.
//

import Foundation

extension String {
    func extractEnglishDescription() -> String {
        let sections = self.components(separatedBy: "<p>Español")
        guard let englishSection = sections.first else { return "Description not available" }
        
        var cleanString = englishSection.replacingOccurrences(of: "<br />", with: "\n")
        cleanString = cleanString.replacingOccurrences(of: "<[^>]+>", with: "",
                                                       options: .regularExpression, range: nil)
        cleanString = cleanString.replacingOccurrences(of: "&#39;", with: "'")
        return cleanString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
