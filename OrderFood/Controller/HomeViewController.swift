//
//  HomeViewController.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var popularDishesCollectionView: UICollectionView!
    
    @IBOutlet weak var specialDishesCollectionView: UICollectionView!

    var selectedDish : DishModel?
    var selectedDishCategory : DishCategoryModel?

    var categories:[DishCategoryModel] = []
    
    var popularDishes:[DishModel] = []
    
    var specialDishes:[DishModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        NetworkService.shared.fetchAllCategories { [weak self] (result) in
                    switch result {
                    case .success(let allDishes):
                        ProgressHUD.dismiss()
                        self?.categories = allDishes.categories ?? []
                        self?.popularDishes = allDishes.populars ?? []
                        self?.specialDishes = allDishes.specials ?? []
                        
                        self?.categoryCollectionView.reloadData()
                        self?.popularDishesCollectionView.reloadData()
                        self?.specialDishesCollectionView.reloadData()
                    case .failure(let error):
                        ProgressHUD.showError(error.localizedDescription)
                    }
                }
        registerCells()
    }
    
    
    @IBAction func goToOrderListViewButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "sg_orders_list", sender: self)
        
    }
    
    private func registerCells(){
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularDishesCollectionView.register(UINib(nibName: PopularDishesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularDishesCollectionViewCell.identifier)
        specialDishesCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case categoryCollectionView:
            return categories.count
        case popularDishesCollectionView:
            return popularDishes.count
        case specialDishesCollectionView:
            return specialDishes.count
        default: return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case popularDishesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDishesCollectionViewCell.identifier, for: indexPath) as! PopularDishesCollectionViewCell
            cell.setup(dish: popularDishes[indexPath.row])
            return cell
        case specialDishesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: specialDishes[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            selectedDishCategory = categories[indexPath.row]
                       
            performSegue(withIdentifier: "sg_dish_category", sender: self)
        }else {
            selectedDish = collectionView == popularDishesCollectionView ? popularDishes[indexPath.row] : specialDishes[indexPath.row]
                       print("item tıklandı")
            //            let newView = self.storyboard?.instantiateViewController(withIdentifier: "storyBoardIdentifier") as! DishDetailViewController
            //            self.navigationController?.pushViewController(newView, animated: true)
                        performSegue(withIdentifier: "sg_dish_detail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "sg_dish_detail" {
                guard let vc  = segue.destination as? DishDetailViewController else { return }
                vc.dish = selectedDish
            }else if segue.identifier == "sg_dish_category" {
                guard let vc  = segue.destination as? DishListByCategoryViewController else { return }
                vc.dishCategory = selectedDishCategory
            }
        
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
