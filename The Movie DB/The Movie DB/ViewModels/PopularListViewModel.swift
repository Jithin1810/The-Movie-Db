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
    var currentPage = 0
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
                            self.popularpeople = response.results
                        }
                        self.delegate?.didReceiveResponse()
                    }
                })
        }
    }
}
