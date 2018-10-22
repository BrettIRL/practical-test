//
//  SearchTableViewCell.swift
//  iOS Practical Code Test
//
//  Created by Brett Cocking on 2018/10/20.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var question: Question? {
        didSet {
            questionTextView.text = question!.title.htmlToString
            authorLabel.text = "asked by \(question!.author.name.htmlToString)"
            votesLabel.text = String(format: NSLocalizedString("NumberOfVotes", comment: ""), question!.votes)
            answersLabel.text = String(format: NSLocalizedString("NumberOfAnswers", comment: ""), question!.answers)
            viewsLabel.text = String(format: NSLocalizedString("NumberOfViews", comment: ""), question!.views)
            imageWidthConstant = question!.answered ? 21 : 0
        }
    }
    
    private let questionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = UIColor().fromHexValue(hex: "#4078C4")
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let answeredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check")
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorLabel = DetailLabel()
    private let votesLabel = DetailLabel()
    private let answersLabel = DetailLabel()
    private let viewsLabel = DetailLabel()
    
    private var imageWidthConstant: CGFloat = 0
    var answeredImageWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Set up UI
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        answeredImageWidthConstraint.constant = imageWidthConstant
        addBorders()
    }

    
    func setupLayout() {
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(answeredImageView)
        contentView.addSubview(questionTextView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(votesLabel)
        contentView.addSubview(answersLabel)
        contentView.addSubview(viewsLabel)
        
        answeredImageWidthConstraint = answeredImageView.widthAnchor.constraint(equalToConstant: imageWidthConstant)
        answeredImageWidthConstraint.isActive = true
        answeredImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        answeredImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        questionTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
        questionTextView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        questionTextView.leadingAnchor.constraint(equalTo: answeredImageView.trailingAnchor, constant: 8).isActive = true
        questionTextView.trailingAnchor.constraint(equalTo: viewsLabel.leadingAnchor, constant: -8).isActive = true
        questionTextView.bottomAnchor.constraint(equalTo: authorLabel.topAnchor).isActive = true
        
        authorLabel.setContentHuggingPriority(.required, for: .vertical)
        authorLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        authorLabel.leadingAnchor.constraint(equalTo: answeredImageView.trailingAnchor, constant: 8).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        answersLabel.widthAnchor.constraint(equalTo: viewsLabel.widthAnchor).isActive = true
        answersLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        answersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        votesLabel.widthAnchor.constraint(equalTo: viewsLabel.widthAnchor).isActive = true
        votesLabel.bottomAnchor.constraint(equalTo: answersLabel.topAnchor, constant: -4).isActive = true
        votesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        viewsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 56).isActive = true
        viewsLabel.topAnchor.constraint(equalTo: answersLabel.bottomAnchor, constant: 4).isActive = true
        viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func addBorders() {
        let borderColor = UIColor().fromHexValue(hex: "#CCCCCC")
        addBorder(side: .top, color: borderColor, thickness: 1.0)
        addBorder(side: .bottom, color: borderColor, thickness: 1.0)
    }
}

// MARK: -

class DetailLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = UIColor().fromHexValue(hex: "#8F8E94")
        font = .systemFont(ofSize: 10)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
