//
//  ViewController.swift
//  SudokuSolverPro
//
//  Created by Eshan on 27/07/26.
//

import UIKit

class ViewController: UIViewController {

    public var board: [[Int]] = [[]]

    var tempBoard: [[Int]] = [[]]

    var isZeroBoard: [[Bool]] {
        board.map { $0.map { $0 == 0 } }
    }

    var nonZeroCount: Int {
        board.flatMap { $0 }.filter { $0 != 0 }.count
    }

    var count: Int = 0
    var actualCount: Int = 0

    var issueFlag: Bool = false
    var selectedIndex: Int = -1
    var selectedGridIndices: [Int] = []
    var numberOfKeys: Int = 9
    var numberOfControlKeys: Int = 3

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!
    @IBOutlet weak var keyboardCollectionView: UICollectionView!
    @IBOutlet weak var sudokuBackView: UIView!
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    @IBOutlet weak var pausePlayButtonImage: UIImageView!
    @IBOutlet weak var homeButtonImage: UIImageView!
    @IBOutlet weak var timerIcon: UIImageView!
    @IBOutlet weak var controlCV: UICollectionView!
    private var timer: Timer?
    private var startDate: Date?
    private var remainingSeconds: Int = 0
    private let timerKey = "SavedTimerEndDate"

    var isRunning: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        count = nonZeroCount

        actualCount = count

        tempBoard = board

        sudokuBackView.backgroundColor = UIColor.outerBoundary()
        sudokuCollectionView.register(
            UINib(nibName: "SudokuCellCVC", bundle: nil),
            forCellWithReuseIdentifier: "SudokuCellCVC"
        )
        sudokuCollectionView.delegate = self
        sudokuCollectionView.dataSource = self
        sudokuCollectionView.backgroundColor = UIColor.innerBoundary()
        sudokuCollectionView.tag = 1001

        keyboardCollectionView.register(
            UINib(nibName: "SudokuKeysCVC", bundle: nil),
            forCellWithReuseIdentifier: "SudokuKeysCVC"
        )
        keyboardCollectionView.dataSource = self
        keyboardCollectionView.delegate = self
        keyboardCollectionView.backgroundColor = UIColor.clear
        keyboardCollectionView.tag = 1002

        controlCV.register(
            UINib(nibName: "ControlCVC", bundle: nil),
            forCellWithReuseIdentifier: "ControlCVC"
        )
        controlCV.dataSource = self
        controlCV.delegate = self
        controlCV.backgroundColor = UIColor.clear
        controlCV.tag = 1003

        self.homeButtonImage.image = UIImage(named: "Home_Icon")

        updatePausePlayUI()

        self.difficultyLevelLabel.text = "Medium"
        self.difficultyLevelLabel.font = UIFont.semibold(22)
        self.difficultyLevelLabel.textColor = UIColor.textColor()

        self.timerLabel.textColor = UIColor.timerColor()
        self.timerLabel.font = UIFont.regular(15)
        self.timerLabel.text = "00:00"

