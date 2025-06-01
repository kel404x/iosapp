

import SwiftUI
import ImageIO

struct Item: Identifiable {
    let id = UUID()
    let url: URL
    let metadata: [String: Any]?

    init(url: URL) {
        self.url = url
        self.metadata = Item.extractMetadata(from: url)
    }

    private static func extractMetadata(from url: URL) -> [String: Any]? {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
              let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any] else {
            return nil
        }

        // Convert CFString keys to regular Swift Strings
        var result: [String: Any] = [:]
        for (key, value) in properties {
            result[key as String] = value
        }
        return result
    }
}


extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.url == rhs.url
    }
}

