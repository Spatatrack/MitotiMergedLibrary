//
//  SwiftUIView.swift
//  
//
//  Created by Simone Pistecchia on 30/12/20.
//

import SwiftUI

struct SwiftUIView: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        GIFView(gifName: "goSetting-Ita")
    }
}

@available(iOS 13.0.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

@available(iOS 13.0.0, *)
public class GIFPlayerView: UIView {
    private let imageView = UIImageView()

    public convenience init(gifName: String) {
       self.init()
       let gif = UIImage.gif(name: gifName)
       imageView.image = gif
       imageView.contentMode = .scaleAspectFit
       self.addSubview(imageView)
    }

    public override init(frame: CGRect) {
       super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}

///GIFView(gifName: "your gif name")
@available(iOS 13.0.0, *)
public struct GIFView: UIViewRepresentable {
    public var gifName: String

    public init(gifName: String) {
        self.gifName = gifName
    }
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GIFView>) {

    }


    public func makeUIView(context: Context) -> UIView {
        return GIFPlayerView(gifName: gifName)
    }
}
