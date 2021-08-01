//
//  ItemName.swift
//  CheckLists
//
//  Created by Shivoy Arora on 28/07/21.
//

import SwiftUI

struct ItemName: View {
    var item: CheckList.Items
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(item.itemName)
                .foregroundColor(item.isCompleted ? .secondary:.primary)
                .font(.body)
            if let _ = item.dueDate {
                Text(dateFormat(date: item.dueDate!, item: item))
                    .font(.caption)
                    .foregroundColor(colorChoose(date: item.dueDate!) ? .secondary : .red )
            }
        }
        .padding()
        
    }
}
func dateFormat(date: Date, item: CheckList.Items) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    if item.haveDueTime {
        formatter.timeStyle = .short
    }
    
    return formatter.string(from: date)
}

func colorChoose(date: Date) -> Bool {
    if Date() > date {
        return false
    }else {
        return true
    }
}

struct ItemName_Previews: PreviewProvider {
    static var previews: some View {
        ItemName(item: ModelData().checkLists[0].items[0])
        
    }
}
