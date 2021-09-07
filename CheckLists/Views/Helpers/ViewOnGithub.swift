//
//  ViewOnGithub.swift
//  StrikeOut
//
//  Created by Shivoy Arora on 06/09/21.
//

import SwiftUI

struct ViewOnGithub: View {
    var bgColor: Color
    
    var body: some View {
        Link(destination: URL(string: "https://github.com/arorashivoy/StrikeOut")!) {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 180, height: 55, alignment: .center)
                    .foregroundColor(bgColor)
                HStack{
                    
                    /// Logo image
                    if bgColor.accessibleFontColor == .white {
                        Image("GithubLogoWhite")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                    }else {
                        Image("GithubLogoBlack")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                    }
                    
                    VStack(alignment: .leading){
                        Text("View it on")
                            .foregroundColor(bgColor.accessibleFontColor)
                            .font(.caption)
                            .bold()
                            .padding(.bottom, 0)
//                            .padding(.top, 5)
                            .offset(x: 8, y: 15.0)
                        
                        /// Github text image
                        if bgColor.accessibleFontColor == .white {
                            Image("GitHubWhite")
                                .resizable()
                                .frame(width: 100, height: 40, alignment: .center)
                                .padding(.top, 0)
                        }else {
                            Image("GitHubBlack")
                                .resizable()
                                .frame(width: 100, height: 40, alignment: .center)
                                .padding(.top, 0)
                        }
                    }
                }
            }
        }
    }
}

struct ViewOnGithub_Previews: PreviewProvider {
    static var previews: some View {
        ViewOnGithub(bgColor: .white)
            .preferredColorScheme(.dark)
    }
}
