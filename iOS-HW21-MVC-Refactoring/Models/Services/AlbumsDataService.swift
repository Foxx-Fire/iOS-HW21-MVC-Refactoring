//
//  AlbumsDataService.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 13.09.2025.
//

protocol AlbumsDataServiceProtocol {
    func getAllSections() -> [AlbumSection]
}

class AlbumsDataService: AlbumsDataServiceProtocol {
    
    func getAllSections() -> [AlbumSection] {
        return [
            // My Albums
            AlbumSection(
                header: SectionHeader(
                    title: "My Albums",
                    buttonTitle: "See All"
                ),
                type: .myAlbums,
                items: MyAlbum.myAlbums
            ),
            
            // Shared Albums
            AlbumSection(
                header: SectionHeader(
                    title: "Shared Albums",
                    buttonTitle: "See All"
                ),
                type: .sharedAlbums,
                items: [
                    FirstSharedAlbum.firstSharedAlbum
                ] + SharedAlbum.sharedAlbums
            ),
            
            // Media Types
            AlbumSection(
                header: SectionHeader(
                    title: "Media Types",
                    buttonTitle: nil
                ),
                type: .mediaTypes,
                items: MediaAndOther.mediaTypes
            ),
            
            // Other
            AlbumSection(
                header: SectionHeader(
                    title: "Other",
                    buttonTitle: nil
                ),
                type: .other,
                items: MediaAndOther.otherType
            )
        ]
    }
}
