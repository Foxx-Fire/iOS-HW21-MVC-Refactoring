//
//  AlbumsView.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 13.09.2025.
//

import UIKit

final class AlbumsView: UIView {
    
    // MARK: - UI Elements
    
    let collectionView: UICollectionView
    
    // MARK: - Init
    
    init(layout: UICollectionViewLayout) {
        self.collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
