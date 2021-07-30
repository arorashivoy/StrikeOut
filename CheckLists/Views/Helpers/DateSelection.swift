//
//  DateSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 27/07/21.
//

import SwiftUI

struct DateSelection: View {
    @EnvironmentObject var modelData: ModelData
    @State var dueDate: Date
    @State var dueTime: Date
    
    var indexList: Int
    var index: Int
    
    var body: some View {
        ///Date toggle
        Toggle(isOn: $modelData.checkLists[indexList].items[index].haveDueDate, label: {
            Text("Date")
        })
        .onChange(of: modelData.checkLists[indexList].items[index].haveDueDate) { val in
            if val {
                ///when date is toggled on
                dueDate = modelData.checkLists[indexList].items[index].dueDate ?? Date()
                
                modelData.checkLists[indexList].items[index].dueDate = setDateTime(date: dueDate, time: modelData.checkLists[indexList].defaultTime)
                
                ///send notification
                AppNotification().schedule(item: modelData.checkLists[indexList].items[index])
                
                
            }
            else {
                ///when date is toggled off
                modelData.checkLists[indexList].items[index].dueDate = nil
                
                dueDate = modelData.checkLists[indexList].items[index].dueDate ?? Date()
                modelData.checkLists[indexList].items[index].haveDueTime = false
                
                ///removing notification request
                AppNotification().remove(ID: modelData.checkLists[indexList].items[index].id)
            }
        }
        
        if modelData.checkLists[indexList].items[index].haveDueDate {
            
            ///Date selector
            DatePicker("",
                       selection: $dueDate,
                       displayedComponents: .date)
                .onChange(of: dueDate) { val in
                    let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: val)
                    
                    if modelData.checkLists[indexList].items[index].haveDueTime {
                        modelData.checkLists[indexList].items[index].dueDate = Calendar.current.date(from: dateComponents)
                    }else {
                        modelData.checkLists[indexList].items[index].dueDate = setDateTime(date: val, time: modelData.checkLists[indexList].defaultTime)
                    }
                    
                    ///send notification
                    AppNotification().schedule(item: modelData.checkLists[indexList].items[index])
                    
                }
            
            ///Time Toggle
            Toggle(isOn: $modelData.checkLists[indexList].items[index].haveDueTime, label: {
                Text("Time")
            })
            .onChange(of: modelData.checkLists[indexList].items[index].haveDueTime) { val in
                if val {
                    ///when time is toggled on
                    dueTime = modelData.checkLists[indexList].items[index].dueDate ?? Date()
                    
                    modelData.checkLists[indexList].items[index].dueDate = setDateTime(date: dueDate, time: modelData.checkLists[indexList].defaultTime)
                    
                    ///send notification
                    AppNotification().schedule(item: modelData.checkLists[indexList].items[index])
                }else{
                    ///when time is toggled off
                    modelData.checkLists[indexList].items[index].dueDate = setDateTime(date: dueDate, time: modelData.checkLists[indexList].defaultTime)
                    
                    ///send notification
                    AppNotification().schedule(item: modelData.checkLists[indexList].items[index])
                    
                }
            }
            
            if modelData.checkLists[indexList].items[index].haveDueTime {
                
                ///Time selector
                DatePicker("",
                           selection: $dueTime,
                           displayedComponents: .hourAndMinute)
                    .onChange(of: dueTime) { val in
                        
                        modelData.checkLists[indexList].items[index].dueDate = setDateTime(date: dueDate, time: dueTime)
                        
                        ///send notification
                        AppNotification().schedule(item: modelData.checkLists[indexList].items[index])
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
        DateSelection(dueDate: Date(), dueTime: Date(), indexList: 0, index: 0)
            .environmentObject(ModelData())
    }
}
