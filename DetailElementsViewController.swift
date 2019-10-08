//
//  DetailElementsViewController.swift
//  Elements
//
//  Created by hildy abreu on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailElementsViewController: UIViewController {

    var elements: ElementWrapper!
    

    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var meltingPointLabel: UILabel!
    
    @IBOutlet weak var boilingPointLabel: UILabel!
    
    @IBOutlet weak var discoveryByLabel: UILabel!
    
    
    @IBAction func button(_ sender: UIButton) {
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElementsDetails()
        loadImage()

        
    }
    

    func setupElementsDetails() {
        symbolLabel.text = "symbol: \(elements.symbol)"
        numberLabel.text = "number: \(elements.number)"
        weightLabel.text = "weight: \(elements.weight)"
        
        if let meltingPoint = elements.meltingPoint {
            meltingPointLabel.text = "melting Point: \(meltingPoint)"
        } else {
            meltingPointLabel.text = "N/A"
        }
      
        if let boilingPoint = elements.boilingPoint {
            boilingPointLabel.text = "boilingPoint: \(boilingPoint)"
        } else{
            boilingPointLabel.text = "N/A"
        }
        
        if let discoveredBy = elements.discoveryBy {
            discoveryByLabel.text = "discoveredBy: \(discoveredBy)"
        } else {
            discoveryByLabel.text = "N/A"
        }
    }
        

//    }
    
    
    func loadImage() {
        let urlStr = "http://images-of-elements.com/\(elements.name.lowercased()).jpg"

ImageHelper.shared.getImage(urlStr: urlStr) { (result) in
    DispatchQueue.main.async {
        switch result {
        case .success(let image ):
            self.elementImage.image = image
        case .failure(let error):
            print(error)
        }
    }
}
    }
    
    
    
    
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        let myFavorite = FavoriteElement(favoritedBy: "Hildy", elementName: elements.name, elementSymbol: elements.symbol)
        
        APIClient.shared.postElement(favorite: myFavorite) { (result) in
            DispatchQueue.main.async {
                
                
                switch result {
                case .failure(let error):
                    print (error)
                case .success(let data):
                    print ("We posted successfully")
                }
            }
        }
    }
    


}

