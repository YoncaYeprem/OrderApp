//
//  OnboardViewController.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 28.08.2022.
//

import UIKit

class OnboardViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var onboardSlides:[OnboardModel] = []
    
    var currentPage:Int = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == onboardSlides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            }else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardSlides = [
            OnboardModel(
                title:"Do you want to eat something ?" ,
                description: "You want some food all of sudden?",
                image: UIImage(named: "think_food")!
            ),
            
            OnboardModel(
                title:"Go Online Order" ,
                description: "Use our Order App and search lots of delicious food",
                image: UIImage(named: "online_shop")!
            ),
            
            OnboardModel(
                title:"Start Eating!" ,
                description: "Enjoy your meal...",
                image: UIImage(named: "eat_food")!
            )
        
        ]
        pageControl.numberOfPages = onboardSlides.count
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == onboardSlides.count - 1 {
            //performSegue(withIdentifier: "sg_home", sender: self)
            
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
}

extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardCollectionViewCell.identifier, for: indexPath) as! OnboardCollectionViewCell
        cell.setup(slide: onboardSlides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
