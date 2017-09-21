//
//  TextFieldRow.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class TextFieldRow: NSObject, Row {
    
    internal var cell: TextFieldRowCell?
    typealias CellType = TextFieldRowCell
    
    var titleText: String
    var placeholderText = ""
    var textFieldValue: String = ""
    var isSecureTextEntry = false
    var keyboardType = UIKeyboardType.default
    var disableAutoreplace = false
    
    public init(titleText: String) {
        self.titleText = titleText
    }
    
    func fill(cell: TextFieldRowCell) {
        cell.textField.placeholder = placeholderText
        cell.textLabel?.text = titleText
        cell.textField.text = textFieldValue
        cell.textField.delegate = self
        cell.textField.isSecureTextEntry = isSecureTextEntry
        cell.textField.keyboardType = keyboardType
        cell.textField.autocorrectionType = disableAutoreplace ? .no : .default
        cell.textField.autocapitalizationType = disableAutoreplace ? .none : .sentences
        cell.textField.spellCheckingType = disableAutoreplace ? .no : .default
        
    }
    
    func handleSelection() {
        cell?.textField.becomeFirstResponder()
    }
}

extension TextFieldRow: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldValue = textField.text ?? ""
    }
}

class TextFieldRowCell: UITableViewCell {

    fileprivate let textField = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let minimalLeftPosition = CGFloat(100)
        let spacing = contentView.layoutMargins.left
        
        let leftPosition: CGFloat = {
            guard let textLabel = textLabel else {
                return 0
            }
            return textLabel.frame.origin.x + textLabel.frame.width
        }()
        
        let x = max(minimalLeftPosition, leftPosition + spacing)
        let y = textLabel?.frame.origin.y ?? 0
        let width = bounds.size.width - x - contentView.layoutMargins.right
        let height = textLabel?.frame.size.height ?? 0
        
        textField.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
