//
//  detailStocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class detailStocksViewController: UIViewController {
    
    @IBOutlet weak var thumbsImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var openingPriceLabel: UILabel!
    
    @IBOutlet weak var closingPriceLabel: UILabel!
    
    var currentStock: Stock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
        setBackgroundColor()
        setThumbsImage()
        setCircleOutline()
    }
    
    private func setLabelText(){
        dateLabel.text = currentStock.date
        openingPriceLabel.text = "Opening: \(currentStock.openingPrice)"
        closingPriceLabel.text = "Closing: \(currentStock.closingPrice)"
        dateLabel.text = currentStock.date
    }
    
    private func setBackgroundColor(){
        if currentStock.openingPrice > currentStock.closingPrice {
            view.backgroundColor = UIColor(displayP3Red: 0.753, green: 0.312, blue: 0.216, alpha: 1)
        } else {
           view.backgroundColor = UIColor(displayP3Red: 0.648, green: 0.726, blue: 0.357, alpha: 1)
        }
    }
    
    private func setThumbsImage(){
        if currentStock.openingPrice > currentStock.closingPrice {
            thumbsImage.image = UIImage(named: "thumbsDown")
        } else {
            thumbsImage.image = UIImage(named: "thumbsUp")
        }
    }
    
    private func setCircleOutline() {
        thumbsImage.layer.cornerRadius = thumbsImage.frame.size.width/2
        thumbsImage.clipsToBounds = true
        thumbsImage.layer.borderColor = UIColor.black.cgColor
        thumbsImage.layer.borderWidth = 7.0
    }
}

