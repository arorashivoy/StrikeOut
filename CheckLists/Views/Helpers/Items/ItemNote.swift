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
            /// This transparent text is to make the text editor size dynamic in ScrollView
            Text(editItem.note)
                .font(.body)
                .opacity(0)
                .padding(.all, 5)
            
            if editItem.note.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""{
                Text("Put your thoughts into words")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding([.leading, .top], 5.0)
            }
            
            TextEditor(text: $editItem.note)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

struct ItemNote_Previews: PreviewProvider {
    static var previews: some View {
        ItemNote(editItem: .constant(CheckList.data.items[0]))
            .environmentObject(ModelData())
    }
}
