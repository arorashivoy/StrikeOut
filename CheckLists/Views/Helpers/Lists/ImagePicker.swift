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
    
    let layout = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack{
            
            /// ToolBar
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
            
            /// Main
            ScrollView{
                
                /// Grid of thumbnails
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(CheckList.Images.allCases) { image in
                        let selection: Bool = draftList.imageName == image.rawValue
                            
                        /// thumbnail image
                        Button{
                            withAnimation{
                                draftList.imageName = image.rawValue
                            }
                        }label: {
                            ZStack {
                                
                                /// Border
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selection ? Color.gray : Color.clear, lineWidth: 2)
                                    .frame(width: 65, height: 65, alignment: .center)
                                    .animation(.easeInOut)
                                
                                /// background
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 60, height: 60, alignment: .center)
                                
                                /// image
                                Image(systemName: image.rawValue)
                                    .foregroundColor(draftList.color)
                                    .font(.title)
                            }
                            
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(draftList: .constant(CheckList.data), imagePicker: .constant(true))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
