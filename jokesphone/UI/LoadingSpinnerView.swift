//
//  LoadingSpinnerView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import SwiftUI

struct LoadingSpinnerView: View {
    @State private var animate = false

    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .white, location: 0.1),
            Gradient.Stop(color: .white.opacity(0.8), location: 0.4),
            Gradient.Stop(color: .white.opacity(0.4), location: 0.8)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )

    var body: some View {
        Circle()
            .stroke(gradient, lineWidth: 8)
            .frame(width: 80, height: 80)
            .rotationEffect(Angle(degrees: animate ? 360 : 0))
            .animation(
                .linear(duration: 1)
                .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear {
                withAnimation {
                    animate.toggle()
                }
            }
    }
}

#Preview {
    LoadingSpinnerView()
}
