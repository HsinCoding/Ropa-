//
//  WardrobeDetailsCollectionViewController.swift
//  Ropa
//
//  Created by Chen Hsin on 2018/6/25.
//  Copyright © 2018年 Chen Hsin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

private let reuseIdentifier = "Cell"

class WardrobeDetailsCollectionViewController: UICollectionViewController{

    var fileUploadDic: [String:Any]?
    
    var clothing: [Clothes] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let databaseRef = Database.database().reference().child("clothes")
        databaseRef.observe(.value) { (snapshot) in
            if let uploadDataDic = snapshot.value as? [String:Any] {
                
                self.fileUploadDic = uploadDataDic
                self.collectionView?.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataDic = fileUploadDic {
            return dataDic.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ClothesCollectionViewCell
        
        if let dataDic = fileUploadDic {
            let keyArray = Array(dataDic.keys)
            if let imageUrlString = dataDic[keyArray[indexPath.row]] as? String {
                if let imageUrl = URL(string: imageUrlString) {
                    
                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            
                            print("Download Image Task Fail: \(error!.localizedDescription)")
                        }
                        else if let imageData = data {
                            
                            
                            
                            
                            DispatchQueue.main.async {
                                
                                cell.imageView.image = UIImage(data: imageData)
                            }
                        }
                        
                    }).resume()
                }
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
