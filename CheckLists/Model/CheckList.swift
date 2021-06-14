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
	
	private var imageName: String
	var image: Image {
		Image(imageName)
	}
	
	var isPin: Bool
	
	var items: [Items]
	
	struct Items: Hashable, Codable {
		var idItem: Int
		var itemName: String
//		var itemQuantity: Int?
		var note: String?
		
	}
}
