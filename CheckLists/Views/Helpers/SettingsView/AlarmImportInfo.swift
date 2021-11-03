//
//  AlarmImportInfo.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 14/09/21.
//

import SwiftUI

struct AlarmImportInfo: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(StorageString.themeColor.rawValue) var themeColor = Color.blue
    
    var body: some View {
        VStack{
            LottieView(name: "SpeakerMusic", loopMode: .loop)
                .frame(width: 300, height: 400, alignment: .top)
            
            Text("Note")
                .font(.title)
                .padding(5)
            Text("Only **.wav**, **.aiff**, **.caf** and **.m4a** files are supported")
                .multilineTextAlignment(.center)
                .padding([.bottom, .leading, .trailing])
            
            Spacer()
            
            /// Convert link
            Link(destination: URL(string: "https://convertio.co/wav-converter/")!, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 150, height: 50, alignment: .center)
                        .foregroundColor(themeColor)
                    Text("Convert Audio")
                        .foregroundColor(themeColor.accessibleFontColor)
                }
            })
            .padding(.top)
            .padding(.bottom, 0)
            
            /// Import Audio Button
            Button{
                presentationMode.wrappedValue.dismiss()
            }label: {
                
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 150, height: 50, alignment: .center)
                        .foregroundColor(themeColor)
                    Text("Import Audio")
                        .foregroundColor(themeColor.accessibleFontColor)
                }
            }
            .padding(.top, 0)
            .padding(.bottom)
        }
    }
}

struct AlarmImportInfo_Previews: PreviewProvider {
    static var previews: some View {
        AlarmImportInfo()
            .preferredColorScheme(.dark)
    }
}
