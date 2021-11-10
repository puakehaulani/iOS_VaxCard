//
//  ViewController.swift
//  VaxCard
//
//  Created by lexi on 11/9/21.
//
import Photos
import PhotosUI
import UIKit

class ViewController: UIViewController, PHPickerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Vaccine Records"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }

    @objc private func didTapAdd(){
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 2
        config.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated:true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                print(image)
            }
        }
    }

}

