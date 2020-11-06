//
//  TableViewCell.swift
//  toDoList
//
//  Created by Mohammed Alshulah on 04/11/2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var toDoName: UILabel!
    @IBOutlet weak var toDoPerson: UILabel!
    @IBOutlet weak var toDoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellContainer.addDropShadow()
        cellContainer.addCornerRadius(radius: 5.0)
       
        
    }
    
    func configureCell(item: Item) {
        self.toDoName.text = item.name
        self.toDoPerson.text = item.toPerson?.name
        
        if let date = item.date {
            //format the time
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = df.string(from:date)
            self.toDoDate.text = now
        } else {
            self.toDoDate.text = "20/05/1995"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
