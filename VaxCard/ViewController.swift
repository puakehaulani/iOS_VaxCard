//
//  ViewController.swift
//  VaxCard
//
//  Created by lexi on 11/9/21.
//
import Photos
import PhotosUI
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    private var itemProviders = [NSItemProvider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Vaccine Records"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        imageView.backgroundColor = .gray
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
    }

    @objc private func didTapAdd(){
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 2
        config.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated:true)
    }

   
    private var images = [UIImage]()
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        self.itemProviders = results.map(\.itemProvider)
        let item = itemProviders.first
        if ((item?.canLoadObject(ofClass: UIImage.self)) != nil){
            item?.loadObject(ofClass:UIImage.self, completionHandler: {(image, error) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.imageView.image = image
                    }
                    else {
                        print(error?.localizedDescription)
                    }
                }
            })
        }
        else {
            print("can't load")
        }
       }
}
