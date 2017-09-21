//
//  EditorPresenter.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class EditorPresenter: UITableViewController, EditorUIEvents, EditorModuleInterface, EditorInteractorOutput {
    
    var userInterface: EditorUIInterface!
    var interactor: EditorInteractorInput!
    var delegate: EditorModuleDelegate?
    
    var form: ConnectionForm!
    
    enum State {
        case creation
        case editing(id: String)
    }
    
    var state: State?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        
        form.delete.selectionClosure = {
            self.didTapDelete()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        form.sections[indexPath.section].rows[indexPath.row].handleSelection()
    }

    func didTapCancel() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func didTapDone() {
        
        self.view.endEditing(true)
        
        guard let state = self.state else {
            return
        }
        
        var isCreation = false
        var editingID: String?
        
        switch state {
        case .creation:
            isCreation = true
        case .editing(let id):
            editingID = id
        }

        guard let connectionData = isCreation ? interactor.createConnection() : interactor.connection(from: editingID!) else {
            return
        }
        
        form.fill(data: connectionData)
                
        if interactor.save(connection: connectionData) {
            didSave()
        } else if isCreation {
            interactor.delete(connection: connectionData)
        }
    }
    
    func didTapDelete() {
        
        guard let connection = interactor.connection(from: editingID()!) else {
            return
        }
        
        interactor.delete(connection: connection)
        didDelete()
    }
    
    func editingID() -> String? {
        guard let state = state else {
            return nil
        }
        
        guard case State.editing(let ID) = state else {
            return nil
        }
        
        return ID
    }
        
    func didSave() {
        let _ = navigationController?.popViewController(animated: true)
        
        if let editingID = editingID() {
            delegate?.didEdit(connectionID: editingID)
        } else {
            delegate?.didAdd()
        }
    }
    
    func didDelete() {
        let _ = navigationController?.popViewController(animated: true)
        
        if let editingID = editingID() {
            delegate?.didDelete(connectionID: editingID)
        }
    }
    
    //MARK: EditorUIEvents 
    
    //MARK: EditorModuleInterface
    
    func prepareFormForCreation() {
        state = .creation

        form = ConnectionForm(includeDeleteButton: false)
        self.tableView.dataSource = form

        
        navigationItem.title = "New connection"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(EditorPresenter.didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(EditorPresenter.didTapDone))
    }

    func prepareFormForEditing(connectionID: String) {
        state = .editing(id: connectionID)
        guard let connectionData = interactor.connection(from: connectionID) else {
            return
        }
        
        form = ConnectionForm(includeDeleteButton: true)
        form.fill(with: connectionData)
        self.tableView.dataSource = form

        navigationItem.title = "Editing"
        navigationItem.hidesBackButton = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(EditorPresenter.didTapDone))
    }
}
