//
//  DishDetailViewController.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLbl: UILabel!
    @IBOutlet weak var dishCaloriesLbl: UILabel!
    @IBOutlet weak var dishDescriptionLbl: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    var dish : DishModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }
    
    private func populateView(){
            dishImageView.kf.setImage(with: dish?.image?.asUrl)
            dishTitleLbl.text = dish?.name
            dishDescriptionLbl.text = dish?.description
        dishCaloriesLbl.text = dish?.formattedCalories
        }
    


    @IBAction func placeOrderBtnClicked(_ sender: UIButton) {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty else {
            ProgressHUD.showError("Please enter your name")
            return
        }
        
        ProgressHUD.show("Placing order...")
        NetworkService.shared.placeOrder(dishId: dish?.id ?? "", name: name){
            (result) in
            switch result {
            case .success(let order):
                ProgressHUD.showSuccess("Your order has been received 👨🏻‍🍳 ")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
            
        }
        
    }
    

}
