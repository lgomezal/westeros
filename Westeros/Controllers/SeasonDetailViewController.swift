//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 25/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initialization
    init(model: Season) {
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
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        setupUI()
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        // Model -> view
        title = model.name
        seasonLabel.text = model.name
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/mm/yyyy"
        let release = dateformatter.string(from: model.releaseDate)
        releaseLabel.text = release
        seasonImage.image = model.image
        
        // Comprobamos si hay miembros para habilitar-deshabilitar el botón
        barButtonEpisodesEnabledDisabled()
    }
    
    // MARK: - UI
    func setupUI() {
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        navigationItem.rightBarButtonItem = episodesButton
        
        barButtonEpisodesEnabledDisabled()
    }
    
    func barButtonEpisodesEnabledDisabled() {
        // Comprobamos si la temporada tiene algún miembro
        // Si el número de episodios es 0 deshabilitamos el botón
        let episodes = model.sortedEpisodes
        let numberOfEpisodes = episodes.count
        switch numberOfEpisodes {
        case 0:
            navigationItem.rightBarButtonItem?.isEnabled = false
        default:
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc func displayEpisodes(recognizer: UITapGestureRecognizer) {
        // Creamos el personsVC
        let episodesListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // LO pusheamos
        navigationController?.pushViewController(episodesListViewController, animated: true)
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
        self.model = model
        syncModelWithView()
    }
}

