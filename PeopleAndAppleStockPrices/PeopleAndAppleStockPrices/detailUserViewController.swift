//
//  detailUserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Anthony Gonzalez on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class detailUserViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    var currentUser: userResults!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
        loadImage()
        setCircleOutline()
    }
    
    func loadImage() {
        let urlStr = currentUser.picture.large
        guard let url = URL(string: urlStr) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            do { let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.profileImage.image = image
                }
            } catch {fatalError()}
        }
    }
    
    private func setLabelText () {
        userLabel.text = currentUser.getFullName()
        //        var currentUsersDOB = currentUser.dob.date.components(separatedBy: "T")[0]
        //        currentUsersDOB = Date.changeDateFormat(dateString: currentUsersDOB, fromFormat: "yyyy-MM-dd", toFormat: "MM/dd/yyyy")
        dobLabel.text = "DOB: \(currentUser.dob)"
        phoneNumberLabel.text = "Phone #: \(currentUser.phone)"
        addressLabel.text = "\(currentUser.location.street.capitalized), \(currentUser.location.city.capitalized), \(currentUser.location.state.uppercased())"
    }
    
    private func setCircleOutline() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true //Lines 85 and 86 are used to adjust the corners so that colorView is a circle.
        
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 4.0
    }
}

extension Date {
    static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = fromFormat
        let date = inputDateFormatter.date(from: dateString)
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        return outputDateFormatter.string(from: date!)
    }
}
