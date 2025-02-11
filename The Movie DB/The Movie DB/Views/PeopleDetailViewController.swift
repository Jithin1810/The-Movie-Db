//
//  PeopleDetailViewController.swift
//  The Movie DB
//
//  Created by JiTHiN on 11/02/25.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originalNmaeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var knownForCollectionView: UICollectionView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var selectedPerson : PopularPeopleModel?
    var selectedPersonImages : [Images]?
    var networkManager : NetworkManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        knownForCollectionView.dataSource = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        knownForCollectionView.delegate = self
        setUp()
        getImages()
        
    }

}
extension PeopleDetailViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == knownForCollectionView{
            return selectedPerson?.knownFor.count ?? 1
        }else{
            return selectedPersonImages?.count ?? 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == knownForCollectionView{
            let cell = knownForCollectionView.dequeueReusableCell(
                withReuseIdentifier: "knownForCollectionCell",
                for: indexPath
            ) as! KnownForCollectionViewCell
            let url = ImageURLBuilder.getUrl(with: selectedPerson?
                .knownFor[indexPath.row].posterPath  ?? "")
            cell.configure(imageString: url)
            return cell
        } else {
            let cell = imagesCollectionView.dequeueReusableCell(
                withReuseIdentifier: "imageCollectionCell",
                for: indexPath
            ) as! ImagesCollectionViewCell
            let url = ImageURLBuilder.getUrl(with: selectedPersonImages?[indexPath.row].filepath ?? "")
            cell.configure(imageString: url)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: self.view.frame.width/3,
            height: collectionView.bounds.height
        )
    }
}

extension PeopleDetailViewController{
    func setUp(){
        navigationItem.largeTitleDisplayMode = .never
        nameLabel.text = "Name - \(selectedPerson?.name ?? "")"
        originalNmaeLabel.text = "Original Name - \(selectedPerson?.originalName ?? "")"
        if selectedPerson?.gender == 1{
            genderLabel.text = "Gender - Female"
        }else{
            genderLabel.text = "Gender - Male"
        }
        departmentLabel.text = "Department -\(selectedPerson?.department ?? "")"
        popularityLabel.text = "Popularity - \(selectedPerson?.popularity ?? 0.0)"
        let baseurl = "https://image.tmdb.org/t/p/w500"
        let imageString = selectedPerson?.profilePath
        if imageString == nil{
            self.displayImageView.image = UIImage(named: "defaultphoto")
        }else{
            let fullUrl = baseurl+(imageString ?? "")
            let imageURL = URL(string: fullUrl)
            self.displayImageView
                .sd_setImage(
                    with: imageURL,
                    placeholderImage: UIImage(named: "placeholder")
                )
        }
    }
    func getImages(){
        let id = selectedPerson?.id ?? 0
        let imagesURl = "https://api.themoviedb.org/3/person/\(id)/images?api_key=51f7fc3534a2a69b001e48ad59ec1b0c"
        let request = networkManager?.createRequest(with: imagesURl, method: .get, body: nil)
        if let request = request{
            networkManager?
                .request(request, decodeTo: ImagesResponse.self, completion: { result in
                    switch result{
                    case .failure(let error) :
                        print(error)
                    case .success(let response) :
                        DispatchQueue.main.async {
                            self.selectedPersonImages = response.profiles
                            self.imagesCollectionView.reloadData()
                            self.knownForCollectionView.reloadData()
                        }
                    }
                })
        }
    }
}
