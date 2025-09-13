//
//  AlbumDataManager.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 12.09.2025.
//
import Foundation

protocol AlbumsDataProtocol {
    func getSections() -> [AlbumSection]
    func getSection(at index: Int) -> AlbumSection?
    func getSectionType(at index: Int) -> SectionType?
}

class AlbumsDataManager: AlbumsDataProtocol {
    
    private let dataService: AlbumsDataServiceProtocol
    
    init(dataService: AlbumsDataServiceProtocol = AlbumsDataService()) {
        self.dataService = dataService
    }
    
    func getSections() -> [AlbumSection] {
        return dataService.getAllSections()
    }
    
    func getSection(at index: Int) -> AlbumSection? {
        let sections = getSections()
        guard index < sections.count else { return nil }
        return sections[index]
    }
    
    func getSectionType(at index: Int) -> SectionType? {
        return getSection(at: index)?.type
    }
}

