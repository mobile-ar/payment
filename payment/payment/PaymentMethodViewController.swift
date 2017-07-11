//
//  PaymentMethodViewController.swift
//  payment
//
//  Created by Fernando Romiti on 7/10/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import UIKit
import Moya

class PaymentMethodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var items = [PaymentMethod]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        loadData()
    }
    
    private func loadData() {
        Network.request(service: PaymentService.listPaymentMethods, provider: nil, success: {[weak self] (parsedObjects) in
            if let parsedObjects = parsedObjects {
                
                for item in parsedObjects {
                    if let id = item["id"] as? String,
                        let name = item["name"] as? String {
                        self?.items.append(PaymentMethod(id: id, name: name))
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
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITableViewDelegate - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paymentMethodCell", for: indexPath) as? PaymentMethodCell else { return UITableViewCell() }
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ir al detail del product capaz!
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
