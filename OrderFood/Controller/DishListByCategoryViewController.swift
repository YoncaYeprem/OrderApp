//
//  DishListByCategoryViewController.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 30.08.2022.
//

import UIKit
import ProgressHUD

class DishListByCategoryViewController: UIViewController {

    @IBOutlet weak var dishesTableView: UITableView!
    
    var dishCategory : DishCategoryModel?
    
    var selectedDish : DishModel?

    var dishes: [DishModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        //title = dishCategory?.distCategoryTitle
        ProgressHUD.show()
        NetworkService.shared.fetchCategoryDishes(categoryId: dishCategory?.id ?? "") {
            [weak self] (result) in
            switch result {
            case .success(let dishes):
                ProgressHUD.dismiss()
                self?.dishes = dishes
                self?.dishesTableView.reloadData()
                
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
        }
        }
    }
    
    
    private func registerCells(){
        dishesTableView.register(UINib(nibName: DishCategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishCategoryTableViewCell.identifier)
    }

}

extension DishListByCategoryViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dishesTableView.dequeueReusableCell(withIdentifier: DishCategoryTableViewCell.identifier, for:indexPath) as! DishCategoryTableViewCell
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDish = dishes[indexPath.row]
                   
        performSegue(withIdentifier: "sg_dish_detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "sg_dish_detail" {
                guard let vc  = segue.destination as? DishDetailViewController else { return }
                vc.dish = selectedDish
            }
        
        }
    
}
