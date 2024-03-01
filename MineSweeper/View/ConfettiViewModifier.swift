//
//  ConfettiViewModifier.swift
//  MineSweeper
//
//  Created by Adi on 10/17/23.
//

import SwiftUI

struct ConfettiEffect: GeometryEffect {
    private var time: Double
    private var speed = Double.random(in: 20...200)
    private var direction = Double.random(in: -Double.pi...Double.pi)
    init(duration: Double) {
        time = duration
    }
    var animatableData: Double {
        get { time }
        set { time = newValue}
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTransform = time * cos(direction) * speed
        let yTransform = time * sin(direction) * speed
        return ProjectionTransform(CGAffineTransform(translationX: xTransform,
                                                     y: yTransform))
    }
}

struct ConfettiModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    private let duration = 5.0
    var isHueRotationNeeded = false
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { _ in
                if isHueRotationNeeded {
                    content
                        .hueRotation(Angle(degrees: time * 80))
                        .scaleEffect(scale)
                        .modifier(ConfettiEffect(duration: time))
                        .opacity((duration - time) / duration)
                } else {
                    content
                        .scaleEffect(scale)
                        .modifier(ConfettiEffect(duration: time))
                        
                }
            }
        }
        .onAppear {
            withAnimation(Animation
                .easeOut(duration: duration)
                .repeatForever(autoreverses: false)) {
                    self.time = duration
                    self.scale = 1.0
            }
        }
    }
}
