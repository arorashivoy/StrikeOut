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
	var id: Int
	var description: String?
	var showQuantity: Bool
	
	private var imageName: String
	var image: Image {
		Image(systemName: "\(imageName)")
	}
	
	var isPin: Bool
	
	var items: [Items]
	
	struct Items: Hashable, Codable,Identifiable {
		
		var id: Int
		var itemName: String
		var itemQuantity: Int?
		var isCompleted: Bool
		var note: String
		
		static let `default` = Items(id: 0, itemName: "", itemQuantity: 0, isCompleted: false, note: "")
		
	}
}
