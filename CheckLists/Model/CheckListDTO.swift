//
//  CheckListDTO.swift
//  CheckLists
//
//  Created by Shivoy Arora on 09/08/21.
//

import Foundation
import SwiftUI


// when I add new variables I can make them optional so that people don't have to reinstall the app to prevent fatal key not found error
/// Data Model
/// 
/// This struct is to parse JSON
struct CheckListDTO: Hashable, Codable {
    var listName: String
    var id = UUID()
    var color: Color
    var description: String = ""
    var showQuantity: Bool = false
    var showCompleted: Bool = false
    var completedAtBottom: Bool = false
    var isPinned: Bool = false
    var defaultTime: Date = defTimeMaker(hour: 8, minute: 0)
    
    var imageName: String
    
    var items: [Items]
    
    struct Items: Hashable, Codable {
        
        var id = UUID()
        var itemName: String
        var itemQuantity: Int = 0
        var isCompleted: Bool = false
        var note: String = ""
        var dueDate: Date?
        var haveDueDate: Bool = false
        var haveDueTime: Bool = false
        var flagged: Bool?
        
    }
}

// when I don't need optionals in the main struct I could map them with default values in this struct
/// Data Model to Domain model Mapping
///
/// This struct Map CheckListDTO to CheckList
/// 
/// For decoding JSON to checkList
struct CheckListDTOMapper {
    
    /// Mapping Items
    /// - Parameter dtoItems: Lists of items decoded from json ( [CheckListDTO.Items] )
    /// - Returns: List of items that is for domain model
    static func mapItems(_ dtoItems: [CheckListDTO.Items]) -> [CheckList.Items] {
        var itemsList: [CheckList.Items] = []
        
        for dtoItem in dtoItems {
            itemsList.append( CheckList.Items(id: dtoItem.id,
                                         itemName: dtoItem.itemName,
                                         itemQuantity: dtoItem.itemQuantity,
                                         isCompleted: dtoItem.isCompleted,
                                         note: dtoItem.note,
                                         dueDate: dtoItem.dueDate,
                                         haveDueDate: dtoItem.haveDueDate,
                                         haveDueTime: dtoItem.haveDueTime,
                                         flagged: dtoItem.flagged ?? false)
            )
        }
        
        return itemsList
    }

    /// Mapping CheckLIsts
    /// - Parameter dtos: Lists decoded from json( [CheckListDTO] )
    /// - Returns: List that is for domain model
    static func map(_ dtos: [CheckListDTO]) -> [CheckList] {
        var checkLists: [CheckList] = []
        
        for dto in dtos {
            checkLists.append( CheckList(listName: dto.listName,
                                        id: dto.id,
                                        color: dto.color,
                                        description: dto.description,
                                        showQuantity: dto.showQuantity,
                                        showCompleted: dto.showQuantity,
                                        completedAtBottom: dto.completedAtBottom,
                                        isPinned: dto.isPinned,
                                        defaultTime: dto.defaultTime,
                                        imageName: dto.imageName,
                                        items: self.mapItems(dto.items))
            )
        }
        return checkLists
    }
}

/// Domain model to Data model
/// 
/// This struct Map CheckList to CheckListDTO
///
/// For encoding it to json file
struct CheckListMapper {
    
    /// Mapping Items
    /// - Parameter items: List of items mapped to CheckListDTO.Items for encoding
    /// - Returns: list of items that is  of data model
    static func mapItems(_ items: [CheckList.Items]) -> [CheckListDTO.Items] {
        var itemsList: [CheckListDTO.Items] = []
        
        for item in items {
            itemsList.append(
                CheckListDTO.Items(id: item.id,
                                   itemName: item.itemName,
                                   itemQuantity: item.itemQuantity,
                                   isCompleted: item.isCompleted,
                                   note: item.note,
                                   dueDate: item.dueDate,
                                   haveDueDate: item.haveDueDate,
                                   haveDueTime: item.haveDueTime,
                                   flagged: item.flagged)
            )
        }
        return itemsList
    }
    
    
    /// Mapping CheckLists
    /// - Parameter checkLists: List mapped to CheckListsDTO for encoding
    /// - Returns: list that is for data model
    static func map(_ checkLists: [CheckList]) -> [CheckListDTO] {
        var checkListsDto: [CheckListDTO] = []
        
        for checkList in checkLists {
            checkListsDto.append(
                CheckListDTO(listName: checkList.listName,
                             id: checkList.id,
                             color: checkList.color,
                             description: checkList.description,
                             showQuantity: checkList.showQuantity,
                             showCompleted: checkList.showCompleted,
                             completedAtBottom: checkList.completedAtBottom,
                             isPinned: checkList.isPinned,
                             defaultTime: checkList.defaultTime,
                             imageName: checkList.imageName,
                             items: self.mapItems(checkList.items))
            )
        }
        return checkListsDto
    }
}
