//
//  AlbumDataManager.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 12.09.2025.
//

protocol AlbumsDataProtocol {
    func getSections() -> [AlbumSection]
    func getSection(at index: Int) -> AlbumSection?
}

class AlbumsDataManager: AlbumsDataProtocol {
    
    func getSections() -> [AlbumSection] {
        return AlbumSection.allSections
    }
    
    func getSection(at index: Int) -> AlbumSection? {
        guard index < AlbumSection.allSections.count else { return nil }
        return AlbumSection.allSections[index]
    }
}

