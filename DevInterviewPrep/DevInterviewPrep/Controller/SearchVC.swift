//
//  SearchVC.swift
//  DevInterviewPrep
//
//  Created by Gergő  on 2025. 09. 15..
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameInit = DPTextField()
    let callToActionButton = DPButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEnterd: Bool { return !usernameInit.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameInit, callToActionButton)
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameInit.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardGesture(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushToFollowersListVC(){
        guard isUsernameEnterd else {
            presentDPAlertOnMainThread(title: "Empty Username", message: "Please enter a username to search for followers", buttonTitle: "Ok")
            return
        }
        usernameInit.resignFirstResponder()
        let followerListVC = FollowerListVC(username: usernameInit.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureLogoImageView(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.dplogo
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        usernameInit.delegate = self
        
        NSLayoutConstraint.activate([
            usernameInit.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameInit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            usernameInit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameInit.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton(){
        callToActionButton.addTarget(self, action: #selector(pushToFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowersListVC()
        return true
    }
}
