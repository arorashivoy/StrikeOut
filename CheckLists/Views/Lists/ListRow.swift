//
//  ListRow.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI

struct ListRow: View {
	var checkList: CheckList
    var body: some View {
		HStack{
			checkList.image
                .font(.title)
                .scaledToFit()
                .foregroundColor(checkList.color)
			Text(checkList.listName)
			Spacer()
		}
		.padding()
    }
}

struct ListRow_Previews: PreviewProvider {
	static var checkLists = ModelData().checkLists
    static var previews: some View {
		Group {
			ListRow(checkList: checkLists[0])
			ListRow(checkList: checkLists[1])
		}
		.previewLayout(.fixed(width: 300, height: 70))
		.preferredColorScheme(.dark)
		
    }
}
