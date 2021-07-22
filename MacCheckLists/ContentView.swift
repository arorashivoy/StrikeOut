//
//  ContentView.swift
//  MacCheckLists
//
//  Created by Shivoy Arora on 03/07/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ListSelection()
            .environmentObject(modelData)
            .frame(minWidth: 700, minHeight: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
