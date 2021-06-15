//
//  ContentView.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var modelData: ModelData
    var body: some View {
        ListSelection()
			.environmentObject(modelData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
			.environmentObject(ModelData())
    }
}
