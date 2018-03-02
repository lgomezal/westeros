//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by luis gomez alonso on 25/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var emisionDateLabel: UILabel!
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Initializations
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
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
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func seasonDidChange(notification: Notification) {
        self.navigationController?.popViewController(animated: false)
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        title = model.title
        titleLabel.text = model.title
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/mm/yyyy"
        let emision = dateformatter.string(from: model.emisionDate)
        emisionDateLabel.text = emision
        episodeImage.image = model.image
    }
    
}

