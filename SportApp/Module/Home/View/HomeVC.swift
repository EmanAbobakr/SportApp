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
        //title = "Sports"
        setupCollectionView()
        myPresenter.getSports()
        animator()
        getData()
        
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
    func stopAnimator()
    {
        indicator.stopAnimating()
    }
    func reloadCollectionData()
    {
        
        resultView = myPresenter.sportsResult.map({
            (item) -> ResultView in
            //print(item.strSport!)
            return ResultView(name: item.strSport!, imageURL: item.strSportThumb!)
        })
        myHomeCollection.reloadData()
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
        /*
        cell.cellText.text = "Hello"
        cell.cellImage.image = UIImage(named: "f.jpg")
        */
        cell.cellText.text = resultView[indexPath.row].name
        let url = URL(string: resultView[indexPath.row].imageURL)
        cell.cellImage.kf.setImage(with: url)

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //print(UIScreen.main.bounds.height)
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3)
        
        
    }
    


    
    
}
