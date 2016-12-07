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
    fileprivate var longPressGesture: UILongPressGestureRecognizer!

    @IBOutlet var collectionView: UICollectionView!
    
    
    @IBAction func addNewNote(_ sender: Any) {
        performSegue(withIdentifier: "NewNote", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(HomepageViewController.handleLongGesture(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NoteManager.sharedInstance.readNotes { (result:Bool) in
            if result {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }else{
                print("Error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NoteManager.sharedInstance.noteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! NoteCollectionViewCell
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if sharedInstance.noteList.count > 0 {
            cell.titleLabel.text = NoteManager.sharedInstance.noteList[indexPath.row].title
            cell.contentLabel.text = NoteManager.sharedInstance.noteList[indexPath.row].content
            cell.backgroundColor = NoteManager.sharedInstance.noteList[indexPath.row].color as! UIColor?
            // make cell more visible in our example project
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        NoteManager.sharedInstance.currentNote = NoteManager.sharedInstance.noteList[indexPath.row]
        performSegue(withIdentifier: "NewNote", sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The first cell always start expanded with an height of 300
    
            return CGSize(width: collectionView.bounds.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = NoteManager.sharedInstance.noteList.remove(at: sourceIndexPath.item)
        NoteManager.sharedInstance.noteList.insert(temp, at: destinationIndexPath.item)
    }

}
