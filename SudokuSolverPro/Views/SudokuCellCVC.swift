//
//  SudokuCellCVC.swift
//  SudokuSolverPro
//
//  Created by Eshan on 27/07/26.
//

import UIKit

class SudokuCellCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var leadingOuterView: UIView!
    @IBOutlet weak var leadingInnerView: UIView!
    @IBOutlet weak var topOuterView: UIView!
    @IBOutlet weak var topInnerView: UIView!
    @IBOutlet weak var bottomInnerView: UIView!
    @IBOutlet weak var bottomOuterView: UIView!
    @IBOutlet weak var trailingInnerView: UIView!
    @IBOutlet weak var trailingOuterView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.leadingOuterView.backgroundColor = .black
        self.leadingInnerView.backgroundColor = .black
        self.topOuterView.backgroundColor = .black
        self.topInnerView.backgroundColor = .black
        self.bottomInnerView.backgroundColor = .black
        self.bottomOuterView.backgroundColor = .black
        self.trailingInnerView.backgroundColor = .black
        self.trailingOuterView.backgroundColor = .black
        
        self.textLabel.textColor = UIColor.textColor()
        
        self.textLabel.font = UIFont.semibold(22)
        
    }

}
