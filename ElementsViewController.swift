//
//  ElementsViewController.swift
//  Elements
//
//  Created by hildy abreu on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {

    var elements = [ElementWrapper]() {
        didSet {
            ElementTableView.reloadData()
        }
    }
    
    @IBOutlet weak var ElementTableView: UITableView!
    
    
    
    
override func viewDidLoad() {
        super.viewDidLoad()
    ElementTableView.delegate = self
    ElementTableView.dataSource = self
    loadElementsFromSearch()
    }
    
    private func loadElementsFromSearch() {
        APIClient.shared.getElement { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let elementsFromOnline):
                    self.elements = elementsFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}





extension ElementsViewController: UITableViewDelegate {
    
}
extension ElementsViewController: UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ElementTableView.dequeueReusableCell(withIdentifier: "elementsCell", for: indexPath) as! ElementsTableViewCell
        let element = elements[indexPath.row]
        cell.elementNameLabel.text = element.name
        cell.symbolWeightLabel.text = "\(element.symbol) \(element.number) \(element.weight)"
        
        
        let urlStr = "http://www.theodoregray.com/periodictable/Tiles/\(element.threeDigitNumber)/s7.JPG"
        
        ImageHelper.shared.getImage(urlStr: urlStr) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let image ):
                    cell.elementImage.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
        


        return cell
}
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 180
}


func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    let elementSelected = elements[indexPath.row]
    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
    let elementsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailElementsViewController") as! DetailElementsViewController
    elementsViewController.elements = elementSelected




        self.navigationController?.pushViewController(elementsViewController, animated: true)
}
}

//guard let elementDetailedVC = storyboard?.instantiateViewController(withIdentifier: "ElementsDetailedViewController") as? ElementsDetailedViewController else {return}
//
//let info = element[indexPath.row]
//elementDetailedVC.element = info
//
//self.navigationController?.pushViewController(elementDetailedVC, animated: true)

