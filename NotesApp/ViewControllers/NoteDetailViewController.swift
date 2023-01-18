//
//  NoteDetailViewController.swift
//  NotesApp
//
//  Created by Дмитрий Бессонов on 17.01.2023.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    var note: Note?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - Private Properties
    
    private var noteTitle: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 24, weight:.bold)
        textField.textColor = .label
        return textField
    }()
    
    private var noteTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .label
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        if let note = note {
            noteTitle.text = note.title
            noteTextView.text = note.text
        }
        
        noteTextView.delegate = self
        noteTitle.delegate = self
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
            y: 120,
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
}

// MARK: - Extension

extension NoteDetailViewController: UITextViewDelegate,
                                    UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        resignFirstResponder()
        guard let note = self.note else { return }
        if textField == noteTitle &&
            noteTitle.text! != note.title {
            
            let context =
            appDelegate.persistentContainer.viewContext
            note.title = noteTitle.text!
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        resignFirstResponder()
        guard let note = self.note else { return }
        if textView == noteTextView &&
            noteTextView.text != note.text {
            
            let context =
            appDelegate.persistentContainer.viewContext
            note.text = noteTextView.text
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
