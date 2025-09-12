//
//  Models.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 12.09.2025.
//

struct MyAlbum: Hashable {
    let imageName: String
    let title: String
    let count: Int
}

struct FirstSharedAlbum: Hashable {
    let imageNames: [String]
    let title: String
    let subtitle: String
}

struct SharedAlbum: Hashable {
    let imageName: String
    let title: String
    let subtitle: String
}

struct MediaAndOther: Hashable {
    let imageName: String
    let title: String
    let count: Int
    let chevronName: String
}

enum AlbumItem: Hashable {
    case myAlbum(MyAlbum)
    case firstSharedAlbum(FirstSharedAlbum)
    case sharedAlbum(SharedAlbum)
    case mediaType(MediaAndOther)
    case other(MediaAndOther)
    
    var id: String {
        switch self {
        case .myAlbum(let album): return "myAlbum_\(album.title)"
        case .firstSharedAlbum(let album): return "firstShared_\(album.title)"
        case .sharedAlbum(let album): return "sharedAlbum_\(album.title)"
        case .mediaType(let media): return "mediaType_\(media.title)"
        case .other(let other): return "utility_\(other.title)"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
        lhs.id == rhs.id
    }
}

struct AlbumSection: Hashable {
    let header: SectionHeader  // Заголовок секции
    let type: SectionType      // Тип секции (для layout)
    let items: [AlbumItem]     // ✅ Массив ВСЕХ ячеек этой секции
}

// MARK: - Sections

enum SectionType: String, CaseIterable {
    case myAlbums = "My Albums"
    case sharedAlbums = "Shared Albums"
    case mediaTypes = "Media Types"
    case other = "Other"
}

//MARK: - Header

struct SectionHeader: Hashable {
    let title: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    
    init(
        title: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: SectionHeader, rhs: SectionHeader) -> Bool {
        lhs.title == rhs.title
    }
}
