//
//  TabbarVC.swift
//  SportApp
//
//  Created by EmyAbobakr on 1/28/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeProtocol
{
    func stopAnimator()
    func reloadCollectionData()
}

struct ResultView
{
    var name: String
    var imageURL : String
}

class HomeVC: UIViewController,HomeProtocol {
    
    @IBOutlet weak var myHomeCollection: UICollectionView!
    let indicator = UIActivityIndicatorView(style: .large)
    var myPresenter = HomePresenter()
    var resultView :[ResultView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationItem.title = "Sports"
        //self.tabBarItem.image = UIImage(named: "Ball25.jpeg")
        
        setupCollectionView()
        //myPresenter.getSports()
        animator()
        getData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedItemNum = myHomeCollection.indexPathsForSelectedItems![0][1]
        print(resultView[selectedItemNum].name)
        myPresenter.setSportName(sportName: resultView[selectedItemNum].name)
        let _ = segue.destination as! LeaguesVC
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
    func animator()
    {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
            
    }
    func configurePresenter()
    {
        
        
    }
    func getData()
    {
        myPresenter.attachView(view: self)
        myPresenter.getSports()
    }
    func stopAnimator(){
        
        indicator.stopAnimating()
    }
    
    func reloadCollectionData(){
        
        resultView = myPresenter.sportsResult.map({
            (item) -> ResultView in
            //print(item.strSport!)
            return ResultView(name: item.strSport!, imageURL: item.strSportThumb!)
        })
        myHomeCollection.reloadData()
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}



extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of sports
        return resultView?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! HomeCollectionCell
        
        cell.cellText.text = resultView[indexPath.row].name
        
        let url = URL(string: resultView[indexPath.row].imageURL)
        
        //cell.cellImage.kf.setImage(with: url)
        //-------------
        if let data = try? Data(contentsOf: url!) {
            let image: UIImage = UIImage(data: data)!
            
            cell.cellImage.image = self.resizeImage(image: image , targetSize: CGSize(width: view.frame.size.width/2 - 2, height: view.frame.size.height/4 - 4))
            
        }
       
        //-----------
        //cell.cellText.backgroundColor = UIColor(white: 1, alpha: 0.4)
        
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width/2 - 2 , height: view.frame.size.height/4 - 4 )
        
        
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    */


    
    
}
