//
//  DonateLink.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 20/08/21.
//

import SwiftUI

struct DonateLink: View {
    var bgColor: Color
    
    var body: some View {
        
        Link(destination: URL(string: "https://www.buymeacoffee.com/ShivoyArora")!, label: {
            
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 170, height: 55, alignment: .center)
                    .foregroundColor(bgColor)
                HStack {
                    Image("bmcCup")
                        .resizable()
                        .frame(width: 21, height: 33, alignment: .center)
                    Text("Buy me a coffee")
                        .font(.custom("Cookie", size: 25))
                        .foregroundColor(bgColor.accessibleFontColor)
                }
            }
                
        })
    }
}

struct DonateLink_Previews: PreviewProvider {
    static var previews: some View {
        DonateLink(bgColor: .red )
    }
}
