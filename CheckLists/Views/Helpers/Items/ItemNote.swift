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
            
            /// This transparent text is to make the text editor size dynamic in ScrollView
            Text(editItem.note)
                .font(.body)
                .opacity(0)
                .padding(.all, 5)
            
            if editItem.note.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""{
                Text("Notes")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding([.leading, .top], 5.0)
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
