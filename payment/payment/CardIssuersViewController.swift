//
//  CardIssuersViewController.swift
//  payment
//
//  Created by Fernando Romiti on 7/17/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import UIKit

class CardIssuersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var items = [CardIssuer]()
    var paymentMethod = PaymentMethod()
    var amount = Float(0)
    
    weak var delegate: InstallmentsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        loadData()
    }
    
    private func loadData() {
        Network.request(service: PaymentService.listCardIssuers(paymentMethodId: self.paymentMethod.id), provider: nil, success: {[weak self] (parsedObjects) in
            if let parsedObjects = parsedObjects {
                
                for item in parsedObjects {
                    if let id = item["id"] as? String,
                        let name = item["name"] as? String,
                        let secureThumbnail = item["secure_thumbnail"] as? String {
                        self?.items.append(CardIssuer(id: id, name: name, secureThumbnail: secureThumbnail))
                    }
                }
                
                DispatchQueue.main.async() {
                    self?.spinner.stopAnimating()
                    self?.tableView.reloadData()
                }
            }
            }, error: { (error) in
                print(error)
        }, failure: { (error) in
            print(error)
        })
        
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: UITableViewDelegate - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardIssuersCell", for: indexPath) as? CardIssuersCell else { return UITableViewCell() }
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ControllerNavigator.showInstallments(for: self.paymentMethod, amount: self.amount, issuer: items[indexPath.row], delegate: self.delegate)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
