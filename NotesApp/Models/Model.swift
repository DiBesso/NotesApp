//
//  Model.swift
//  NotesApp
//
//  Created by Дмитрий Бессонов on 16.01.2023.
//

import CoreData

@objc(Note)
  public class Note: NSManagedObject {

      @NSManaged public var text: String
      @NSManaged public var title: String
      @NSManaged public var date: Date
  }

  extension Note {
      @nonobjc public class func fetchRequest() ->
           NSFetchRequest<Note> {
          NSFetchRequest<Note>(entityName: "Note")
      }
  }

