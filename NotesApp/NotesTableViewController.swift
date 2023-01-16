//
//  ViewController.swift
//  NotesApp
//
//  Created by Дмитрий Бессонов on 14.01.2023.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    var notes: [Note] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchNotes()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    //MARK: - Set Navigation
    
    private func setNavigationBar() {
        title = "Заметки"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    @objc private func didTapAddButton() {
        let addNoteVC = AddNoteViewController()
        let navigationVC = UINavigationController(rootViewController: addNoteVC)
        navigationVC.navigationBar.prefersLargeTitles = true
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true, completion: nil)
    }
    
    
    // MARK: - TableView Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let appDelegate = UIApplication.shared.delegate
                    as? AppDelegate else { return }
            let context =
            appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            
            if let notes = try? context.fetch(fetchRequest) {
                self.notes.remove(at: indexPath.row)
                let note = notes[indexPath.row]
                context.delete(note)
                tableView.reloadData()
            }
            
            do {
                try context.save()
                
                let alertController = UIAlertController(
                    title: "Заметка удалена",
                    message: "",
                    preferredStyle: .alert
                )
                
                let okayAction = UIAlertAction(
                    title: "Ok",
                    style: .cancel) { [weak self] _ in
                        guard let self = self else { return }
                        self.dismiss(animated: true) {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                
                alertController.addAction(okayAction)
                present(alertController, animated: true)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.indexPathForSelectedRow != nil  else { return }
        let noteDetailVC = NoteDetailViewController()
        self.navigationController?.pushViewController(noteDetailVC, animated: true)
        noteDetailVC.note = notes[indexPath.row]
    }
    
}

// MARK: - Extension
extension NotesTableViewController {
    
    private func fetchNotes() {
        guard let appDelegate = UIApplication.shared.delegate
                as? AppDelegate else { return }
        let context =
        appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            notes = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

