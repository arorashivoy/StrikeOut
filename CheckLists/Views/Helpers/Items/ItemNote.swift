//
//  ItemNote.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct ItemNote: View {
    @Binding var editItem: CheckList.Items
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $editItem.note)
                .font(.body)
                .foregroundColor(.secondary)
            if editItem.note.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""{
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
        ItemNote(editItem: .constant(ModelData().checkLists[0].items[0]))
            .environmentObject(ModelData())
    }
}
