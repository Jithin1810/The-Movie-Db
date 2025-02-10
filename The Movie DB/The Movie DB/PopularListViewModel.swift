//
//  PopularListViewModel.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import Foundation
protocol PopularListDelegate : AnyObject{
    
}

class PopularListViewModel{
    weak var delegate : PopularListDelegate?
    var popularpeople : [PopularPeopleModel]?
}
