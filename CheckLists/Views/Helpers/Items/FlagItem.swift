//
//  FlagItem.swift
//  CheckLists
//
//  Created by Shivoy Arora on 09/08/21.
//

import SwiftUI

struct FlagItem: View {
    @EnvironmentObject var modelData: ModelData
    
    var item: CheckList.Items
    var indexList: Int
    
    var body: some View {
        if indexList <= (modelData.checkLists.count - 1) {
            if let index = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == item.id}) {
                
                if item.flagged {
                    Image(systemName: "flag.fill")
                        .foregroundColor(modelData.checkLists[indexList].color)
                        .padding(.trailing, 0)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.25)) {
                                modelData.checkLists[indexList].items[index].flagged = false
                            }
                        }
                }
            }
        }
    }
}

struct FlagItem_Previews: PreviewProvider {
    static var previews: some View {
        FlagItem(item: ModelData().checkLists[0].items[0], indexList: 0)
            .environmentObject(ModelData())
    }
}
