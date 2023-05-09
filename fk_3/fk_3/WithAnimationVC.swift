//
//  WithAnimationVC.swift
//  fk_3
//
//  Created by George Weaver on 08.05.2023.
//

import UIKit

class WithAnimationVC: UIViewController {
    
    private let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear, animations: nil)
    
    private var changingViewWidth: NSLayoutConstraint!
    private var changingViewHeight: NSLayoutConstraint!
    private var changingViewLeading: NSLayoutConstraint!
    
    private let changingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupLayout()
        setupAnimator()
        addActions()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layoutMarginsDidChange()
    }
    
    private func setupAppearance() {
        
        self.view.layoutMargins = UIEdgeInsets(
            top: self.view.layoutMargins.top,
            left: 20,
            bottom: self.view.layoutMargins.bottom,
            right: 20
        )
        
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        view.addSubviewWithoutAutoresizing(changingView, slider)
        
        changingViewWidth = changingView.widthAnchor.constraint(equalToConstant: 100)
        changingViewHeight = changingView.heightAnchor.constraint(equalToConstant: 100)
        changingViewLeading = changingView.leadingAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor)
        
        NSLayoutConstraint.activate([
            changingView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            changingViewLeading,
            changingView.trailingAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor),
            changingViewWidth,
            changingViewHeight,
            
            slider.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 170),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            slider.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupAnimator() {
        
        animator.addAnimations {
            self.changingView.transform = CGAffineTransform(rotationAngle: .pi / 2)
            self.changingViewLeading.constant = self.view.bounds.size.width
            self.changingViewHeight.constant *= 1.5
            self.changingViewWidth.constant *= 1.5
            self.animator.pausesOnCompletion = true
            self.view.layoutIfNeeded()
        }
    }
    
    private func addActions() {
        slider.addTarget(self, action: #selector(swiped), for: .valueChanged)
        slider.addTarget(self, action: #selector(swiped2), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc
    private func swiped(_ sender: UISlider) {
        self.animator.fractionComplete = CGFloat(self.slider.value)
    }
    
    @objc
    private func swiped2(_ sender: UISlider) {
        self.animator.startAnimation()
        sender.setValue(1.0, animated: true)
    }
}

