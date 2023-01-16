//
//  Extension.swift
//  NotesApp
//
//  Created by Дмитрий Бессонов on 16.01.2023.
//

import UIKit

    extension UIView {
        var width: CGFloat {
            frame.size.width
        }

        var height: CGFloat {
            frame.size.height
        }

        var left: CGFloat {
            frame.origin.x
        }

        var right: CGFloat {
            left + width
        }

        var top: CGFloat {
            frame.origin.y
        }

        var bottom: CGFloat {
            top + height
        }

    }
