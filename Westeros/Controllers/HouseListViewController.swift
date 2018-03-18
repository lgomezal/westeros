//
//  HouseListViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 15/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

let HOUSE_KEY = "HouseKey"
let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "houseDidChange"
let LAST_HOUSE = "LAST_HOUSE"

protocol HouseListViewControllerDelegate: class {
    // should, will, did
    func HouseListViewController(_ vc: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    weak var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Initializations
    init(model: [House]) {
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
        let lasRow = UserDefaults.standard.integer(forKey: LAST_HOUSE)
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
        
        let cellId = "HouseCell"
        
        // Descubrir cual es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear un celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar house (modelo) con cell (vista)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name

        return cell!
    }


    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que casa han pulsado
        let house = model[indexPath.row]
        
        // Avisamos al delegado
        delegate?.HouseListViewController(self, didSelectHouse: house)
        
        // Mando la misma info a traves de notificaciones
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY: house])
        
        notificationCenter.post(notification)
        
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
        
        // Si es iPhone hacemos push
        /*if UIDevice.current.userInterfaceIdiom == .pad {
            return
        } else {
            // Crear un controlador de detalle de esa persona
            let houseDetailViewController = HouseDetailViewController(model: house)
            // Hacer un push
            navigationController?.pushViewController(houseDetailViewController, animated: true)
        }*/
    }
}

extension HouseListViewController: HouseListViewControllerDelegate {
    func HouseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        let houseDetailViewController = HouseDetailViewController(model: house)
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_HOUSE)
        // Por si no se hubiera guardado con esto nos aseguramos guardarlo
        defaults.synchronize()
    }
    
    func lastSelectedHouse() -> House {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        
        // Averiguar la casa de ese row
        let house = model[row]
        
        // Devolverla
        return house
    }
}



