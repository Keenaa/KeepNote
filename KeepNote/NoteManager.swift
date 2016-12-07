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
    
    public var currentNote:Note?
    
    public var noteList:[Note] = []
    
    func createNote(title:String,content:String,position:Int,color:UIColor) -> Note? {
        if let context =  DataManager.sharedInstance.objectContext {
            let note = Note(context: context)
            note.title = title
            note.content = content
            note.position = Int32(position)
            note.color = color
            note.created_at = Date() as NSDate?
            do {
                try context.save()
            } catch let error as NSError{
                print("failure : \(error)")
                return nil
            }
            return note
        }
        return nil
    }
    /*
     *  Return true in handler if noteList have been populate
     */
    func readNotes(handler: (_ result:Bool) -> Void){
        if let context = DataManager.sharedInstance.objectContext {
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            if let notes = try? context.fetch(request) {
                self.noteList = notes
                handler(true)
            } else {
                handler(false)
            }
        } else {
            handler(false)
        }
    }
    private func readNoteById(context: NSManagedObjectContext,id:NSManagedObjectID) -> Note {
        return context.object(with: id) as! Note
    }
    /*
     * Update the current object
     */
    func updateNote(handler: (_ error:String?) -> Void) -> Void {
        if let context = DataManager.sharedInstance.objectContext {
            let note = readNoteById(context: context, id: (currentNote?.objectID)!)
            note.title = currentNote?.title
            
            note.content = currentNote?.content
            note.position = Int32((currentNote?.position)!)
            note.color = currentNote?.color
            do{
                try context.save()
                handler(nil)
            } catch let error as NSError {
                handler(error.localizedDescription)
            }
        }
        handler("CONTEXT NOT FOUND")
    }
    func remove(note:Note) -> Void {
        if let context = DataManager.sharedInstance.objectContext {
            let note = readNoteById(context: context, id: note.objectID)
            context.delete(note)
        }
    }
}
