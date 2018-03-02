//
//  PersonsTableViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 18/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

class PersonsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initializations
    init(model: [Person]) {
        self.model = model
        super.init(style: .plain)
        title = "Members"
    }
    
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Notificaciones
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (navigationController?.topViewController?.isKind(of: PersonDetailViewController.self))! {
            return
        } else {
            // Nos damos de baja en las notificaciones
            let notificationCenter = NotificationCenter.default
            notificationCenter.removeObserver(self)
        }
    }
    
    @objc func houseDidChange(notification: Notification) {
        // Extraer userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        // Sacar la casa del user info
        let house = info[HOUSE_KEY] as? House
        //Actualizar el modelo
        guard let model = house else { return }
        self.model = model.sortedMembers
        tableView.reloadData()
        // Cambiamos el título de backbutton
        let backButton = UIBarButtonItem()
        backButton.title = model.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "PersonCell"
        
        // Descubrir cual es la casa que tenemos que mostrar
        let person = model[indexPath.row]
        
        // Crear un celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sincronizar person (modelo) con cell (vista)
        cell.imageView?.image = person.image
        cell.textLabel?.text = person.fullName
        
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que persona han pulsado
        let person = model[indexPath.row]
        
        // Crear un controlador de detalle de esa persona
        let personDetailViewController = PersonDetailViewController(model: person)
        
        // Hacer un push
        navigationController?.pushViewController(personDetailViewController, animated: true)
    }
}




