//
//  CongratulationsViewController.swift
//  SudokuSolverPro
//
//  Created by Eshan on 08/08/26.
//

import UIKit

class CongratulationsViewController: UIViewController {
    
    var showTime : Bool = true
    
    var selectedDificultyLevel : String = "Random"
    var timeValue : String = "12:34"

    @IBOutlet weak var statView: UIView!
    @IBOutlet weak var congragulationLabel: UILabel!
    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var playBackView: UIView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeBackView: UIView!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var priceImage: UIImageView!

    @IBOutlet weak var timeViewWidthCons: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var levelTitleLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    @IBOutlet weak var selectedLevelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congragulationLabel.text = "Congratulations!"
        congragulationLabel.font = UIFont.bold(28)
        congragulationLabel.textColor = UIColor.textColor()

        crossBtn .setImage(UIImage(named: "Cross_Btn_Image"), for: .normal)
        
        playImage.image = UIImage(named: "NewGame_Icon")
        
        priceImage.image = UIImage(named: "Congragulation_Illustration")
        
        playLabel.text = "New Game"
        playLabel.font = UIFont.semibold(18)
        playLabel.textColor = UIColor.white
        
        playBackView.backgroundColor = UIColor.selectedKeyColor()
        playBackView.layer.cornerRadius = 12.0
        playBackView.layer.cornerCurve = .continuous
        
        homeImage.image = UIImage(named: "Congragulation_Home_Icon")
        
        homeLabel.text = "Back to Home"
        homeLabel.font = UIFont.medium(17)
        homeLabel.textColor = UIColor.textColor()
        
        homeBackView.backgroundColor = UIColor.homeBGColor()
        homeBackView.layer.cornerRadius = 12.0
        homeBackView.layer.cornerCurve = .continuous
        
        statView.layer.borderColor = UIColor.homeBGColor().cgColor
        statView.layer.borderWidth = 1.0
        statView.layer.cornerRadius = 12.0
        statView.layer.cornerCurve = .continuous
        
        if !showTime {
            self.timeViewWidthCons.constant = 0
        }
        
        self.lineView.backgroundColor = UIColor.homeBGColor()
        
        timeTitleLabel.text = "TIME"
        timeTitleLabel.font = UIFont.semibold(13)
        timeTitleLabel.textColor = UIColor.stateTitleColor()
        
        timeValueLabel.text = timeValue
        timeValueLabel.font = UIFont.semibold(22)
        timeValueLabel.textColor = UIColor.textColor()
        
        levelTitleLabel.text = "LEVEL"
        levelTitleLabel.font = UIFont.semibold(13)
        levelTitleLabel.textColor = UIColor.stateTitleColor()
        
        selectedLevelLabel.text = selectedDificultyLevel
        selectedLevelLabel.font = UIFont.semibold(22)
        selectedLevelLabel.textColor = UIColor.textColor()
        
    }
    
    @IBAction func crossBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func homeBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func newGameBtnTapped(_ sender: Any) {
        
    }
    
    
}
