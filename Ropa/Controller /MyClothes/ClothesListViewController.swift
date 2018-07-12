//
//  ClothesListViewController.swift
//  Ropa
//
//  Created by Chen Hsin on 2018/7/12.
//  Copyright © 2018年 Chen Hsin. All rights reserved.
//

import UIKit

class ClothesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ClotheseManagerDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func manager(_ manager: ClothesManager, didfetch Clothing: [Clothes]) {
        <#code#>
    }
    
    func manager(_ manager: ClothesManager, didFaithWith error: Error) {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
