//
//  Extension+UITableView.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 6/30/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setEmptyView(title: String?, result: String?, message: String?) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let resultLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        
        resultLabel.textColor = UIColor.lightGray
        resultLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(resultLabel)
        emptyView.addSubview(messageLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        resultLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        resultLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        titleLabel.text = title
        
        resultLabel.text = result
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
       
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
