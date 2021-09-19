//
//  CompletedOption.swift
//  CheckLists
//
//  Created by Shivoy Arora on 09/08/21.
//

import SwiftUI

struct CompletedOption: View {
    @AppStorage(StorageString.defaultCompleted.rawValue) var defaultCompleted: Bool = false
    @Binding var compOption: Bool
    
    var listColor: Color
    
    var body: some View {
        VStack{
            /// toolbar
            HStack{
                Button{
                    compOption = false
                }label: {
                    Text("Cancel")
                        .foregroundColor(listColor)
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
                .foregroundColor(listColor)
            
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
                defaultCompleted = true
                compOption = false
            }label: {
                Text("Show Completed by Default")
                    .frame(width: 170, height: 60, alignment: .center)
                    .foregroundColor(listColor.accessibleFontColor)
                    .background(listColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
            }
        }
        .padding()
    }
}

struct CompletedOption_Previews: PreviewProvider {
    static var previews: some View {
        CompletedOption(compOption: .constant(true), listColor: .blue)
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
