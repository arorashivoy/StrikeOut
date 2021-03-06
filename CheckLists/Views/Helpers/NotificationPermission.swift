//
//  NotificationPermission.swift
//  CheckLists
//
//  Created by Shivoy Arora on 31/07/21.
//

import SwiftUI

struct NotificationPermission: View {
    @AppStorage(StorageString.notiAsked.rawValue) var notiAsked: Bool = false
    @Binding var notiPermission: Bool
    
    var checkListColor: Color
    
    var body: some View {
        VStack{
            
            ///Cancel Button
            HStack{
                Button{
                    notiPermission = false
                }label: {
                    Text("Cancel")
                        .foregroundColor(checkListColor)
                }
                Spacer()
            }
            LottieView(name: "NotificationBell", loopMode: .loop)
                .frame(width: 300, height: 300, alignment: .center)
            
            Text("Allow Push Notifications to get reminded about the event")
                .padding()
            Spacer()
            
            ///Enable notification button
            Button("Enable Notifications"){
                AppNotification().requestPermission()
                notiPermission = false
                notiAsked = true
            }
            .buttonStyle(SetButton(bgColor: checkListColor))
        }
        .padding()
    }
}

struct NotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermission(notiPermission: .constant(true), checkListColor: CheckList.data.color)
            .preferredColorScheme(.dark)
    }
}
