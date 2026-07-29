//
//  ViewController.swift
//  SudokuSolverPro
//
//  Created by Eshan on 27/07/26.
//

import UIKit

class ViewController: UIViewController {
    
    let board: [[Int]] = SudokuBoardDataSource.getSudoku()
    var issueFlag : Bool = false
    var selectedIndex : Int = -1
    var selectedGridIndices: [Int] = []
    
    @IBOutlet weak var keyboardCVHeightAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var keyboardCollectionView: UICollectionView!
    @IBOutlet weak var sudokuBackView: UIView!
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sudokuCollectionView.register(UINib(nibName: "SudokuCellCVC", bundle: nil), forCellWithReuseIdentifier: "SudokuCellCVC")
        sudokuCollectionView.delegate = self
        sudokuCollectionView.dataSource = self
        sudokuBackView.backgroundColor = UIColor.outerBoundary()
        sudokuCollectionView.backgroundColor = UIColor.innerBoundary()
        sudokuCollectionView.tag = 1001
        
        keyboardCollectionView.register(UINib(nibName: "SudokuKeysCVC", bundle: nil), forCellWithReuseIdentifier: "SudokuKeysCVC")
        keyboardCollectionView.dataSource = self
        keyboardCollectionView.delegate = self
        keyboardCollectionView.backgroundColor = UIColor.clear
        keyboardCollectionView.tag = 1002
        
        let cvWidth = self.view.bounds.size.width - 36.0 * 2
        
        let numberOfCells = 3
        let spacing: CGFloat = 12.0
        let cells = CGFloat(numberOfCells)
        let cellWidth = (cvWidth - ((cells - 1) * spacing)) / cells
        let cellHeight = cellWidth * 64.0 / 98.0
        
        self.keyboardCVHeightAnchor.constant = (cellHeight * 3) + ((cells - 1) * spacing)
        
        
    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SudokuKeysCVCDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1001 {
            return 81
        } else if collectionView.tag == 1002 {
            return 9
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1001 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCellCVC", for: indexPath) as! SudokuCellCVC
            
            let row : Int = indexPath.row + 1
            
            cell.backView.backgroundColor = UIColor.white
    //        cell.textLabel.text = "\(indexPath.row / 9), \(indexPath.row % 9)"
            
            let rowValue : Int = indexPath.row / 9
            let colValue : Int = indexPath.row % 9
            
            if(board[rowValue][colValue] != 0){
                cell.textLabel.text = "\(board[rowValue][colValue])"
            } else {
                cell.textLabel.text = ""
            }
            
            if issueFlag {
                if selectedIndex == indexPath.row {
                    cell.backView.backgroundColor = UIColor.errorTap()
                }
            } else {
                if selectedIndex != -1 {
                    let selectedRow = selectedIndex / 9
                    let selectedCol = selectedIndex % 9
                    
                    if selectedRow == rowValue || selectedCol == colValue || selectedGridIndices.contains(row) {
                        cell.backView.backgroundColor = UIColor.selectedBackground()
                    } else {
                        cell.backView.backgroundColor = UIColor.white
                    }
                    
                    if selectedIndex == indexPath.row {
                        cell.backView.backgroundColor = UIColor.selectedBackground2()
                    }
                    
                }
            }
            
            cell.topOuterView.backgroundColor = UIColor.innerBoundary()
            cell.bottomOuterView.backgroundColor = UIColor.innerBoundary()
            cell.leadingOuterView.backgroundColor = UIColor.innerBoundary()
            cell.trailingOuterView.backgroundColor = UIColor.innerBoundary()
            
            cell.topInnerView.isHidden = true
            cell.bottomInnerView.isHidden = true
            cell.leadingInnerView.isHidden = true
            cell.trailingInnerView.isHidden = true
            
            // Inner Top Line
            if(row >= 1 && row <= 9) {
                cell.topInnerView.isHidden = false
                cell.topInnerView.backgroundColor = UIColor.outerBoundary()
                cell.topOuterView.backgroundColor = UIColor.outerBoundary()
            }
            
            // Inner Leading Line
            if((row - 1) % 9 == 0) {
                cell.leadingInnerView.isHidden = false
                cell.leadingInnerView.backgroundColor = UIColor.outerBoundary()
                cell.leadingOuterView.backgroundColor = UIColor.outerBoundary()
            }
            
            // Inner Trailing Line
            if(row % 9 == 0 || row % 3 == 0) {
                cell.trailingInnerView.isHidden = false
                cell.trailingInnerView.backgroundColor = UIColor.outerBoundary()
                cell.trailingOuterView.backgroundColor = UIColor.outerBoundary()
            }
            
            // Inner Bottom Line
            if(row >= 73 && row <= 81 || row >= 46 && row <= 54 || row >= 19 && row <= 27) {
                cell.bottomInnerView.isHidden = false
                cell.bottomInnerView.backgroundColor = UIColor.outerBoundary()
                cell.bottomOuterView.backgroundColor = UIColor.outerBoundary()
            }
            
            return cell;
        } else if collectionView.tag == 1002 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuKeysCVC", for: indexPath) as! SudokuKeysCVC
            cell.bindData(key: indexPath.row)
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1001 {
            let side : CGFloat = collectionView.frame.width / 9.0
            return CGSize(width: side, height: side)
        } else if collectionView.tag == 1002 {
            let numberOfCells = 3
            let spacing: CGFloat = 12.0
            let cells = CGFloat(numberOfCells)

            let width = (collectionView.frame.width - ((cells - 1) * spacing)) / cells
            let height = width * 64.0 / 98.0

            return CGSize(width: width, height: height)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 1001 {
            return 0.1
        } else  if collectionView.tag == 1002 {
            return 12.0
        }
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 1001 {
            return 0.1
        } else  if collectionView.tag == 1002 {
            return 12.0
        }
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1001 {
            if(selectedIndex != indexPath.row) {
                
                selectedGridIndices.removeAll()
                
                selectedIndex = indexPath.row
                
                let selectedRow = selectedIndex / 9
                let selectedCol = selectedIndex % 9
                
                if(board[selectedRow][selectedCol] != 0){
                    issueFlag = true
                } else {
                    issueFlag = false
                    let gridRow = selectedRow / 3
                    let gridCol = selectedCol / 3

                    for i in 0..<3 {
                        for j in 0..<3 {
                            let cellRow = 3 * gridRow + i
                            let cellCol = 3 * gridCol + j
                            let index = cellRow * 9 + cellCol + 1
                            selectedGridIndices.append(index)
                        }
                    }
                }
            }
            self.sudokuCollectionView.reloadData()
        }
        
    }
    
    func didTapOnKey(key: Int) {
        
    }
}
