//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 24/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

let SEASON_KEY = "SeasonKey"
let SEASON_DID_CHANGE_NOTIFICATION_NAME = "seasonDidChange"
let LAST_SEASON = "LAST_SEASON"

protocol SeasonListViewControllerDelegate: class {
    // should, will, did
    func SeasonListViewController(_ vc: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
        
    // MARK: - Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Initializations
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lasRow = UserDefaults.standard.integer(forKey: LAST_SEASON)
        let indexPath = IndexPath(row: lasRow, section: 0)
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Descubrir cual es la casa que tenemos que mostrar
        let season = model[indexPath.row]
        
        // Crear un celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar season (modelo) con cell (vista)
        cell?.imageView?.image = season.image
        cell?.textLabel?.text = season.name
        
        return cell!
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que casa han pulsado
        let season = model[indexPath.row]
        
        // Avisamos al delegado
        delegate?.SeasonListViewController(self, didSelectSeason: season)
        
        // Mando la misma info a traves de notificaciones
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY: season])
        
        notificationCenter.post(notification)
        
        // Guardar las coordenadas (section, row) de la última temporada seleccionada
        saveLastSelectedSeason(at: indexPath.row)
        
        // Si es iPhone hacemos push
        if UIDevice.current.userInterfaceIdiom == .pad {
            return
        } else {
            // Crear un controlador de detalle de esa persona
            let seasonDetailViewController = SeasonDetailViewController(model: season)
            // Hacer un push
            navigationController?.pushViewController(seasonDetailViewController, animated: true)
        }
    }
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_SEASON)
        // Por si no se hubiera guardado con esto nos aseguramos guardarlo
        defaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        
        // Averiguar la temporada de ese row
        let season = model[row]
        
        // Devolverla
        return season
    }
}

