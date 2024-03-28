//
//  HomePageView.swift
//  PhotoUnspash
//
//  Created by Владислав Наумов on 10.02.2024.
//

import UIKit

class HomePageView: UIView {
    
    public var collectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(collectionView)
    }
}
