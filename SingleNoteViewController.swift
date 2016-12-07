//
//  SingleNoteControllerViewController.swift
//  KeepNote
//
//  Created by Meryl Barantal on 06/12/2016.
//  Copyright © 2016 com.github.keena.shemana. All rights reserved.
//

import UIKit
import Social

class SingleNoteViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var noteTitle: UINavigationItem!
    
    @IBOutlet weak var editTitle: UITextField!
    
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var colorPicker: UIPickerView!
    
    @IBOutlet var shareButton: UIBarButtonItem!
    var colors: [String] = []
    var currentColorChoice:UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.colorPicker.delegate = self
        self.colorPicker.dataSource = self
        
        colors = ["Yellow", "Red", "Blue", "Green"]
        if NoteManager.sharedInstance.currentNote != nil {
            shareButton.isEnabled = true
            noteTitle.title = NoteManager.sharedInstance.currentNote?.title
            editTitle.text = NoteManager.sharedInstance.currentNote?.title
            noteText.text = NoteManager.sharedInstance.currentNote?.content
        }else{
            shareButton.isEnabled = false
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
        NoteManager.sharedInstance.currentNote?.color = currentColorChoice
        NoteManager.sharedInstance.updateNote { (error:String?) in
            if error != nil {
                self.dismiss(animated: true, completion: { 
                    
                })
            }
        }
        }else{
             _ = NoteManager.sharedInstance.createNote(title: editTitle.text!, content: noteText.text, position: NoteManager.sharedInstance.noteList.count, color: currentColorChoice!)
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
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
           let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook teszeitazoitbhz")
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
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
        switch colors[row] {
        case "Yellow":
            currentColorChoice = UIColor.yellow
        case "Red":
            currentColorChoice = UIColor.red
        case "Green":
            currentColorChoice = UIColor.green
        case "Blue":
            currentColorChoice = UIColor.blue
        default:
            currentColorChoice = UIColor.yellow
        }
    }

}
