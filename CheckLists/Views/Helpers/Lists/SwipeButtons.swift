//
//  SwipeButtons.swift
//  CheckLists
//
//  Created by Shivoy Arora on 04/08/21.
//

import Foundation
import SwiftUI

let buttonWidth: CGFloat = 60

/// Enum of swipe buttons
enum SwipeButton: Identifiable {
    case info
    case delete
    case pin
    
    var id: String {
        return "\(self)"
    }
}

/// Swipe button view
struct SwipeButtonView: View {
    let data: SwipeButton
    let cellHeight: CGFloat
    
    
    /// Function to make view of each button
    /// - Parameters:
    ///   - image: systemImage name of each button
    ///   - title: button name
    /// - Returns: button view
    func getView(for image: String, title: String) -> some View {
        VStack{
            Image(systemName: image)
            Text(title)
        }
        .padding(5)
        .foregroundColor(.primary)
        .font(.subheadline)
        .frame(width: buttonWidth, height: cellHeight)
    }
    
    var body: some View {
        switch data {
        case .info:
            getView(for: "info.circle", title: "info")
                .background(Color.gray)
        case .delete:
            getView(for: "trash.circle", title: "Delete")
                .background(Color.red)
        case .pin:
            getView(for: "pin.fill", title: "Pin")
                .background(Color.yellow)
        }
    }
}

struct SwipeButtonView_Preview: PreviewProvider{
    static var previews: some View {
        SwipeButtonView(data: .info, cellHeight: 60)
            .preferredColorScheme(.dark)
    }
}
