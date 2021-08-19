//
//  ImagePicker.swift
//  CheckLists
//
//  Created by Shivoy Arora on 19/08/21.
//

import SwiftUI

struct ImagePicker: View {
    @Binding var draftList: CheckList
    @Binding var imagePicker: Bool
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                
                Button{
                    withAnimation {
                        imagePicker = false
                    }
                }label: {
                    Text("Done")
                }
                .padding([.top, .trailing])
            }
            Divider()
                .brightness(0.5)
                .padding([.leading, .trailing], 7)
            
            Picker("Choose the thumbnail image", selection: $draftList.imageName){
                ForEach(CheckList.Images.allCases){
                    Image(systemName: "\($0.rawValue)").tag($0)
                        .foregroundColor(.primary)
                }
            }
        }
        .background(Color.primary.colorInvert())
        .cornerRadius(10)
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(draftList: .constant(CheckList.data), imagePicker: .constant(true))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
