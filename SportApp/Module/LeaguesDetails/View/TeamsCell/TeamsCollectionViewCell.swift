//
//  TeamsCollectionViewCell.swift
//  SportApp
//
//  Created by Thoraya Hamdy on 11/17/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import UIKit
import Kingfisher

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    
    func configureTeamImageCell(imageStr: String) {
        let imageURL = URL(string: imageStr)
        teamImage.kf.setImage(with: imageURL)
    }
}
