//
//  SearchViewController.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 12.09.2025.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        setupNavigation()
    }
    
    // MARK: - Setup Methods
    
    func setupNavigation() {
        configureNavigation(title: Constants.Navigation.title)
    }
}

// MARK: - Constants

extension SearchViewController {
    enum Constants {
        static let backgroundColor: UIColor = .yellow
        
        enum Navigation {
            static let title = "Search"
        }
    }
}
