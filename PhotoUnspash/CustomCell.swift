//
//  Created by Владислав Наумов on 23.01.2024.
//

import UIKit
import SDWebImage

class CustomCell: UICollectionViewCell {
    
    static let reuseId = "Cell"
    
    public var friendImageView = UIImageView()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url =
                    URL(string: imageUrl) else { return }
            friendImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    func setupFriendImageView() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendImageView.layer.cornerRadius = 15
        friendImageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    func addSubviews() {
        addSubview(friendImageView)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupFriendImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
