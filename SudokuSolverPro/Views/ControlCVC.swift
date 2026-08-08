//
//  ControlCVC.swift
//  SudokuSolverPro
//
//  Created by Eshan on 06/08/26.
//

import UIKit

class ControlCVC: UICollectionViewCell {
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var resetImage: UIImageView!
    @IBOutlet weak var undoImage: UIImageView!
    @IBOutlet weak var eraseImage: UIImageView!
    @IBOutlet weak var solveImage: UIImageView!
    @IBOutlet weak var widthCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.font = UIFont.regular(12.0)
        self.title.textColor = UIColor.black
        self.overlayView.layer.cornerRadius = self.overlayView.frame.height / 2.0
        self.overlayView.backgroundColor = UIColor.defaultKeyColor()
    }
    
    func bindDataForReset() {
        self.title.text = "Reset"
        self.resetImage.image = UIImage(named: "Reset_Icon")
    }
    
    func bindDataForUndo() {
        self.title.text = "Undo"
        self.undoImage.image = UIImage(named: "Undo_Icon")
    }
    
    func bindDataForErase() {
        self.title.text = "Erase"
        self.eraseImage.image = UIImage(named: "Erase_Icon")
    }
    
    func bindDataForSolve() {
        self.title.text = "Solve"
        self.solveImage.image = UIImage(named: "Solve_Icon")
    }

}
