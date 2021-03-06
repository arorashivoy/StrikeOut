//
//  ListDescription.swift
//  CheckLists
//
//  Created by Shivoy Arora on 15/08/21.
//

import SwiftUI

struct ListDescription: View {
    @Binding var draftList: CheckList
    
    var body: some View {
        
        ZStack(alignment:.topLeading){
            /// This transparent text is to make the text editor size dynamic in ScrollView
            Text(draftList.description)
                .font(.body)
                .opacity(0)
                .padding(.all, 5)
            
            if draftList.description.trimmingCharacters(in: [" "]) == "" {
                Text("What's on your mind")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding([.top, .leading], 5.0)
            }
            
            TextEditor(text: $draftList.description)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

struct ListDescription_Previews: PreviewProvider {
    static var previews: some View {
        ListDescription(draftList: .constant(CheckList.data))
    }
}
