//
//  SwipeContainer.swift
//  CheckLists
//
//  Created by Shivoy Arora on 04/08/21.
//

import Foundation
import SwiftUI

/// setting offset of the row when swiping and responding to clicks
struct SwipeContainer: ViewModifier {
    enum VisibleButton {
        case none
        case left
        case right
    }
    
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButton: VisibleButton = .none
    let leadingButtons: [SwipeButton]
    let trailingButtons: [SwipeButton]
    let maxLeadingOffset: CGFloat
    let minTrailingOffset: CGFloat
    let onCLick: (SwipeButton) -> Void
    
    init(leadingButtons: [SwipeButton], trailingButtons: [SwipeButton], onCLick: @escaping (SwipeButton) -> Void) {
        self.leadingButtons = leadingButtons
        self.trailingButtons = trailingButtons
        self.maxLeadingOffset = CGFloat(leadingButtons.count) * buttonWidth
        self.minTrailingOffset = CGFloat(trailingButtons.count) * buttonWidth * -1
        self.onCLick = onCLick
    }
    
    
    /// To reset the row to show no buttons
    func reset() {
        visibleButton = .none
        offset = 0
        oldOffset = 0
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                /// For swipe to work even when swiped from empty space
                .contentShape(Rectangle())
                .offset(x: offset)
                .gesture(
                    DragGesture(minimumDistance: 15, coordinateSpace: .local)
                        .onChanged({ val in
                            let totalSlide = val.translation.width + oldOffset
                            
                            if (0...Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset)...0 ~= Int(totalSlide)) {
                                withAnimation {
                                    offset = totalSlide
                                }
                            }
                        })
                        .onEnded({ val in
                            withAnimation {
                                //TODO: add if user swipes more than a certain CGFloat do some action
                                if visibleButton == .left && val.translation.width < -20 {
                                    reset()
                                }else if visibleButton == .right && val.translation.width > 20 {
                                    reset()
                                }else if offset > 25 || offset < -25 {
                                    if offset > 0 {
                                        visibleButton = .left
                                        offset = maxLeadingOffset
                                    }else {
                                        visibleButton = .right
                                        offset = minTrailingOffset
                                    }
                                    oldOffset = offset
                                }else {
                                    reset()
                                }
                            }
                        })
                )
            
            GeometryReader { proxy in
                ///of all the buttons
                HStack(spacing: 0){
                    
                    ///Of leading buttons
                    HStack(spacing: 0) {
                        ForEach(leadingButtons) { buttonsData in
                            Button{
                                withAnimation {
                                    reset()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                                    onCLick(buttonsData)
                                }
                            }label: {
                                SwipeButtonView(data: buttonsData, cellHeight: proxy.size.height)
                            }
                        }
                    }
                    .offset(x: (-1 * maxLeadingOffset) + offset)
                    Spacer()
                    
                    ///of trailing buttons
                    HStack(spacing:0){
                        ForEach(trailingButtons) { buttonData in
                            Button{
                                withAnimation {
                                    reset()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                                    onCLick(buttonData)
                                }
                            }label: {
                                SwipeButtonView(data: buttonData, cellHeight: proxy.size.height)
                            }
                        }
                    }
                    .offset(x: (-1 * minTrailingOffset) + offset)
                }
            }
        }
    }
}
