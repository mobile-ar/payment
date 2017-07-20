//
//  InstallmentsViewController.swift
//  payment
//
//  Created by Fernando Romiti on 7/19/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import UIKit

protocol InstallmentsDelegate: class {
    func selected(amount: Float, paymentMethod: String, cardIssuer: String, installment: String)
}

class InstallmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var items = [Installment]()
    var amount = Float(0)
    var paymentMethod = PaymentMethod()
    var issuer = CardIssuer()
    
    weak var delegate: InstallmentsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        loadData()
    }
    
    private func loadData() {
        Network.request(service: PaymentService.listInstallments(amount: self.amount, paymentMethodId: self.paymentMethod.id, issuerId: self.issuer.id), provider: nil, success: {[weak self] (parsedObjects) in
            if let parsedObjects = parsedObjects {
                for item in parsedObjects {
                    if let recommendedMessage = item["recommended_message"] as? String {
                        self?.items.append(Installment(recommendedMessage: recommendedMessage))
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "installmentsCell", for: indexPath) as? InstallmentsCell else { return UITableViewCell() }
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        _ = self.navigationController?.popToRootViewController(animated: true)
        delegate?.selected(amount: self.amount, paymentMethod: self.paymentMethod.name, cardIssuer: self.issuer.name, installment: items[indexPath.row].recommendedMessage)
    }
    
}
