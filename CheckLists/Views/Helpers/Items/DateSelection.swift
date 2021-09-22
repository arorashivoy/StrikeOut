//
//  DateSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct DateSelection: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage(StorageString.notiAsked.rawValue) var notiAsked: Bool = false
    @State var dueDate: Date
    @State var dueTime: Date
    @State var notiPermission: Bool = false
    @Binding var editItem: CheckList.Items
    
    var indexList: Int
    
    var body: some View {
        ///Date toggle
        Toggle(isOn: $editItem.haveDueDate, label: {
            Text("Date")
        })
        .onChange(of: editItem.haveDueDate) { val in
            if val {
                ///when date is toggled on
                dueDate = editItem.dueDate ?? Date()
                
                editItem.dueDate = setDateTime(date: dueDate, time: modelData.checkLists[indexList].defaultTime)
                
                ///To ask for notification permission if haven't asked before
                if !notiAsked {
                    notiPermission.toggle()
                }
                
            }else {
                ///when date is toggled off
                editItem.dueDate = nil
                
                dueDate = editItem.dueDate ?? Date()
                editItem.haveDueTime = false
                
            }
        }
        ///full screen cover for notification permission view
        .sheet(isPresented: $notiPermission, content: {
            NotificationPermission(notiPermission: $notiPermission, checkListColor: modelData.checkLists[indexList].color)
        })
        
        if editItem.haveDueDate {
            
            ///Date selector
            DatePicker("",
                       selection: $dueDate,
                       displayedComponents: .date)
                .onChange(of: dueDate) { val in
                    if editItem.haveDueTime {
                        editItem.dueDate = setDateTime(date: val, time: editItem.dueDate ?? modelData.checkLists[indexList].defaultTime)
                    }else {
                        editItem.dueDate = setDateTime(date: val, time: modelData.checkLists[indexList].defaultTime)
                    }
                    
                }
            
            ///Time Toggle
            Toggle(isOn: $editItem.haveDueTime, label: {
                Text("Time")
            })
            .onChange(of: editItem.haveDueTime) { val in
                if val {
                    ///when time is toggled on
                    dueTime = editItem.dueDate ?? Date()
                    
                    editItem.dueDate = setDateTime(date: dueDate, time: modelData.checkLists[indexList].defaultTime)
                    
                }else{
                    ///when time is toggled off
                    editItem.dueDate = setDateTime(date: dueDate, time: modelData.checkLists[indexList].defaultTime)
                    
                }
            }
            
            if editItem.haveDueTime {
                
                ///Time selector
                DatePicker("",
                           selection: $dueTime,
                           displayedComponents: .hourAndMinute)
                    .onChange(of: dueTime) { val in
                        
                        editItem.dueDate = setDateTime(date: dueDate, time: dueTime)

                    }
            }
        }
    }
}

func setDateTime(date: Date, time: Date) -> Date? {
    let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    let timeComp = Calendar.current.dateComponents([.hour, .minute], from: time)
    
    var timeComponents = DateComponents()
    
    timeComponents.hour = timeComp.hour
    timeComponents.minute = timeComp.minute
    timeComponents.day = dateComponents.day
    timeComponents.month = dateComponents.month
    timeComponents.year = dateComponents.year
    
    return Calendar.current.date(from: timeComponents)
}

struct DateSelection_Previews: PreviewProvider {
    static var previews: some View {
        DateSelection(dueDate: Date(), dueTime: Date(), editItem: .constant(CheckList.data.items[0]), indexList: 0)
            .environmentObject(ModelData())
    }
}
