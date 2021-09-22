//
//  AddInfoButton.swift
//  CheckLists
//
//  Created by Shivoy Arora on 09/08/21.
//

import SwiftUI

struct AddInfoButton: View {
    @Binding var showInfo: Bool
    @Binding var draftItem: CheckList.Items
    
    var checkList: CheckList
    var item: CheckList.Items
    
    var body: some View {
        Button{
            withAnimation(.spring(dampingFraction: 0.25, blendDuration: 2)){
                showInfo.toggle()
            }
            draftItem = item
        } label: {
            if item != CheckList.Items.default {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
            }else {
                Label("Add Item", systemImage: "plus")
                    .font(.body)
            }
            
        }
        .foregroundColor(checkList.color)
        .scaleEffect((draftItem == item && showInfo) ? 1.5 : 1)
    }
}

struct AddInfoButton_Previews: PreviewProvider {
    static var previews: some View {
        AddInfoButton(showInfo: .constant(false), draftItem: .constant(CheckList.Items.data), checkList: CheckList.data, item: CheckList.data.items[0])
    }
}
