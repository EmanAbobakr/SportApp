//
//  TabbarVC.swift
//  SportApp
//
//  Created by EmyAbobakr on 1/28/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var myHomeCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //title = "Sports"
        setupCollectionView()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setupCollectionView()
    {
        myHomeCollection.delegate = self
        myHomeCollection.dataSource = self
        //myHomeCollection.flo
    }

}



extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of sports
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! HomeCollectionCell
        cell.cellText.text = "Hello"
        cell.cellImage.image = UIImage(named: "f.jpg")
        

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //print(UIScreen.main.bounds.height)
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3)
        
        
    }
    


    
    
}
