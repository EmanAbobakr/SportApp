//
//  TeamDetailsVC.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/6/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import UIKit

class TeamDetailsVC: UIViewController {
    var team: Team!
    let myPresenter = RouterTeamDetails.presenter
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getTeam()
        
        
    }
    

    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func getTeam() {
        team = myPresenter.selectedTeam
        print(team.strTeam ?? "")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
