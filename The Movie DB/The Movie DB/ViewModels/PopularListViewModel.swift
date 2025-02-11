//
//  PopularListViewModel.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import Foundation
protocol PopularListDelegate : AnyObject{
    func didReceiveResponse()
}

class PopularListViewModel{
    weak var delegate : PopularListDelegate?
    var networkManager : NetworkManagerProtocol?
    var popularpeople : [PopularPeopleModel]?
    var searchList : [PopularPeopleModel]?
    var currentPage = 0
    var searchText = ""
    
    
    func fetchData(){
        currentPage += 1
        let request = networkManager?.createRequest(
            with: "https://api.themoviedb.org/3/person/popular?api_key=51f7fc3534a2a69b001e48ad59ec1b0c&page=\(currentPage)",
            method: NetworkRequestType.get,
            body: nil
        )
        if let request = request{
            networkManager?
                .request(request, decodeTo: ResponseModel.self, completion: { result in
                    switch result{
                    case .failure(let error) :
                        print(error)
                    case .success(let response) :
                        if self.popularpeople != nil{
                            self.popularpeople?.append(contentsOf: response.results)
                        }else{
                            DispatchQueue.main.async {
                                self.popularpeople = response.results
                            }
                        }
                        self.delegate?.didReceiveResponse()
                    }
                })
        }
    }
    
    func numberOfRows() -> Int {
        if searchText != "" {
            return searchList?.count ?? 0
        } else {
            return popularpeople?.count ?? 0
        }
    }
    
    func modelAt(_ indexPath: IndexPath) -> PopularPeopleModel? {
        if searchText != "" {
            return searchList?[indexPath.row]
        } else {
            return popularpeople?[indexPath.row]
        }
    }
}

extension PopularListViewModel{
    func fetchSearchData(){
        let request = networkManager?.createRequest(
            with: "https://api.themoviedb.org/3/search/person?query=\(self.searchText)&api_key=51f7fc3534a2a69b001e48ad59ec1b0c",
            method: .get,
            body: nil
        )
        if let request = request{
            networkManager?
                .request(
                    request,
                    decodeTo: ResponseModel.self,
                    completion: { result in
                    switch result{
                    case .failure(let error) :
                        print(error)
                    case .success(let response) :
                        DispatchQueue.main.async {
                            self.searchList = response.results
                        }
                        self.delegate?.didReceiveResponse()
                    }
                })
        }
    }
}
