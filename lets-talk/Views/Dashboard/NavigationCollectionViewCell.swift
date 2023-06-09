//
//  DashboardCollectionViewCell.swift
//  lets-talk
//
//  Created by Stefan de Gier on 23/04/2023.
//

import Foundation
import UIKit
import Lottie

class NavigationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var navigationViewCell: UIView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var navigationAnimationView: LottieAnimationView!
    
    func configure(with title: String, imageSource: String, contentMode: UIView.ContentMode) {
        self.navigationTitleLabel.text = title
        self.navigationAnimationView.animation = LottieAnimation.named(imageSource)
        self.navigationAnimationView.contentMode = contentMode

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.navigationViewCell.layer.cornerRadius = 10
        self.navigationViewCell.layer.masksToBounds = true
        
        self.navigationAnimationView.loopMode = .loop
        self.navigationAnimationView.play()
    }
             
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        isHighlighted = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
         self.isHighlighted = false
        }
    }

    override var isHighlighted: Bool {
        didSet {
         self.updateCellAppearance()
        }
    }

    private func updateCellAppearance() {
        HapticFeedbackManager.shared.performImpactFeedback(style: .medium)
        self.navigationViewCell.backgroundColor = isHighlighted ? .secondarySystemFill : .systemBackground
    }
}

