//
//  List.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import Foundation
import SwiftUI

struct CheckList: Hashable,Codable, Identifiable {
	var listName: String
	var id = UUID()
	var color: Color
	var description: String
	var showQuantity: Bool
	
	var imageName: String
	var image: Image {
		Image(systemName: imageName)
	}
	
	var items: [Items]
	
	struct Items: Hashable, Codable, Identifiable {
		
		var id = UUID()
		var itemName: String
		var itemQuantity: Int
		var isCompleted: Bool
		var note: String
        
///     setting some inbuilt item
		static let `default` = Items(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, itemName: "", itemQuantity: 0, isCompleted: false, note: "")
        
        static let data = Items(id: UUID(), itemName: "Donate", itemQuantity: 0, isCompleted: false, note: "Support me by donating")
		
	}
    
/// setting enum for images name
    enum Images: String, CaseIterable, Identifiable {
        case bulletList = "list.bullet"
        case starList = "list.star"
        case numList = "list.number"
        case indentList = "list.bullet.indent"
        case note = "note"
        case noteText = "note.text"
        case terminal = "terminal.fill"
        case calendar = "calendar"
        case bookFill = "book.fill"
        case newpaperFill = "newspaper.fill"
        case booksVerticalFill = "books.vertical.fill"
        case bookClosedFill = "book.closed.fill"
        case charBook = "character.book.closed"
        case charBookFill = "character.book.closed.fill"
        case textBook = "text.book.closed"
        case greetingCard = "greetingcard"
        case bookmark = "bookmark"
        case bookmarkFill = "bookmark.fill"
        case paperclip = "paperclip"
        case link = "link"
        case docText = "dock.text.below.ecg.fill"
        case personFill = "person.fill"
        case personCircle = "person.crop.circle"
        case personSquare = "person.crop.square"
        case personStack = "rectangle.stack.person.crop"
        case person2 = "person.2.fill"
        case person3 = "person.3.fill"
        case person2Stack = "person.2.square.stack"
        case sqStack = "square.stack.fill"
        case id = "square.and.at.rectangle"
        case command = "command"
        case powersleep = "powersleep"
        case globe = "globe"
        case network = "network"
        case sunMin = "sun.min"
        case sunMax = "sun.max"
        case zzz = "zzz"
        case sparkle = "sparkle"
        case sparkles = "sparkles"
        case cloud = "cloud.fill"
        case fileMenu = "filemenu.and.selection"
        case keyboard = "keyboard"
        case rectOffgrid = "rectangle.3.offgrid"
        case sqGrid4 = "square.grid.2x2"
        case sqGrid6 = "square.grid.3x2"
        case rectGrid = "rectangle.grid.1x2"
        case circleGrid = "circle.grid.2x2"
        case heartText = "heart.text.square"
        case location = "location.fill"
        case tag = "tag.fill"
        case phone = "phone.fill"
        case videoCall = "video.fill"
        case envelope = "envelope.fill"
        case mailStack = "mail.stack.fill"
        case bag = "bag.fill"
        case creditCard = "creditcard.fill"
        case wallet = "wallet.pass.fill"
        case hammer = "hammer.fill"
        case scroll = "scroll.fill"
        case printer = "printer.fill"
        case caseFill = "case.fill"
        case puzzlePiece = "puzzlepiece.fill"
        case house = "house.fill"
        case lock = "lock.fill"
        case key = "key.fill"
        case mapPin = "mappin"
        case map = "map.fill"
        case cpu = "cpu"
        case car = "car.fill"
        case bus = "bus.fill"
        case tram = "tram.fill"
        case bicycle = "bicycle"
        case bed = "bed.double.fill"
        case cross = "cross.fill"
        case leaf = "leaf.fill"
        case shield = "shield.fill"
        case clock = "clock.fill"
        
        var id: String {self.rawValue}
        
    }

/// setting some inbuilt checklists
    static let `default` = CheckList(listName: "", id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, color: .blue, description: "", showQuantity: false, imageName: "list.bullet", items: [Items.default])
    
    static let data = CheckList(listName: "To Do", id: UUID(), color: .blue, description: "", showQuantity: false, imageName: "list.bullet", items: [Items.data])
	
}
