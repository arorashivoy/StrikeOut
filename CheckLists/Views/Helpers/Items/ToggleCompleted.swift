//
//  ToggleCompleted.swift
//  CheckLists
//
//  Created by Shivoy Arora on 16/06/21.
//

import SwiftUI

struct ToggleCompleted: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage(StorageString.compAsked.rawValue) var compAsked: Bool = false
    @State private var scaleAnimation: Bool = false
    @State private var compOption: Bool = false
    
    var item: CheckList.Items
    var indexList: Int
    
    var body: some View {
        if indexList <= (modelData.checkLists.count - 1) {
            if let index = modelData.checkLists[indexList].items.firstIndex(where: {$0.id == item.id}) {
                
                Image(systemName: item.isCompleted ? "checkmark.circle.fill":"circle")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(item.isCompleted ? modelData.checkLists[indexList].color:.gray)
                    .scaleEffect(scaleAnimation ? 1.5 : 1)
                    .onTapGesture(perform: {
                        withAnimation(.spring(dampingFraction: 0.25, blendDuration: 0.20)){
                            modelData.checkLists[indexList].items[index].isCompleted.toggle()
                            scaleAnimation = true
                        }
                        
                        if !compAsked{
                            compOption.toggle()
                            
                        }
                        
                        if modelData.checkLists[indexList].items[index].isCompleted {
                            ///remove notification
                            AppNotification().remove(list: modelData.checkLists[indexList], itemID: item.id)
                            
                        }
                    })
                    .sheet(isPresented: $compOption, content: {
                        CompletedOption(compOption: $compOption, indexList: indexList)
                            .environmentObject(modelData)
                            .onAppear(){
                                compAsked = true
                            }
                    })
                    .onChange(of: scaleAnimation) { val in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                            withAnimation(.spring(dampingFraction: 0.25, blendDuration: 0.20)) {
                                scaleAnimation = false
                            }
                        }
                    }
            }
        }
    }
}

struct ToggleCompleted_Previews: PreviewProvider {
    static var previews: some View {
        ToggleCompleted(item: ModelData().checkLists[0].items[0], indexList: 0)
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
