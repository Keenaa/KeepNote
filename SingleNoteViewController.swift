//
//  SingleNoteControllerViewController.swift
//  KeepNote
//
//  Created by Meryl Barantal on 06/12/2016.
//  Copyright © 2016 com.github.keena.shemana. All rights reserved.
//

import UIKit

class SingleNoteViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var noteTitle: UINavigationItem!
    
    @IBOutlet weak var editTitle: UITextField!
    
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var colorPicker: UIPickerView!
    
    var colors: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.colorPicker.delegate = self
        self.colorPicker.dataSource = self
        
        colors = ["Yellow", "Red", "Blue", "Green"]
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
             NoteManager.sharedInstance.createNote(title: editTitle.text!, content: noteText.text, position: 0, color: NoteManager.sharedInstance.currentNote?.color as! UIColor)
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        editTitle.resignFirstResponder()
        return true
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
    
    // The number of columns of data
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count

    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]

    }
    //Catch the selected option
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var currentColor: UIColor
        switch colors[row] {
        case "Yellow":
            currentColor = UIColor.yellow
        case "Red":
            currentColor = UIColor.red
        case "Green":
            currentColor = UIColor.green
        case "Blue":
            currentColor = UIColor.blue
        default:
            currentColor = UIColor.yellow
        }
        NoteManager.sharedInstance.currentNote?.color = currentColor
    }

}
