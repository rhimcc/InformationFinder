import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    var animationFileName: String
    let loopMode: LottieLoopMode
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let lottieAnimationView = LottieAnimationView(name: animationFileName)
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieAnimationView)
        NSLayoutConstraint.activate([
            lottieAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottieAnimationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
}
