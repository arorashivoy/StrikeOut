//
//  ItemRow.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 03/09/21.
//

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage(StorageString.colorSchemes.rawValue) var colorSchemes: AppColorScheme = AppColorScheme.system
    @State private var showInfo: Bool = false
    @Binding var draftItem: CheckList.Items
    @Binding var deniedAlert: Bool
    
    var item: CheckList.Items
    var indexList: Int
    
    var body: some View {
        if indexList <= (modelData.checkLists.count - 1) {
            if let index = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == item.id}) {
                
                HStack{
                    
                    /// Completed button
                    ToggleCompleted(item: item, indexList: indexList)
                        .environmentObject(modelData)
                    
                    /// Item name
                    itemName
                    
                    Spacer()
                    
                    /// Flag icon
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
                    
                    /// quantity
                    if modelData.checkLists[indexList].showQuantity {
                        
                        Text("\(item.itemQuantity)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding()
                    }
                    
                    /// info button
                    AddInfoButton(showInfo: $showInfo, draftItem: $draftItem, checkList: modelData.checkLists[indexList], item: item)
                        .sheet(isPresented: $showInfo) {
                            ItemInfo(showInfo: $showInfo, draftItem: $draftItem, deniedAlert: $deniedAlert, indexList: indexList)
                                .environmentObject(modelData)
                                .preferredColorScheme(setColorScheme())
                            
                        }
                    
                }
            }
        }
    }
    
    var itemName: some View {
        VStack(alignment: .leading) {
            Text(item.itemName)
                .foregroundColor(item.isCompleted ? .secondary:.primary)
                .strikethrough(item.isCompleted)
                .font(.body)
            
            if let _ = item.dueDate {
                Text(dateFormat(date: item.dueDate!, item: item))
                    .font(.caption)
                    .foregroundColor(colorChoose(date: item.dueDate!) )
            }
        }
        .padding()
    }
    
    /// To set color scheme which the user chooses
    /// - Returns: colorScheme
    func setColorScheme() -> ColorScheme? {
        switch colorSchemes {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
}


/// set date format in the item name
/// - Parameters:
///   - date: item's due date
///   - item: item
/// - Returns: formatted date
func dateFormat(date: Date, item: CheckList.Items) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    if item.haveDueTime {
        formatter.timeStyle = .short
    }
    
    return formatter.string(from: date)
}


/// choose color of the date depending on weather the due date has passed
/// - Parameter date: due date of the item
/// - Returns: Color of the date in item name
func colorChoose(date: Date) -> Color {
    if Date() > date {
        return .red
    }else {
        return .secondary
    }
}


struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(draftItem: .constant(CheckList.Items.data), deniedAlert: .constant(false), item: CheckList.Items.data, indexList: 0)
            .environmentObject(ModelData())
//            .preferredColorScheme(.dark)
    }
}
