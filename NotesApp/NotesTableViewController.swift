//
//  ViewController.swift
//  NotesApp
//
//  Created by Дмитрий Бессонов on 14.01.2023.
//

import UIKit

class NotesTableViewController: UITableViewController {

    var notes: [Note] = []
    
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
        navigationVC.modalPresentationStyle = .formSheet
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
        
        cell.textLabel?.text = notes[indexPath.row]
        
        return cell
    }
    
    
}

