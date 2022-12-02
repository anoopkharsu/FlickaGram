//
//  CommitTableViewCell.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 28/11/22.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabelView: UILabel!
    @IBOutlet weak var userNameLabelView: UILabel!
    @IBOutlet weak var userImageVIew: UIImageView!
    @IBOutlet weak var timeLabelView: UILabel!
    
    func setup(_ data: CommitsModels.CommitDetails) {
        userImageVIew.layer.cornerRadius = 12.5
        messageLabelView.text = data.message
        userNameLabelView.text = data.committer.name
        
        timeLabelView.text = data.committer.fromattedDate?.timeAgoDisplay()
    }
    
}


extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
