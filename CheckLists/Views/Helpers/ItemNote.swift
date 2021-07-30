//
//  ItemNote.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct ItemNote: View {
    @EnvironmentObject var modelData: ModelData
    var indexList: Int
    var index: Int
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $modelData.checkLists[indexList].items[index].note)
                .font(.body)
                .foregroundColor(.secondary)
            if modelData.checkLists[indexList].items[index].note.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""{
                Text("Notes")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding([.top, .leading], 5.0)
            }
        }
    }
}

struct ItemNote_Previews: PreviewProvider {
    static var previews: some View {
        ItemNote(indexList: 0, index: 0)
            .environmentObject(ModelData())
    }
}
