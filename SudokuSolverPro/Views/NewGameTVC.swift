//
//  NewGameTVC.swift
//  SudokuSolverPro
//
//  Created by Eshan on 07/08/26.
//

import UIKit

protocol DifficultyDelegate: AnyObject {
    func didSelectDifficulty(_ difficulty: String)
}

class NewGameTVC: UITableViewCell {
    
    weak var delegate : DifficultyDelegate?

    @IBOutlet weak var newGameLabel: UILabel!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var playBackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playImage.image = UIImage(named: "NewGame_Icon")
        
        newGameLabel.text = "New Game"
        newGameLabel.font = UIFont.semibold(18)
        newGameLabel.textColor = UIColor.white
        
        playBackView.backgroundColor = UIColor.selectedKeyColor()
        playBackView.layer.cornerRadius = 12.0
        playBackView.layer.cornerCurve = .continuous
        
    }
    @IBAction func newGameTapped(_ sender: Any) {
        delegate?.didSelectDifficulty("random")
    }
    
}
