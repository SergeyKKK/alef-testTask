//
//  UserInformationController.swift
//  alefTZ
//
//  Created by Serega Kushnarev on 28.05.2021.
//

import UIKit

// MARK: - UserInformationController

final class UserInformationController: UIViewController {
    
    // MARK: - Private properties
    
    private let nameTextField = UITextField()
    private let ageTextField = UITextField()
    
    private let childLabel = UILabel()
    private let childButton = UIButton()
    
    private let childrenTableView = UITableView()
    
    private var childArray: [Child] = []
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        
        view.backgroundColor = .white

        setUpNameTextField()
        setUpAgeTextField()
        setUpChildLabel()
        setUpChildButton()
        setUpChildrenTableView()
    
        createNameTextField()
        createAgeTextField()
        createChildLabel()
        createChildButton()
        createChildrenTableView()
    }
    
    private func setUpNameTextField() {
        nameTextField.placeholder = "Фамилия Имя Отчество"
        nameTextField.textAlignment = .center
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderWidth = 2.0
        nameTextField.delegate = self
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        
        view.addSubview(nameTextField)
    }
    
    private func setUpAgeTextField() {
        ageTextField.placeholder = "Ваш возраст"
        ageTextField.textAlignment = .center
        ageTextField.layer.cornerRadius = 10
        ageTextField.layer.borderWidth = 2.0
        ageTextField.delegate = self
        ageTextField.layer.borderColor = UIColor.gray.cgColor
        ageTextField.keyboardType = .asciiCapableNumberPad
        
        view.addSubview(ageTextField)
    }
    
    private func setUpChildLabel() {
        childLabel.textAlignment = .center
        childLabel.textColor = .gray
        childLabel.text = "Добавить ребёнка"
        
        view.addSubview(childLabel)
    }
    
    private func setUpChildButton() {
        childButton.setTitle("+", for: .normal)
        childButton.setTitleColor(.blue, for: .normal)
        childButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        childButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        view.addSubview(childButton)
    }
    
    private func setUpChildrenTableView() {
        
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        childrenTableView.separatorStyle = .none
        childrenTableView.register(CellForTableView.self, forCellReuseIdentifier: CellForTableView.cellIdentifier)
        
        view.addSubview(childrenTableView)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: nil, message: "Заполните данные", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            let text = alert.textFields?.first
            let textTwo = alert.textFields?.last
            
            if text?.text == "" || textTwo?.text == "" {
                print("nil")
            } else {
                let child = Child(name: text?.text ?? "", age: textTwo?.text ?? "")
                self.childArray.append(child)
                self.childrenTableView.reloadData()
            }
        }
        
        alert.addTextField { (name) in
            name.placeholder = "Имя ребёнка"
        }
        
        alert.addTextField { (age) in
            age.placeholder = "Возраст ребёнка"
            age.keyboardType = .asciiCapableNumberPad
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Actions
    
    @objc
    private func tapButton() {
        showAlert()
    }
}

// MARK: - UITextFieldDelegate

extension UserInformationController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            ageTextField.becomeFirstResponder()
        } else if textField == ageTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

// MARK: - UITableViewDelegate

extension UserInformationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            childArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension UserInformationController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if childArray.count >= 5 {
            childButton.isHidden = true
        } else if childArray.count <= 4 {
            childButton.isHidden = false
        }
        
        return childArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellForTableView.cellIdentifier,
                for: indexPath) as? CellForTableView else { return UITableViewCell() }
        
        let childs = childArray[indexPath.row]
        
        cell.configuration(childs: childs)
        
        return cell
    }
}

// MARK: - Layout

private extension UserInformationController {
    
    func createNameTextField() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: ageTextField.safeAreaLayoutGuide.topAnchor,
                                              constant: -10).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func createAgeTextField() {
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        ageTextField.topAnchor.constraint(equalTo: nameTextField.safeAreaLayoutGuide.bottomAnchor,
                                          constant: 10).isActive = true
        ageTextField.bottomAnchor.constraint(equalTo: childLabel.safeAreaLayoutGuide.topAnchor,
                                             constant: -10).isActive = true
        ageTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        ageTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createChildLabel() {
        childLabel.translatesAutoresizingMaskIntoConstraints = false
        childLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        childLabel.topAnchor.constraint(equalTo: ageTextField.safeAreaLayoutGuide.bottomAnchor,
                                        constant: 10).isActive = true
        childLabel.bottomAnchor.constraint(equalTo: childButton.safeAreaLayoutGuide.topAnchor,
                                           constant: -10).isActive = true
        childLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        childLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createChildButton() {
        childButton.translatesAutoresizingMaskIntoConstraints = false
        childButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        childButton.topAnchor.constraint(equalTo: childLabel.safeAreaLayoutGuide.bottomAnchor,
                                         constant: 10).isActive = true
        childButton.bottomAnchor.constraint(equalTo: childrenTableView.safeAreaLayoutGuide.topAnchor,
                                            constant: -10).isActive = true
        childButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        childButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func createChildrenTableView() {
        childrenTableView.translatesAutoresizingMaskIntoConstraints = false
        childrenTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        childrenTableView.topAnchor.constraint(equalTo: childButton.safeAreaLayoutGuide.bottomAnchor,
                                               constant: 10).isActive = true
        childrenTableView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        childrenTableView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
}
