//
//  InfoViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let imageView = UIImageView()
    let pageControl = UIPageControl()
    let swipe = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureSwipe()
        makeConstraints()
    }
    
    func configureSwipe() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        imageView.addGestureRecognizer(leftSwipe)
        imageView.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ gestureRecognizer : UISwipeGestureRecognizer) {
//        if gestureRecognizer.state == .ended {
////            imageView.image = UIImage(named: "female.png")
//            print(pageControl.currentPage)
//            
//            
//            switch pageControl.currentPage {
//            case 0:
//                imageView.image = UIImage(named: "male.png")
//            case 1:
//                imageView.image = UIImage(named: "female.png")
//            case 2:
//                imageView.image = UIImage(named: "male.png")
//            default:
//                return
//            }
//        }

    }
    
    func makeConstraints() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        imageView.isUserInteractionEnabled = true
//        imageView.image = UIImage(named: "male.png")
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
    }
}
