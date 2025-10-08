//
//  AlbumsDataService.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 13.09.2025.
//

/*
 MVC (Model-View-Controller)
 Роли:
 
 Model: Данные и бизнес-логика. Уведомляет наблюдателей (чаще всего View) об изменениях.
 
 View: Отображает данные пользователю. Пассивно получает данные от Модели и рисует их. В классической MVC View также может напрямую слушать изменения Model (через паттерн "Наблюдатель").
 
 Controller: Обрабатывает пользовательский ввод (нажатия кнопок, клики). Принимает решение о том, какую Модель изменить и какую Вью обновить. Является "клеем" между View и Model.
 
 Взаимодействие:
 
 Пользователь взаимодействует с View (кликает по кнопке).
 
 View перенаправляет это действие в Controller ("Пользователь нажал 'Сохранить'").
 
 Controller обрабатывает действие, работает с Model (обновляет или запрашивает данные).
 
 Model изменяется и уведомляет всех подписанных наблюдателей (в т.ч. View) о своем изменении.
 
 View, будучи наблюдателем, получает уведомление, запрашивает новые данные из Model и перерисовывает себя.
 
 Ключевой момент: Связь между View и Model есть (часто через наблюдателя).
 */

protocol AlbumsDataServiceProtocol {
    func getAllSections() -> [AlbumSection]
    func getSection(at index: Int) -> AlbumSection?
    func getSectionType(at index: Int) -> SectionType?
}

class AlbumsDataService: AlbumsDataServiceProtocol {
    
    func getAllSections() -> [AlbumSection] {
        return [
            createMyAlbumsSection(),
            createSharedAlbumsSection(),
            createMediaTypesSection(),
            createOtherSection()
        ]
    }
    
    func createMyAlbumsSection() -> AlbumSection {
        return AlbumSection (
            header: SectionHeader(
                title: "My Albums",
                buttonTitle: "See All"
            ),
            type: .myAlbums,
            items: MyAlbum.myAlbums
        )
    }
    
    func createSharedAlbumsSection() -> AlbumSection {
        return AlbumSection(
            header: SectionHeader(
                title: "Shared Albums",
                buttonTitle: "See All"
            ),
            type: .sharedAlbums,
            items: [
                FirstSharedAlbum.firstSharedAlbum
            ] + SharedAlbum.sharedAlbums
        )
    }
    
    func createMediaTypesSection() -> AlbumSection {
        return AlbumSection(
            header: SectionHeader(
                title: "Media Types",
                buttonTitle: nil
            ),
            type: .mediaTypes,
            items: MediaAndOther.mediaTypes
        )
    }
    
    func createOtherSection() -> AlbumSection {
        return AlbumSection(
            header: SectionHeader(
                title: "Other",
                buttonTitle: nil
            ),
            type: .other,
            items: MediaAndOther.otherType
        )
    }
    
    func getSection(at index: Int) -> AlbumSection? {
        let sections = getAllSections()
        guard index < sections.count else { return nil }
        return sections[index]
    }
    
    func getSectionType(at index: Int) -> SectionType? {
        return getSection(at: index)?.type
    }
    
}
