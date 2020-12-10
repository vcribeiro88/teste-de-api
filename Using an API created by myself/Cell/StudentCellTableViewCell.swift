//
//  StudentCellTableViewCell.swift
//  Using an API created by myself
//
//  Created by Gonzalo Ivan Santos Portales on 08/12/20.
//

import UIKit

class StudentCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(data : AcademyStudentLiveCode) {
        self.nameLabel.text = data.name
        self.occupationLabel.text = data.occupation
    }
}
