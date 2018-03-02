//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 12/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        tabBarController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        // Model -> view
        title = model.name
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        // Comprobamos si hay miembros para habilitar-deshabilitar el botón
        barButtonMembersEnabledDisabled()
    }
    
    // MARK: - UI
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        navigationItem.rightBarButtonItem = wikiButton
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        navigationItem.rightBarButtonItems = [wikiButton, membersButton]
        
        barButtonMembersEnabledDisabled()
    }
    
    func barButtonMembersEnabledDisabled() {
        // Comprobamos si la casa tiene algún miembro
        // Si el número de miembros es 0 deshabilitamos el botón
        let members = model.sortedMembers
        let numberOfMembers = members.count
        switch numberOfMembers {
        case 0:
            navigationItem.rightBarButtonItems![1].isEnabled = false
        default:
            navigationItem.rightBarButtonItems![1].isEnabled = true
        }
    }
    
    @objc func displayWiki() {
        // Creamos el WikiVC
        let wikiViewController = WikiViewController(model: model)
        
        // Hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc func displayMembers(recognizer: UITapGestureRecognizer) {
        // Creamos el personsVC
        let personsViewController = PersonsTableViewController(model: model.sortedMembers)
            
        // LO pusheamos
        navigationController?.pushViewController(personsViewController, animated: true)
    }
}

// MARK: - Delegate

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func HouseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
}

extension HouseDetailViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == tabBarItem.tag {
            return
        } else {
            tabBarItem.tag = tabBarController.selectedIndex
            self.splitViewController?.viewControllers = [(self.splitViewController?.viewControllers[0])!, (self.splitViewController?.viewControllers[2])!,(self.splitViewController?.viewControllers[1])!]
        }
    }
}




