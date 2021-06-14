//
//  ListSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI

struct ListSelection: View {
	@EnvironmentObject var modelData: ModelData
	
	var body: some View {
		NavigationView {
			List(){
				ListRow(checkList: modelData.checkLists[0])
			}
		}
		.navigationTitle("Title")
		
	}
}

struct ListSelection_Previews: PreviewProvider {
	static var previews: some View {
        ListSelection()
			.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
			.environmentObject(ModelData())
    }
}
