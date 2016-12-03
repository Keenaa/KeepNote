//
//  NoteManager.swift
//  KeepNote
//
//  Created by guillaume chieb bouares on 03/12/2016.
//  Copyright © 2016 com.github.keena.shemana. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class NoteManager {
    
    public static let sharedInstance = NoteManager()
    
    func createNote(id:Int,title:String,content:String,position:Int,color:UIColor) -> Note? {
        if let context =  DataManager.sharedInstance.objectContext {
            let note = Note(context: context)
            note.id = Int32(id)
            note.title = title
            note.content = content
            note.position = Int32(position)
            note.color = color
            note.created_at = Date() as NSDate?
            do {
                try? context.save()
                return note
            } catch {
                print("failure : \(error)")
                return nil
            }
        }
        return nil
    }
    func readNotes() -> [Note] {
        if let context = DataManager.sharedInstance.objectContext {
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            if let notes = try? context.fetch(request) {
                return notes
            }
        }
    }
}
