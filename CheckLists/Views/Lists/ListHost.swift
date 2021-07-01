//
//  ListHost.swift
//  CheckLists
//
//  Created by Shivoy Arora on 19/06/21.
//

import SwiftUI

struct ListHost: View {
	@Environment(\.editMode) var listEdit
	@EnvironmentObject var modelData: ModelData
	
    var body: some View {
		ZStack(alignment: .topTrailing) {
			
			if listEdit?.wrappedValue == .inactive{
				
				ListSelection()
					.environmentObject(modelData)
				
			}else {
				EditSelection(listEdit: listEdit)
                    .environmentObject(modelData)
            }
			HStack{
                Spacer()
                if modelData.listSelector == nil {
                    EditButton()
                        .padding()
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct ListHost_Previews: PreviewProvider {
    static var previews: some View {
        ListHost()
			.environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
