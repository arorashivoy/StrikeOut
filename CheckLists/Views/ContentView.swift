//
//  ContentView.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
	@EnvironmentObject var modelData: ModelData
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ListHost()
			.environmentObject(modelData)
            .onChange(of: scenePhase, perform: { phase in
                if phase == .inactive {
                    modelData.save()
                }
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(ModelData())
        }
    }
}
