//
//  NotificationPermission.swift
//  CheckLists
//
//  Created by Shivoy Arora on 31/07/21.
//

import SwiftUI

struct NotificationPermission: View {
    @Binding var notiPermission: Bool
    
    @AppStorage("notiAsked") var notiAsked: Bool = false
    
    var body: some View {
        VStack{
            
            ///Cancel Button
            HStack{
                Button{
                    notiPermission = false
                }label: {
                    Text("Cancel")
                }
                Spacer()
            }
            LottieView(name: "NotificationBell", loopMode: .loop)
                .frame(width: 300, height: 300, alignment: .center)
            
            Text("Allow Push Notifications to get reminded about the event")
                .padding()
            Spacer()
            
            ///Enable notification button
            Button{
                AppNotification().requestPermission()
                notiPermission = false
                notiAsked = true
            }label: {
                ZStack{
                    Rectangle()
                        .frame(width: 170, height: 50, alignment: .center)
                    Text("Enable Notifications")
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
        .padding()
    }
}

struct NotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermission(notiPermission: .constant(true))
            .preferredColorScheme(.dark)
    }
}
