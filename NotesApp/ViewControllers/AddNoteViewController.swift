//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Дмитрий Бессонов on 14.01.2023.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private var noteTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название"
        textField.font = UIFont.systemFont(ofSize: 24, weight:.bold)
        textField.textColor = .label
        return textField
    }()
    
    private var noteTextView: UITextView = {
        let view = UITextView()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .label
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addAndSaveNotes()
        addBackButton()
    }
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(noteTitle)
        view.addSubview(noteTextView)
        
        setFrameTextFields()
    }
    
    //MARK: - Setting frame textFields
    
    func setFrameTextFields() {
        noteTitle.frame = CGRect(
            x: 20,
            y: 150,
            width: view.width - 40,
            height: 44
        )
        noteTextView.frame = CGRect(
            x: 16,
            y: noteTitle.bottom + 20,
            width: view.width - 32,
            height: view.bottom - 250
        )
    }
    
    // MARK: - add buttons on navigationBar
    
    private func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .done,
            target: self,
            action: #selector(didTapBackButton)
        )
    }
    
    @objc private func didTapBackButton() {
        self.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func addAndSaveNotes() {
        title = "Новая заметка"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(didTapSaveButton)
        )
        noteTitle.delegate = self
        noteTextView.delegate = self
    }
    
    @objc private func didTapSaveButton() {
        
        if noteTitle.text!.isEmpty || noteTextView.text.isEmpty {
            let alertController = UIAlertController(
                title: "Добавьте изменения",
                message: "Введите название и текст",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(
                title: "Ok",
                style: .cancel,
                handler: nil
            )
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate
                as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
        
        let note = Note(entity: entity, insertInto: context)
        
        note.title = (noteTitle.text! as NSObject) as! String
        note.text = (noteTextView.text as NSObject) as! String
        note.date = (Date.now as NSObject) as! Date
        
        do {
            try context.save()
            
            let alertController = UIAlertController(
                title: "Заметка сохранена",
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

// MARK: - Extension

extension AddNoteViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        noteTitle.resignFirstResponder()
        if textField == noteTitle &&
            !noteTitle.text!.isEmpty {
            noteTextView.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) ->
    Bool {
        noteTitle.resignFirstResponder()
        noteTextView.becomeFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == noteTextView &&
            noteTextView.text == "" {
            textView.text = ""
            noteTextView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == noteTextView &&
            noteTextView.text.isEmpty {
            textView.text = ""
            noteTextView.textColor = .label
        }
    }
}
