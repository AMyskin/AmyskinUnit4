//
//  SliderViewController.swift
//  VKClient
//
//  Created by Vadim on 23.07.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit
//import Kingfisher


final class SliderViewController: UIViewController {

    

    
    var photos: [UIImage] = []
    var photosUrl: [Foto] = []
    var currentIndex = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

 

        
        
        
//        photosUrl.forEach{ (url) in
//            let imageView: UIImageView = UIImageView()
//            if  let url = URL(string: url.photosUrl) {
//                imageView.kf.setImage(with: url)
//            } else {
//                imageView.image = nil
//                imageView.kf.cancelDownloadTask()
//            }
//            if let image = imageView.image {
//                photos.append(image)
//            }
//        }
        photos.forEach { addSlide(image: $0) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        scrollView.scrollToPage(page: currentIndex, animated: true)
    }
    
    // MARK: - Helpers
    
    private func addSlide(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
}
