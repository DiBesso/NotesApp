//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Дмитрий Бессонов on 14.01.2023.
//

import UIKit

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
    
    //MARK: - Add and save notes
    
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
