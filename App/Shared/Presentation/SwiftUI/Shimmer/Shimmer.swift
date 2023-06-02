//
// Created by Kamel on 07/11/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

//import SwiftUI
//
///// A view modifier that applies an animated "shimmer" to any view, typically to show that
///// an operation is in progress.
///// https://github.com/markiv/SwiftUI-Shimmer
//public struct Shimmer: ViewModifier {
//    let animation: Animation
//    @State private var phase: CGFloat = 0
//
//    /// Initializes his modifier with a custom animation,
//    /// - Parameter animation: A custom animation. The default animation is
//    ///   `.linear(duration: 1.5).repeatForever(autoreverses: false)`.
//    public init(animation: Animation = Self.defaultAnimation) {
//        self.animation = animation
//    }
//
//    /// The default animation effect.
//    public static let defaultAnimation = Animation.linear(duration: 1.5).repeatForever(autoreverses: false)
//
//    /// Convenience, backward-compatible initializer.
//    /// - Parameters:
//    ///   - duration: The duration of a shimmer cycle in seconds. Default: `1.5`.
//    ///   - bounce: Whether to bounce (reverse) the animation back and forth. Defaults to `false`.
//    ///   - delay:A delay in seconds. Defaults to `0`.
//    public init(duration: Double = 1.5, bounce: Bool = false, delay: Double = 0) {
//        animation = .linear(duration: duration)
//                .repeatForever(autoreverses: bounce)
//                .delay(delay)
//    }
//
//    public func body(content: Content) -> some View {
//        content
//                .modifier(
//                        AnimatedMask(phase: phase).animation(animation)
//                )
//                .onAppear {
//                    phase = 0.8
//                }
//    }
//
//    /// An animatable modifier to interpolate between `phase` values.
//    struct AnimatedMask: AnimatableModifier {
//        var phase: CGFloat = 0
//
//        var animatableData: CGFloat {
//            get {
//                phase
//            }
//            set {
//                phase = newValue
//            }
//        }
//
//        func body(content: Content) -> some View {
//            content
//                    .mask(GradientMask(phase: phase).scaleEffect(3))
//        }
//    }
//
//    /// A slanted, animatable gradient between transparent and opaque to use as mask.
//    /// The `phase` parameter shifts the gradient, moving the opaque band.
//    struct GradientMask: View {
//        let phase: CGFloat
//        let centerColor = Color.black
//        let edgeColor = Color.black.opacity(0.3)
//
//        var body: some View {
//            LinearGradient(gradient:
//            Gradient(stops: [
//                .init(color: edgeColor, location: phase),
//                .init(color: centerColor, location: phase + 0.1),
//                .init(color: edgeColor, location: phase + 0.2),
//            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
//        }
//    }
//}
//
//public extension View {
//    /// Adds an animated shimmering effect to any view, typically to show that
//    /// an operation is in progress.
//    /// - Parameters:
//    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
//    ///   - duration: The duration of a shimmer cycle in seconds. Default: `1.5`.
//    ///   - bounce: Whether to bounce (reverse) the animation back and forth. Defaults to `false`.
//    ///   - delay:A delay in seconds. Defaults to `0`.
//    @ViewBuilder func shimmering(
//            active: Bool = true, duration: Double = 1.5, bounce: Bool = false, delay: Double = 0
//    ) -> some View {
//        if active {
//            modifier(Shimmer(duration: duration, bounce: bounce, delay: delay))
//        } else {
//            self
//        }
//    }
//
//    /// Adds an animated shimmering effect to any view, typically to show that
//    /// - Parameters:
//    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
//    ///   - animation: A custom animation. The default animation is
//    ///   `.linear(duration: 1.5).repeatForever(autoreverses: false)`.
//    @ViewBuilder func shimmering(active: Bool = true, animation: Animation = Shimmer.defaultAnimation) -> some View {
//        if active {
//            modifier(Shimmer(animation: animation))
//        } else {
//            self
//        }
//    }
//}
//
//struct Shimmer_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Text("SwiftUI Shimmer")
//            if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
//                Text("SwiftUI Shimmer").preferredColorScheme(.light)
//                Text("SwiftUI Shimmer").preferredColorScheme(.dark)
//                VStack(alignment: .leading) {
//                    Text("Loading...").font(.title)
//                    Text(String(repeating: "Shimmer", count: 12))
//                            .redacted(reason: .placeholder)
//                }
//                        .frame(maxWidth: 200)
//            }
//        }
//                .padding()
//                .shimmering()
//                .previewLayout(.sizeThatFits)
//    }
//}
