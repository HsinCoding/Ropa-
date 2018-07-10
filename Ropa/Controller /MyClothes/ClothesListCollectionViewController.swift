//
//  ClothesListCollectionViewController.swift
//  Ropa
//
//  Created by Chen Hsin on 2018/7/10.
//  Copyright © 2018年 Chen Hsin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

private let reuseIdentifier = "Cell"

class ClothesListCollectionViewController: UICollectionViewController{
    
    var fileUploadDic: [String:Any]?
    
    var clothing: [Clothes] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let filename = NSUUID().uuidString

        let databaseRef = Database.database().reference().child("clothes").child(uid).child("\(filename)")
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
            print("yesssss",dataDic.count)
            return dataDic.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ClothesCollectionViewCell
        
        if let dataDic = fileUploadDic {
            if let uidDic = dataDic["uid"] as? [String:Any] {
                print("cccc",uidDic)
                if let color = uidDic["color"] as? String {
                    if let date = uidDic["date"] as? String {
                        if let price = uidDic["price"] as? String {
                            if let brand = uidDic["brand"] as? String {
                                if let image = uidDic["ImageUrl"] as? String {
                                    
                                    if let imageUrl = URL(string: image) {
                                        
                                        URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                                            if error != nil {
                                                
                                                print("Download Image Task Fail: \(error!.localizedDescription)")
                                            }
                                            else if let imageData = data {
                                                
                                                print("sucesswowowowo",data)
                                                
                                                DispatchQueue.main.async {
                                                    
                                                    cell.imageView.image = UIImage(data: imageData)
                                                    cell.brandLabel.text = brand
                                                    cell.priceLabel.text = price
                                                    cell.dateLabel.text = date
                                                    cell.colorLabel.text = color
                                                    
                                                }
                                            }
                                            
                                        }).resume()
                                    }
                                    
                                    
                                }
                                else {
                                    //error handing imageUrl as? String
                                    print("error 1")
                                }
                            }
                            else {
                                //error handing brand as? String
                                print("error 2")
                            }
                        }
                        else {
                            //error handing price as? Int
                            print("error 3")
                        }
                        
                    }else {
                        //error handing date as? String
                        print("error 4")
                    }
                    
                    
                    
                }else{
                    //error handing color as? String
                    print("error 5")
                }
                
            }else {
                //error handing dataDic as? [String:Any]
                print("error 6")
            }
        }
        return cell
    }
    
    
    func manager(_ manager: ClothesManager, didfetch Clothes:[Clothes]){
        
        self.clothing = Clothes
        
        
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let clothesDetailsViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ClothesDetailsViewController") as! ClothesDetailsViewController
        let cloth = clothing[indexPath.row]
        print("ggggg",cloth.brand)
        clothesDetailsViewController.brandLabel.text = cloth.brand
        clothesDetailsViewController.dateLabel.text = cloth.date
        clothesDetailsViewController.prieceLabel.text = String(cloth.price)
        clothesDetailsViewController.colorLabel.text = cloth.color
        
        
        performSegue(withIdentifier: "gotocolthesdetail ", sender: nil)
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
