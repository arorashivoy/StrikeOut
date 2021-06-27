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
//	var color:
	var description: String
	var showQuantity: Bool
	
	private var imageName: String
	var image: Image {
		Image(systemName: "\(imageName)")
	}
	
	var items: [Items]
	
	struct Items: Hashable, Codable, Identifiable {
		
		var id = UUID()
		var itemName: String
		var itemQuantity: Int
		var isCompleted: Bool
		var note: String
		
		static let `default` = Items(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, itemName: "", itemQuantity: 0, isCompleted: false, note: "")
        
        static let data = Items(id: UUID(), itemName: "Donate", itemQuantity: 0, isCompleted: false, note: "Support me by donating")
		
	}
	
	static let `default` = CheckList(listName: "", id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, description: "", showQuantity: false, imageName: "list.bullet", items: [Items.default])
    
    static let data = CheckList(listName: "To Do", id: UUID(), description: "", showQuantity: false, imageName: "list.bullet", items: [Items.data])
	
}
