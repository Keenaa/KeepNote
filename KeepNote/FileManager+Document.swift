//
//  FileManager+Document.swift
//  KeepNote
//
//  Created by guillaume chieb bouares on 03/12/2016.
//  Copyright © 2016 com.github.keena.shemana. All rights reserved.
//

import Foundation
import CoreData

extension FileManager {
    
    public static func documentURL() -> URL? {
        return documentURL(childpath: nil)
    }
    
    public static func documentURL(childpath: String?) -> URL? {
        if let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            if let path = childpath {
                return docURL.appendingPathComponent(path)
            }
            return docURL
        }
        return nil
    }
}
