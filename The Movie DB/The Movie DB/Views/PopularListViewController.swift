//
//  PopularListViewController.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import UIKit

class PopularListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var ViewModel : PopularListViewModel!
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        ViewModel = PopularListViewModel()
        ViewModel.delegate = self
        ViewModel.networkManager = NetworkManager()
        ViewModel.fetchData()
        tableView.tableFooterView = activityIndicator
        activityIndicator.startAnimating()
    }
    

}
extension PopularListViewController : PopularListDelegate{
    func didReceiveResponse() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    
}
extension PopularListViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewModel.popularpeople?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PopularpeopleCell",
            for: indexPath
        ) as! PopularListTableViewCell
        cell
            .configure(
                name: ViewModel.popularpeople?[indexPath.row].name ?? "name",
                department: ViewModel.popularpeople?[indexPath.row].department ?? "department",
                imageString: ViewModel.popularpeople?[indexPath.row].profilePath ?? ""
            )
        return cell
    }
    func tableView(_ tableView: UITableView,willDisplay cell: UITableViewCell,forRowAt indexPath: IndexPath) {
        if indexPath.row == (ViewModel.popularpeople?.count ?? 1)-2{
            activityIndicator.startAnimating()
            ViewModel.fetchData()
            
        }
    }
    
}
