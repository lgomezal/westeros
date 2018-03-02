//
//  PersonDetailViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 25/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var namePersonLabel: UILabel!
    @IBOutlet weak var aliasPersonLabel: UILabel!
    @IBOutlet weak var imagePerson: UIImageView!
    // MARK: - Properties
    var model: Person
    
    // MARK: - Initialization
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func houseDidChange(notification: Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        // Model -> view
        title = "Member"
        namePersonLabel.text = model.fullName
        aliasPersonLabel.text = model.alias
        imagePerson.image = model.image
    }
}


