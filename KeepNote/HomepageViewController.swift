//
//  HomepageViewController.swift
//  KeepNote
//
//  Created by guillaume chieb bouares on 16/11/2016.
//  Copyright © 2016 com.github.keena.shemana. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let reuseIdentifier = "NoteCell" // also enter this string as the cell identifier in the storyboard
    let sharedInstance = NoteManager.sharedInstance
    var homeView: UICollectionView?

    
    @IBAction func addNewNote(_ sender: Any) {
        performSegue(withIdentifier: "NewNote", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         
        let colour = UIColor.red
        let rgbColour = colour.cgColor
        
        let color = UIColor(cgColor: rgbColour)
        */
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NoteManager.sharedInstance.readNotes { (result:Bool) in
            if result {
                self.homeView?.reloadData()
                //collection view reload data
            }else{
                print("Error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (NoteManager.sharedInstance.noteList.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! NoteCollectionViewCell
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if sharedInstance.noteList.count > 0 {
           // cell.noteTitle.text = NoteManager.sharedInstance.noteList?[indexPath.row].title
            // Content
            // Created_at ?
            // etc...
            cell.backgroundColor = UIColor.yellow // make cell more visible in our example project
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        performSegue(withIdentifier: "NewNote", sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The first cell always start expanded with an height of 300
    
            return CGSize(width: collectionView.bounds.size.width, height: 300)
    }

}
