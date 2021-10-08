//
//  ViewController.swift
//  HomeWork11
//
//  Created by Anastasia Belyakova on 03.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!

    var timer = Timer()
    var time = 0
    var isWorkTime = false
    var isStarted = false

    let workTime = 1500
    let restTime = 300

    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        setStartStopButtonImage()
        setUpCircularProgressBarView()
        circularProgressBarView.createCircularPathCircleLayer()
    }

    func setStartStopButtonImage() {
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let symbolPlay = UIImage(systemName: "play", withConfiguration: largeConfiguration)
        self.startStopButton.setImage(symbolPlay, for: .normal)
        self.startStopButton.tintColor = .systemRed
    }

    @IBAction func startStopButtonClick(_ sender: Any) {
        let symbolStop = UIImage(systemName: "stop")
        let symbolPlay = UIImage(systemName: "play")

        if !isStarted {
            if !isWorkTime {
                time = workTime
                circularViewDuration = Double(workTime)
                startTimer()
                setUpCircularProgressBarView()
                circularProgressBarView.createCircularPath(lineColor: UIColor.systemRed.cgColor) //
                isWorkTime = true
            }
            self.startStopButton.setImage(symbolStop, for: .normal)
            isStarted = true
        } else {
            timer.invalidate()
            circularProgressBarView.createCircularPathCircleLayer()
            timeLabel.text = "25:00"
            timeLabel.textColor = .systemRed
            self.startStopButton.setImage(symbolPlay, for: .normal)
            self.startStopButton.tintColor = .systemRed
            isWorkTime = false
            isStarted = false
        }

    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if time < 1 {
            if isWorkTime {
                isWorkTime = false
                time = restTime
                timeLabel.text = "05:00"
                timeLabel.textColor = .systemGreen
                circularViewDuration = Double(restTime)
                setUpCircularProgressBarView()
                circularProgressBarView.createCircularPath(lineColor: UIColor.systemGreen.cgColor)
                self.startStopButton.tintColor = .systemGreen
            } else {
                isWorkTime = true
                time = workTime
                timeLabel.text = "25:00"
                timeLabel.textColor = .systemRed
                circularViewDuration = Double(workTime)
                setUpCircularProgressBarView()
                circularProgressBarView.createCircularPath(lineColor: UIColor.systemRed.cgColor)
                self.startStopButton.tintColor = .systemRed
            }
        } else {
            time -= 1
            timeLabel.text = formatTime()
        }
    }

    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

    func setUpCircularProgressBarView() { //
        // set view
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        // align to the center of the screen
        circularProgressBarView.center = view.center
        // call the animation with circularViewDuration
        circularProgressBarView.progressAnimation(duration: circularViewDuration)
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
    }

}

