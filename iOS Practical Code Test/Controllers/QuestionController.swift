//
//  QuestionController.swift
//  iOS Practical Code Test
//
//  Created by Brett Cocking on 2018/10/21.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {
    
    // MARK: - Properties
    
    private let questionTitleHeight: CGFloat = 55.0
    private let tagViewHeight: CGFloat = 20.0
    private let authorViewHeight: CGFloat = 65.0
    private var borderAdded = false
    
    var question: Question? {
        didSet {
            questionTitleLabel.text = question!.title.htmlToString
            questionBodyTextView.text = question!.body.htmlToString
            tagLabel.text = question!.tags.joined(separator: ", ")
            authorImageView.loadImageFromUrlString(url: question!.author.image)
            authorNameLabel.text = question!.author.name.htmlToString
            authorReputationLabel.text = "\(question!.author.reputation)"
            questionDateLabel.text = "asked \(question!.date.toOrdinalDateString()) at \(question!.date.toTimeString())"
        }
    }
    
    // MARK: - Views
    
    private let questionTitleLabel: UILabel = {
        let textView = UILabel()
        textView.numberOfLines = 2
        textView.textColor = UIColor().fromHexValue(hex: "#727272")
        textView.font = .boldSystemFont(ofSize: 17)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let questionBodyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let questionBodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    private let tagView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor().fromHexValue(hex: "#727272")
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let authorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor().fromHexValue(hex: "#727272")
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorReputationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor().fromHexValue(hex: "#727272")
        label.font = .boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor().fromHexValue(hex: "#727272")
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor().fromHexValue(hex: "#EDEDED")
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Question"
        
        let titleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        if !borderAdded {
            addBorders()
        }
    }
    
    // MARK: - Set up UI
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupLayout() {
        questionBodyView.addSubview(questionBodyTextView)
        tagView.addSubview(tagLabel)
        authorView.addSubview(authorImageView)
        authorView.addSubview(authorNameLabel)
        authorView.addSubview(authorReputationLabel)
        authorView.addSubview(questionDateLabel)
        
        view.addSubview(questionTitleLabel)
        view.addSubview(questionBodyView)
        view.addSubview(tagView)
        view.addSubview(authorView)
        
        questionTitleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        questionTitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        questionTitleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        questionTitleLabel.heightAnchor.constraint(equalToConstant: questionTitleHeight).isActive = true
        
        questionBodyView.topAnchor.constraint(equalTo: questionTitleLabel.bottomAnchor).isActive = true
        questionBodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        questionBodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        questionBodyView.bottomAnchor.constraint(equalTo: tagView.topAnchor).isActive = true
        
        questionBodyTextView.topAnchor.constraint(equalTo: questionBodyView.layoutMarginsGuide.topAnchor).isActive = true
        questionBodyTextView.leadingAnchor.constraint(equalTo: questionBodyView.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        questionBodyTextView.trailingAnchor.constraint(equalTo: questionBodyView.layoutMarginsGuide.trailingAnchor).isActive = true
        questionBodyTextView.bottomAnchor.constraint(equalTo: questionBodyView.layoutMarginsGuide.bottomAnchor).isActive = true
        
        tagView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tagView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tagView.bottomAnchor.constraint(equalTo: authorView.topAnchor).isActive = true
        tagView.heightAnchor.constraint(equalToConstant: tagViewHeight).isActive = true
        
        tagLabel.centerYAnchor.constraint(equalTo: tagView.centerYAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        authorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        authorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        authorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        authorView.heightAnchor.constraint(equalToConstant: authorViewHeight).isActive = true
        
        authorImageView.centerYAnchor.constraint(equalTo: authorView.centerYAnchor).isActive = true
        authorImageView.leadingAnchor.constraint(equalTo: authorView.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        authorImageView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        authorImageView.widthAnchor.constraint(equalTo: authorImageView.heightAnchor).isActive = true
        
        authorReputationLabel.centerYAnchor.constraint(equalTo: authorView.centerYAnchor).isActive = true
        authorReputationLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 8).isActive = true
        authorReputationLabel.widthAnchor.constraint(equalTo: questionDateLabel.widthAnchor).isActive = true
        
        authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 8).isActive = true
        authorNameLabel.bottomAnchor.constraint(equalTo: authorReputationLabel.topAnchor).isActive = true
        authorNameLabel.widthAnchor.constraint(equalTo: questionDateLabel.widthAnchor).isActive = true
        
        questionDateLabel.topAnchor.constraint(equalTo: authorReputationLabel.bottomAnchor).isActive = true
        questionDateLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 8).isActive = true
    }
    
    func addBorders() {
        let borderColor = UIColor().fromHexValue(hex: "#CCCCCC")
        questionBodyView.addBorder(side: .top, color: borderColor, thickness: 1.0)
        tagView.addBorder(side: .top, color: borderColor, thickness: 1.0)
        authorView.addBorder(side: .top, color: borderColor, thickness: 1.0)
        borderAdded = true
    }
}