        self.timerIcon.image = UIImage(named: "Timer_Icon")

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )

        restoreTimerIfNeeded()

        DispatchQueue.global(qos: .utility).async {
            var newTempBoard = self.tempBoard

            if SudokuBoardDataSource.sudokuSolver(&newTempBoard, 0, 0) {
                for row in newTempBoard {
                    print(row)
                }
            } else {
                print("No solution exists for this board.")
            }
        }

    }

    func startTimer(duration: Int) {
        // Start counting up from zero
        remainingSeconds = 0
        startDate = Date()

        UserDefaults.standard.set(startDate, forKey: timerKey)

        isRunning = true

        startTicker()
    }

    private func startTicker() {

        timer?.invalidate()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in

            self?.updateTimer()
        }

        RunLoop.main.add(timer!, forMode: .common)

        updateTimer()
    }

    private func updateTimer() {
        guard let startDate = startDate else { return }

        // Elapsed time since startDate
        let elapsed = max(0, Int(Date().timeIntervalSince(startDate)))
        remainingSeconds = elapsed

        let hours = elapsed / 3600
        let minutes = (elapsed % 3600) / 60
        let seconds = elapsed % 60

        if hours > 0 {
            timerLabel.text = String(
                format: "%02d:%02d:%02d",
                hours,
                minutes,
                seconds
            )
        } else {
            timerLabel.text = String(
                format: "%02d:%02d",
                minutes,
                seconds
            )
        }
    }

    func pauseTimer() {

        guard isRunning else { return }

        timer?.invalidate()
        timer = nil

        // Capture elapsed so far into remainingSeconds and clear startDate
        if let startDate = startDate {
            remainingSeconds = max(0, Int(Date().timeIntervalSince(startDate)))
        }

        startDate = nil

        UserDefaults.standard.removeObject(forKey: timerKey)

        isRunning = false
    }

    // MARK: - Resume

    func resumeTimer() {

        guard !isRunning else { return }

        // Set startDate in the past so that elapsed = remainingSeconds + (now - resume)
        startDate = Date().addingTimeInterval(TimeInterval(-remainingSeconds))

        UserDefaults.standard.set(startDate, forKey: timerKey)

        isRunning = true

        startTicker()
    }

    // MARK: - Reset

    func resetTimer() {

        timer?.invalidate()
        timer = nil

        remainingSeconds = 0
        startDate = nil

        isRunning = false

        UserDefaults.standard.removeObject(forKey: timerKey)

        timerLabel.text = "00:00"

        updatePausePlayUI()
    }

    // MARK: - Restore after Background / Relaunch

    private func restoreTimerIfNeeded() {
        if let savedStartDate = UserDefaults.standard.object(forKey: timerKey)
            as? Date
        {
            // Always restore as running and continue counting up
            startDate = savedStartDate
            isRunning = true
            startTicker()
            updatePausePlayUI()
        }
    }

    @objc
    private func appWillEnterForeground() {
        if isRunning {
            updateTimer()
        }
    }

    @IBAction func playPauseTapped(_ sender: Any) {
        if isRunning {
            // Currently running -> pause
            pauseTimer()
        } else {
            // Currently paused/stopped -> start or resume
            if remainingSeconds == 0 {
                startTimer(duration: 90 * 60)
            } else {
                resumeTimer()
            }
        }

        updatePausePlayUI()
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func updatePausePlayUI() {
        if isRunning {
            // Show pause icon when running
            self.pausePlayButtonImage.image = UIImage(named: "Pause_icon")
        } else {
            // Show play icon when paused/stopped
            self.pausePlayButtonImage.image = UIImage(named: "Play_icon")
        }
    }

    @IBAction func homeBtnTapped(_ sender: Any) {

        if actualCount < count {
            let alert = UIAlertController(
                title: "Leave Game?",
                message:
                    "Are you sure you want to leave this current game? Your progress will be lost.",
                preferredStyle: .alert
            )

            let stayAction = UIAlertAction(title: "Stay", style: .cancel) { _ in
                
            }

            let leaveAction = UIAlertAction(title: "Leave", style: .destructive)
            { [weak self] _ in
                stopTimer()
                self?.dismiss(animated: true)
            }

            alert.addAction(stayAction)
            alert.addAction(leaveAction)

            present(alert, animated: true)
        } else {
            stopTimer()
            self.dismiss(animated: true)
        }

    }

    @IBAction func startTapped(_ sender: UIButton) {
        startTimer(duration: 90 * 60)
        updatePausePlayUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout, SudokuKeysCVCDelegate
{
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView.tag == 1001 {
            return 81
        } else if collectionView.tag == 1002 {
            return numberOfKeys
        } else if collectionView.tag == 1003 {
            return numberOfControlKeys
        }
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        if collectionView.tag == 1001 {
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "SudokuCellCVC",
                    for: indexPath
                ) as! SudokuCellCVC

            let row: Int = indexPath.row + 1

            cell.backView.backgroundColor = UIColor.white
            //        cell.textLabel.text = "\(indexPath.row / 9), \(indexPath.row % 9)"

            let rowValue: Int = indexPath.row / 9
            let colValue: Int = indexPath.row % 9

            if tempBoard[rowValue][colValue] != 0 {
                cell.textLabel.text = "\(tempBoard[rowValue][colValue])"
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

                    if selectedRow == rowValue || selectedCol == colValue
                        || selectedGridIndices.contains(row)
                    {
                        cell.backView.backgroundColor =
                            UIColor.selectedBackground()
                    } else {
                        cell.backView.backgroundColor = UIColor.white
                    }

                    if selectedIndex == indexPath.row {
                        cell.backView.backgroundColor =
                            UIColor.selectedBackground2()
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
            if row >= 1 && row <= 9 {
                cell.topInnerView.isHidden = false
                cell.topInnerView.backgroundColor = UIColor.outerBoundary()
                cell.topOuterView.backgroundColor = UIColor.outerBoundary()
            }

            // Inner Leading Line
            if (row - 1) % 9 == 0 {
                cell.leadingInnerView.isHidden = false
                cell.leadingInnerView.backgroundColor = UIColor.outerBoundary()
                cell.leadingOuterView.backgroundColor = UIColor.outerBoundary()
            }

            // Inner Trailing Line
            if row % 9 == 0 || row % 3 == 0 {
                cell.trailingInnerView.isHidden = false
                cell.trailingInnerView.backgroundColor = UIColor.outerBoundary()
                cell.trailingOuterView.backgroundColor = UIColor.outerBoundary()
            }

            // Inner Bottom Line
            if row >= 73 && row <= 81 || row >= 46 && row <= 54
                || row >= 19 && row <= 27
            {
                cell.bottomInnerView.isHidden = false
                cell.bottomInnerView.backgroundColor = UIColor.outerBoundary()
                cell.bottomOuterView.backgroundColor = UIColor.outerBoundary()
            }

            if isZeroBoard[rowValue][colValue] == true {
                cell.textLabel.textColor = UIColor.enteredTextColor()
            } else {
                cell.textLabel.textColor = UIColor.black
            }

            return cell
        } else if collectionView.tag == 1002 {
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "SudokuKeysCVC",
                    for: indexPath
                ) as! SudokuKeysCVC
            cell.bindData(key: indexPath.row)
            cell.delegate = self
            return cell
        } else if collectionView.tag == 1003 {
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ControlCVC",
                    for: indexPath
                ) as! ControlCVC
            if indexPath.row == 0 {
                cell.bindDataForReset()
            } else if indexPath.row == 1 {
                cell.bindDataForErase()
            } else if indexPath.row == 2 {
                cell.bindDataForSolve()
            }
            let height = collectionView.bounds.height
            let cellWidth = height * 48.0 / 70.0
            cell.widthCons.constant = cellWidth
            return cell
        }
        return UICollectionViewCell()

    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView.tag == 1001 {
            let totalWidth = collectionView.bounds.width
            let totalHeight = collectionView.bounds.height

            let col = CGFloat(indexPath.item % 9)
            let row = CGFloat(indexPath.item / 9)

            let cellWidth =
                floor((col + 1) * totalWidth / 9.0)
                - floor(col * totalWidth / 9.0)
            let cellHeight =
                floor((row + 1) * totalHeight / 9.0)
                - floor(row * totalHeight / 9.0)

            return CGSize(width: cellWidth, height: cellHeight)
        } else if collectionView.tag == 1002 {
            let numberOfCells = 3
            let spacing: CGFloat = 12.0
            let cells = CGFloat(numberOfCells)
            let width =
                (collectionView.frame.width - ((cells - 1) * spacing)) / cells
            let height =
                (collectionView.frame.height - ((cells - 1) * spacing)) / cells
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 1003 {
            let height = collectionView.bounds.height
            let cellWidth = height * 48.0 / 70.0
            return CGSize(width: cellWidth, height: height)
        }
        return CGSize.zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        if collectionView.tag == 1001 {
            return 0
        } else if collectionView.tag == 1002 {
            return 12.0
        } else if collectionView.tag == 1003 {
            let totalWidth = collectionView.bounds.width
            let height = collectionView.bounds.height
            let cellWidth = height * 48.0 / 70.0
            let spacing: CGFloat =
                (totalWidth - cellWidth * CGFloat(numberOfControlKeys))
                / (CGFloat(numberOfControlKeys) + 1.0)
            return spacing
        }
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if collectionView.tag == 1003 {
            let totalWidth = collectionView.bounds.width
            let height = collectionView.bounds.height
            let cellWidth = height * 48.0 / 70.0
            let spacing: CGFloat =
                (totalWidth - cellWidth * CGFloat(numberOfControlKeys))
                / (CGFloat(numberOfControlKeys) + 1.0)
            return UIEdgeInsets(
                top: 0,
                left: spacing,
                bottom: 0,
                right: spacing
            )
        }
        return .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        if collectionView.tag == 1001 {
            return 0
        } else if collectionView.tag == 1002 {
            return 12.0
        }
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if collectionView.tag == 1001 {
            if selectedIndex != indexPath.row {

                selectedGridIndices.removeAll()

                selectedIndex = indexPath.row

                let selectedRow = selectedIndex / 9
                let selectedCol = selectedIndex % 9

                if tempBoard[selectedRow][selectedCol] != 0
                    && !isZeroBoard[selectedRow][selectedCol]
                {
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
        } else if collectionView.tag == 1003 {
            if indexPath.row == 0 {
                resetSudoku()
            } else if indexPath.row == 1 {
                erase()
            } else if indexPath.row == 2 {
                solveSudoku()
            }
        }

    }

    func solveSudoku() {
        tempBoard = board
        if SudokuBoardDataSource.sudokuSolver(&tempBoard, 0, 0) {
            self.sudokuCollectionView.reloadData()
        } else {
            self.showToast(message: "No solution exists for this board.")
        }
    }

    func erase() {
        if selectedIndex != -1 {
            let selectedRow = selectedIndex / 9
            let selectedCol = selectedIndex % 9
            if isZeroBoard[selectedRow][selectedCol] == true
                && tempBoard[selectedRow][selectedCol] >= 1
                && tempBoard[selectedRow][selectedCol] <= 9
            {
                tempBoard[selectedRow][selectedCol] = 0
                count -= 1
                self.sudokuCollectionView.reloadData()
            }
        }
    }

    func resetSudoku() {
        tempBoard = board
        self.sudokuCollectionView.reloadData()
    }

    func didTapOnKey(key: Int) {
        if selectedIndex >= 0 && selectedIndex <= 80 {
            let selectedRow = selectedIndex / 9
            let selectedCol = selectedIndex % 9
            if tempBoard[selectedRow][selectedCol] == 0 {
                tempBoard[selectedRow][selectedCol] = key
                count += 1
                self.sudokuCollectionView.reloadData()
                if count == 81 {
                    playPauseTapped(self)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }

}
