//
//  CompletedOption.swift
//  CheckLists
//
//  Created by Shivoy Arora on 09/08/21.
//

import SwiftUI

struct CompletedOption: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var compOption: Bool
    
    var indexList: Int
    
    var body: some View {
        if indexList <= (modelData.checkLists.count - 1) {
            VStack{
                /// toolbar
                HStack{
                    Button{
                        compOption = false
                    }label: {
                        Text("Cancel")
                            .foregroundColor(modelData.checkLists[indexList].color)
                    }
                    .padding()
                    Spacer()
                }
                
                /// Animation
                LottieView(name: "CompletedOptionAnimation", loopMode: .loop)
                    .frame(width: 300, height: 300, alignment: .center)
                Text("Congratulations \n on completing your first task")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(modelData.checkLists[indexList].color)
                
                Text("By default the completed options are hidden, but you can change it any time by clicking")
                    .foregroundColor(.primary)
                    .padding([.leading, .trailing, .top])
                    .padding(.bottom, 3)
                Text("\(Image(systemName: "ellipsis.circle")) Menu ")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding([.leading, .trailing, .bottom])
                
                Spacer()
                
                /// Show Completed button
                Button{
                    modelData.checkLists[indexList].showCompleted = true
                    compOption = false
                }label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 160, height: 50, alignment: .center)
                            .foregroundColor(modelData.checkLists[indexList].color)
                        Text("Show Completed")
                            .foregroundColor(modelData.checkLists[indexList].color.accessibleFontColor)
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

struct CompletedOption_Previews: PreviewProvider {
    static var previews: some View {
        CompletedOption(compOption: .constant(true), indexList: 0)
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
