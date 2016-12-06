//
//  SingleNoteControllerViewController.swift
//  KeepNote
//
//  Created by Meryl Barantal on 06/12/2016.
//  Copyright © 2016 com.github.keena.shemana. All rights reserved.
//

import UIKit

class SingleNoteViewController: UIViewController {
    @IBOutlet weak var noteTitle: UINavigationItem!
    
    @IBOutlet weak var editTitle: UITextField!
    
    @IBOutlet weak var noteText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NoteManager.sharedInstance.currentNote != nil {
            noteTitle.title = NoteManager.sharedInstance.currentNote?.title
            editTitle.text = NoteManager.sharedInstance.currentNote?.title
            noteText.text = NoteManager.sharedInstance.currentNote?.content
        }else{
            noteTitle.title = "Add New"
            noteText.text = ""
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveData(_ sender: Any) {
        if NoteManager.sharedInstance.currentNote != nil {
        NoteManager.sharedInstance.currentNote?.content = noteText.text
        NoteManager.sharedInstance.currentNote?.title = editTitle.text
        NoteManager.sharedInstance.updateNote { (error:String?) in
            if error != nil {
                self.dismiss(animated: true, completion: { 
                    
                })
            }
        }
        }else{
             NoteManager.sharedInstance.createNote(title: editTitle.text!, content: noteText.text, position: 0, color: UIColor.yellow)
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        NoteManager.sharedInstance.remove(note: NoteManager.sharedInstance.currentNote!)
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func options(_ sender: Any) {
        
    }


}
