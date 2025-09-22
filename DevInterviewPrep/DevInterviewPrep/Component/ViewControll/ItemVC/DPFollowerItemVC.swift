//
//  DPFollowerItemVC.swift
//  DevInterviewPrep
//
//  Created by Gergő  on 2025. 09. 19..
//

import UIKit

protocol DPFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class DPFollowerItemVC: DPItemInfoVC {
    
    weak var delegate: DPFollowerItemVCDelegate!
    
    init(user: User, delegate: DPFollowerItemVCDelegate!) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
