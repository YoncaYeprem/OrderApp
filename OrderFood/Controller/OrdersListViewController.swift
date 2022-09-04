//
//  OrdersListViewController.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 30.08.2022.
//

import UIKit
import ProgressHUD

class OrdersListViewController: UIViewController {
    
    var selectedDish:DishModel?
    
    var orders:[OrderModel] = []

    @IBOutlet weak var ordersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        registerCell()
        ProgressHUD.show()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NetworkService.shared.fetchOrders(){
            [weak self] (result) in
            switch result {
            case .success(let orders):
                ProgressHUD.dismiss()
                self?.orders = orders
                self?.ordersTableView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    

    private func registerCell(){
        ordersTableView.register(UINib(nibName: DishCategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishCategoryTableViewCell.identifier)
    }

}

extension OrdersListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: DishCategoryTableViewCell.identifier) as! DishCategoryTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDish = orders[indexPath.row].dish
                   
        performSegue(withIdentifier: "sg_dish_detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "sg_dish_detail" {
                guard let vc  = segue.destination as? DishDetailViewController else { return }
                vc.dish = selectedDish
            }
        }
    
    
}
