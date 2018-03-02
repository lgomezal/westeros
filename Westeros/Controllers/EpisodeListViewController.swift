//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 25/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
        
    // MARK: - Properties
    var model: [Episode]
    
    // MARK: - Initializations
    init(model: [Episode]) {
        self.model = model
        super.init(style: .plain)
        title = "Episodes"
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
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (navigationController?.topViewController?.isKind(of: EpisodeDetailViewController.self))! {
            return
        } else {
            // Nos damos de baja en las notificaciones
            let notificationCenter = NotificationCenter.default
            notificationCenter.removeObserver(self)
        }
    }
    
    @objc func seasonDidChange(notification: Notification) {
        // Extraer userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        // Sacar la temporada del user info
        let season = info[SEASON_KEY] as? Season
        //Actualizar el modelo
        guard let model = season else { return }
        self.model = model.sortedEpisodes
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
        
        let cellId = "EpisodeCell"
        
        // Descubrir cual es el episodio que tenemos que mostrar
        let episode = model[indexPath.row]
        
        // Crear un celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sincronizar episode (modelo) con cell (vista)
        cell.textLabel?.text = episode.title
        cell.imageView?.image = episode.image
        
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que episodio han pulsado
        let episode = model[indexPath.row]
        
        // Crear un controlador de detalle de ese episodio
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        // Hacer un push
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
    
}
