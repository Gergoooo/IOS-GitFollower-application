//
//  UserInfoVC.swift
//  DevInterviewPrep
//
//  Created by Gergő  on 2025. 09. 18..
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowerList(for username: String)
}

class UserInfoVC: DPDataLoadingVC {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = DPBodyLabel(textAlignment: .center)
    
    var itemViews: [UIView] = []
    var username: String!
    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async{ self.configureUIElements(with: user) }
            case .none:
                break
            case .failure(_):
                self.presentDPAlertOnMainThread(title: "Error", message: "Something went wrong, please try again later.", buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(with user: User){
        self.add(childeVC: DPUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childeVC: DPRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childeVC: DPFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "Github since: \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childeVC: UIViewController, to containerView: UIView){
        addChild(childeVC)
        containerView.addSubview(childeVC.view)
        childeVC.view.frame = containerView.bounds
        childeVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

extension UserInfoVC: DPRepositoryItemVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentDPAlertOnMainThread(title: "Ivalid URL", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: DPFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentDPAlertOnMainThread(title: "No followers", message: "This user has no followers 🥲.", buttonTitle: "Sadge")
            return
        }
        delegate.didRequestFollowerList(for: user.login)
        dismissVC()
    }
}
