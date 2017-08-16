/**
 Cosc345 Asn 2, DeadlinesTableCell.swift
 Purpose: the table cell for deadline UI.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit

class DeadlinesTableCell: UITableViewCell {
    
    
    @IBOutlet weak var deadLineName: UILabel!
    @IBOutlet weak var deadLineDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /* user select deadline records */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
