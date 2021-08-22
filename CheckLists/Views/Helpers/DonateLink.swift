//
//  DonateLink.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 20/08/21.
//

import SwiftUI

struct DonateLink: View {
    
    var body: some View {
        Link(destination: URL(string: "https://www.buymeacoffee.com/ShivoyArora")!, label: {
            ZStack{
                Rectangle()
                    .cornerRadius(15)
                    .foregroundColor(Color("bmcColor"))
                    .frame(width: 170, height: 50, alignment: .center)
                HStack{
                    Image("bmcLogo")
                        .resizable()
                        .frame(width: 150, height: 40, alignment: .center)
                }
            }
        })
    }
}

struct DonateLink_Previews: PreviewProvider {
    static var previews: some View {
        DonateLink()
    }
}
