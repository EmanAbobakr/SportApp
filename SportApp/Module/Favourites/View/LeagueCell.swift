//
//  LeagueCell.swift
//  SportApp
//
//  Created by EmyAbobakr on 1/28/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    
    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var LeagueNameText: UITextField!
    
    
    
    @IBAction func youtubeBtn(_ sender: UIButton) {
        print("You clicked the btn")
        //print(youtubeBtn.title(for: .normal))
        //vcDelegation = LeaguesVC()
        vcDelegation.cell(cell: self, didTapBtn: sender)
    }
   
    
    var vcDelegation : customCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
