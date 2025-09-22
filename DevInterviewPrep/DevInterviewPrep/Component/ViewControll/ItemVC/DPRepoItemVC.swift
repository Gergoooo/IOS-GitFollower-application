//
//  DPRepoItemVC.swift
//  DevInterviewPrep
//
//  Created by Gergő  on 2025. 09. 19..
//

import UIKit

protocol DPRepositoryItemVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class DPRepoItemVC: DPItemInfoVC {
    
    weak var delegate: DPRepositoryItemVCDelegate!
    
    init(user: User, delegate: DPRepositoryItemVCDelegate!) {
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
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
