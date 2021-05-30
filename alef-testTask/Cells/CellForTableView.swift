//
//  CellForTableView.swift
//  alefTZ
//
//  Created by Serega Kushnarev on 29.05.2021.
//

import UIKit

// MARK: - CellForTableView

final class CellForTableView: UITableViewCell {
    
    // MARK: - Public properties
    
    static let cellIdentifier = "CellForTableView"
    
    // MARK: - Private properties
    
    private var nameLabel = UILabel()
    private var ageLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCell()
    }
    
    // MARK: - Public methods
    
    func configuration(childs: Child) {
        nameLabel.text = childs.name
        ageLabel.text = childs.age
    }
    
    // MARK: - Private methods
    
    private func setupCell() {
        
        setupNameLabel()
        setupAgeLabel()
    }
    
    private func setupNameLabel() {
        nameLabel.frame = CGRect(x: 10, y: 10, width: 150, height: 30)
        nameLabel.font = nameLabel.font.withSize(20)
        
        contentView.addSubview(nameLabel)
    }
    
    private func setupAgeLabel() {
        ageLabel.font = ageLabel.font.withSize(20)
        ageLabel.frame = CGRect(x: 200, y: 10, width: 50, height: 30)
        
        contentView.addSubview(ageLabel)
    }
    
}

