//
//  TeamsTableViewCell.swift
//  SportApp
//
//  Created by Thoraya Hamdy on 11/17/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var teamsStrImages: [String]!
    
    @IBOutlet var teamsCollectionView : UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsStrImages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCellID", for: indexPath) as! TeamsCollectionViewCell
        cell.configureTeamImageCell(imageStr: teamsStrImages[indexPath.row])
        return cell
    }
    
    
    

}
