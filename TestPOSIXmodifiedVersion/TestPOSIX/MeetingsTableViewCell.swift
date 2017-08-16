/**
 Cosc345 Asn 2, MeetingsTableViewCell.swift
 Purpose: Each cell inside MeetingsViewController.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit

class MeetingsTableViewCell: UITableViewCell {

    @IBAction func reminderSwitch(_ sender: Any) {
    }
    
    @IBOutlet weak var meetingLabel: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    /*
     when user select the cell
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
