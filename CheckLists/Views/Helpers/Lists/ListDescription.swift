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
            TextEditor(text: $draftList.description)
                .font(.body)
                .foregroundColor(.secondary)
            if draftList.description.trimmingCharacters(in: [" "]) == "" {
                Text("Description")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding([.top, .leading], 5.0)
            }
        }
        .padding(.leading)
    }
}

struct ListDescription_Previews: PreviewProvider {
    static var previews: some View {
        ListDescription(draftList: .constant(CheckList.data))
    }
}
