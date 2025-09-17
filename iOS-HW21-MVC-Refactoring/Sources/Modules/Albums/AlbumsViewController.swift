//
//  AlbumsViewController.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 12.09.2025.
//

import UIKit

final class AlbumsViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let dataService: AlbumsDataServiceProtocol
    
    private lazy var albumsView: AlbumsView = {
        let view = AlbumsView { [weak self] sectionIndex in
            return self?.getLayoutType(for: sectionIndex)
        }
        view.setupDataSource(dataSource: self)
        view.setupDelegate(delegate: self)
        return view
    }()
    
    //MARK: - Init
    init(dataService: AlbumsDataServiceProtocol) {
        self.dataService = dataService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = albumsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    func setupNavigation() {
        let addAction = UIAction { _ in
            print("Add button tapped in Albums")
        }
        
        configureNavigation(
            title: Constants.Navigation.title,
            showButton: true,
            buttonImage: Constants.Navigation.buttonImageName,
            buttonAction: addAction
        )
    }
    
    //MARK: - private methods
    /*
     Не переносите getLayoutType во View! Он должен остаться в контроллере, потому что:
     
     ✅ Использует dataService (логика данных)
     
     ✅ Принимает решения на основе данных
     
     ✅ Относится к бизнес-логике
     
     ✅ Не имеет отношения к отрисовке
     
     Текущая архитектура правильная!
     
     AI тоже против как и я
     */
    
    private func getLayoutType(for sectionIndex: Int) -> AlbumCompositionalLayout.LayoutType? {
        guard let sectionType = dataService.getSectionType(at: sectionIndex) else {
            return nil
        }
        
        switch sectionType {
        case .myAlbums:
            return .columns
        case .sharedAlbums:
            return .plain
        case .mediaTypes, .other:
            return .tableStyle
        }
    }
}

// MARK: - Constants
extension AlbumsViewController {
    enum Constants {
        enum Navigation {
            static let title = "Albums"
            static let buttonImageName = "plus"
        }
        
        static let backgroundColor: UIColor = .white
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Снимаем выделение с анимацией
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    // Определяет количество секций в коллекции
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataService.getAllSections().count
    }
    
    // Определяет количество ячеек в конкретной секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let albumSection = dataService.getSection(at: section) else { return 0 }
        return albumSection.items.count
    }
    
    // Создает и настраивает ячейку для конкретной позиции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = dataService.getSection(at: indexPath.section)?.items[indexPath.item] else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: item.cellIdentifier,
            for: indexPath
        )
        
        configureCell(cell: cell, cellItem: item)
        return cell
    }
    
    private func configureCell(
        cell: UICollectionViewCell,
        cellItem: CellItemProtocol
    ) {
        switch cellItem.cellIdentifier {
        case MyAlbumsCell.identifier:
            guard let cell = cell as? MyAlbumsCell,
                  let myAlbum = cellItem as? MyAlbum else { return }
            
            cell.configuration(model: myAlbum)
            
        case SharedAlbumsFirstCell.identifier:
            guard let cell = cell as? SharedAlbumsFirstCell,
                  let firstShared = cellItem as? FirstSharedAlbum else { return }
            
            cell.configuration(model: firstShared)
            
        case SharedAlbumsCell.identifier:
            guard let cell = cell as? SharedAlbumsCell,
                  let shared = cellItem as? SharedAlbum else { return }
            
            cell.configuration(model: shared)
            
        case MediaTypesCell.identifier:
            guard let cell = cell as? MediaTypesCell,
                  let media = cellItem as? MediaAndOther else { return }
            
            cell.configuration(model: media)
            
        case OtherAlbumsCell.identifier:
            guard let cell = cell as? OtherAlbumsCell,
                  let media = cellItem as? MediaAndOther else { return }
            
            cell.configuration(model: media)
        default:
            break
        }
    }
    
    //MARK: - настройки хэдера
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let albumSection = dataService.getSection(at: indexPath.section) else {
            return UICollectionReusableView()
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: AlbumsHeaderView.identifier,
            for: indexPath
        ) as? AlbumsHeaderView else {
            return UICollectionReusableView()
        }
        
        header.configure(
            title: albumSection.header.title,
            buttonTitle: albumSection.header.buttonTitle,
            buttonAction: { [weak self] in
                self?.handleHeaderButtonTap(for: indexPath.section)
            }
        )
        
        return header
    }
    
    private func handleHeaderButtonTap(for sectionIndex: Int) {
        guard let sectionType = dataService.getSectionType(
            at: sectionIndex
        ) else { return }
        
        switch sectionType {
        case .myAlbums:
            print("See All tapped for My Albums")
        case .sharedAlbums:
            print("See All tapped for Shared Albums")
        case .mediaTypes, .other:
            print("Button tapped for section: \(sectionType.rawValue)")
        }
    }
}





