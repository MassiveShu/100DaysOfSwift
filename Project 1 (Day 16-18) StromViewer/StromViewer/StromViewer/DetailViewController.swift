//
//  DetailViewController.swift
//  StromViewer
//
//  Created by Max Shu on 12.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    var selectedImage: String? 
    var selectedPictureNumber = 0
    var totalPictures = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // name of the image show
        title = "This image is \(selectedImage)"
        // screen configuration .never use a large title
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            ImageView.image = UIImage(named: imageToLoad)
        }
    }

    // hides back button and scales picture on tapping

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
