//
//  HomeViewController.swift
//  SudokuSolverPro
//
//  Created by Eshan on 07/08/26.
//

import UIKit

struct DifficultyCellData {
    let title: String
    let subtitle: String
    let iconName: String
}

class HomeViewController: UIViewController {
    
    lazy var localeScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocalizationViewController")
    
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var navBarTitleLabel: UILabel!
    @IBOutlet weak var localeImage: UIImageView!
    @IBOutlet weak var localInitialLabel: UILabel!
    @IBOutlet weak var homeTV: UITableView!
    
    let difficultyLevels: [DifficultyCellData] = [
        DifficultyCellData(
            title: "Easy",
            subtitle: "Relaxed pace",
            iconName: "Difficulty_Easy_Icon"
        ),
        DifficultyCellData(
            title: "Medium",
            subtitle: "Balanced test",
            iconName: "Difficulty_Medium_Icon"
        ),
        DifficultyCellData(
            title: "Hard",
            subtitle: "Tough logic",
            iconName: "Difficulty_Hard_Icon"
        ),
        DifficultyCellData(
            title: "Expert",
            subtitle: "Master class",
            iconName: "Difficulty_Expert_Icon"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.homeBGColor()
        
        customNavBar.backgroundColor = UIColor.clear
        
        navBarTitleLabel.text = "Sudoku Solver Pro"
        navBarTitleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        navBarTitleLabel.textColor = UIColor.black
        
        localeImage.image = UIImage(named: "Locale_Icon")
        
        localInitialLabel.text = "EN"
        localInitialLabel.font = UIFont.medium(13)
        localInitialLabel.textColor = UIColor.localeColor()
        
        
        homeTV.delegate = self
        homeTV.dataSource = self
        homeTV.register(UINib(nibName: "DifficultyTVC", bundle: nil), forCellReuseIdentifier: "DifficultyTVC")
        homeTV.register(UINib(nibName: "NewGameTVC", bundle: nil), forCellReuseIdentifier: "NewGameTVC")
        homeTV.backgroundColor = UIColor.clear
        
    }
    
    @IBAction func localeBtnTapped(_ sender: Any) {
        if let sheet = localeScreen.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        self.present(localeScreen, animated: true)
    }
    
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewGameTVC", for: indexPath) as? NewGameTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell;
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DifficultyTVC", for: indexPath) as? DifficultyTVC else {
                return UITableViewCell()
            }
            cell.bindData(dataArray: difficultyLevels)
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell;
        } else {
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 108.0
        } else if indexPath.row == 1 {
            let count = CGFloat(difficultyLevels.count)
            let baseHeight = 72.0 * count
            let spacingHeight = 16.5 * (count - 1)
            return baseHeight + spacingHeight + 53.0 + 24.0
        } else {
            return 0
        }
    }
    
}
