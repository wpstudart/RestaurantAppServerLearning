//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Aluno on 24/05/2018.
//  Copyright © 2018 wpstudart. All rights reserved.
//

import Foundation
import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }
    
    var minutes: Int!
}
