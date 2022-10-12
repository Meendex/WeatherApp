//
//  AddLLocationViewController.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 06/10/2022.
//

import UIKit
import Combine


class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = AddLocationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getLocations()
        tableView.reloadData()
    }
    
    func setupNavBar() {
        self.navigationItem.title = "Add Location"
    }
    
    
    @IBAction func addLocationButtonAction(_ sender: Any) {
        if let locationName = locationTextField.text, !locationName.isEmpty {
            viewModel.saveLocation(locationName: locationName)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
extension AddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationsCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getLocationName(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            //to do delete core data
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
