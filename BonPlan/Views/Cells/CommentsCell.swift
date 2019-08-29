//
//  CommentsCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 26/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell ,UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
            
            cell.userName.text = "Moi"
            cell.commentText.text = "great"
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
            return cell
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avis: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
