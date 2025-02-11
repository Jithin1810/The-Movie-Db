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
    private var debounceTimer : Timer?

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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardPicker))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
        tableView.keyboardDismissMode = .onDrag
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
        ViewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PopularpeopleCell",
            for: indexPath
        ) as? PopularListTableViewCell, let model = ViewModel.modelAt(indexPath) else{return UITableViewCell()}
        let url = ImageURLBuilder.getUrl(with: model.profilePath ?? "")
        cell
            .configure(
                name: model.name,
                department: model.department,
                imageString: url,
                popularity: model.popularity
            )
        return cell
    }
    func tableView(_ tableView: UITableView,willDisplay cell: UITableViewCell,forRowAt indexPath: IndexPath) {
        if indexPath.row == (ViewModel.popularpeople?.count ?? 1)-2{
            activityIndicator.startAnimating()
            ViewModel.fetchData()
            
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if ViewModel.searchText == ""{
            return "Popular People List"
        }else{
            return "Showing Search List"
        }
    }
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath
    ) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVc = storyBoard.instantiateViewController(withIdentifier: "PeopleDetailViewController") as? PeopleDetailViewController else {
            return
        }
        detailsVc.selectedPerson = ViewModel.modelAt(indexPath)
        detailsVc.networkManager = NetworkManager()
        self.navigationController?
            .pushViewController(detailsVc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PopularListViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            ViewModel.searchText = ""
            tableView.reloadData()
        }
        ViewModel.searchText = searchText
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        debounceTimer?.invalidate()
        debounceTimer = Timer
            .scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(search),
                userInfo: nil,
                repeats: false
            )
        return true
    }
    @objc func search(){
        if ViewModel.searchText == "" {
            tableView.reloadData()
        }else{
            ViewModel.fetchSearchData()
        }
    }
}
extension PopularListViewController{
    @objc func dismissKeyboardPicker(){
        view.endEditing(true)
    }
}
