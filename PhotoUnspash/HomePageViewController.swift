//
//  ViewController.swift
//  PhotoUnspash
//
//  Created by Владислав Наумов on 10.02.2024.
//

import UIKit

class HomePageViewController: UIViewController {
    
    lazy var mainView = HomePageView()
    lazy var mainModel = HomePageModel()
    private var timer: Timer?
    private var photos = [UnsplashPhoto]()
    var mainApiManager = ApiManager()
    var mainDataFetcher = DataFetcher()
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseId)
        self.setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchBarContr = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchBarContr
        searchBarContr.searchBar.delegate = self
    }
}
//    MARK: - UICollectionViewDataSource Methods

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseId, for: indexPath) as! CustomCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.frame.width/2 - 20, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(self, animated: true)
        print("Было нажатие")
    }
}

//    MARK: - UISearchBarDelegate Methods

extension HomePageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] _ in
            self.mainDataFetcher.fetchImages(searchWord: searchText) { [weak self]
                (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                self?.mainView.collectionView.reloadData()
            }
        })
    }
}
