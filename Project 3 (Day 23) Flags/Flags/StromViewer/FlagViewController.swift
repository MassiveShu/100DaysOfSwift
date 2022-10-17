//
//  FlagViewController.swift
//  StromViewer
//
//  Created by Max Shu on 17.10.2022.
//

import UIKit

class FlagViewController: UIViewController {

    var countryNumber: Int?
    var flagsHD: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard countryNumber != nil else {
            print("No country number provided")
            navigationController?.popViewController(animated: true)
            return
        }

        guard flagsHD != nil else {
            print("No flags provided")
            navigationController?.popViewController(animated: true)
            return
        }

        navigationItem.largeTitleDisplayMode = .never
        

        updateImage()

        // add left and right swipe gestures to switch from one flag to the previous/next
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)

        // add left and right tap gestures to switch from one flag to the previous/next
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    func updateImage() {
        title = getTextForFlag(flagName: flagsHD![countryNumber!], type: .HD)
    }

    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            showNextImage()
        }

        if (sender.direction == .right) {
            showPreviousImage()
        }
    }

    func showPreviousImage() {
        if countryNumber! > 0 {
            countryNumber! -= 1
            updateImage()
        }
    }

    func showNextImage() {
        if countryNumber! < flagsHD!.count - 1 {
            countryNumber! += 1
            updateImage()
        }
    }

    @objc func handleTap(_ gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }

        let point = gestureRecognizer.location(in: self.view)

        // left tap
        if point.x < (view.bounds.width / 2) * 0.66 {
            showPreviousImage()
        }
        // right tap
        else if point.x > (view.bounds.width / 2) * 1.33 {
            showNextImage()
        }
    }
}

