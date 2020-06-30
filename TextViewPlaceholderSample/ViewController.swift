//
//  ViewController.swift
//  TextViewPlaceholderSample
//
//  Created by Robert Harrison on 6/28/20.
//  Copyright © 2020 RWH Technology, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet private var textView: UITextView!
    
    private static let placeholderText = "Placeholder text..."
    private static let placeholderTextColor = UIColor.lightGray
    private static let textColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textColor = ViewController.placeholderTextColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if textView.text.isEmpty || textView.text == ViewController.placeholderText {
            
            // Set First Responder
            textView.becomeFirstResponder()
            
            // Set the cursor at the beginning of the textView.
            textView.selectedTextRange = textView.textRange(
                from: textView.beginningOfDocument,
                to: textView.beginningOfDocument
            )
        }
    }

    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) { }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ViewController.placeholderText
            textView.textColor = ViewController.placeholderTextColor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        // The placeholder text remains visible until the user types something.
        
        if textView.text.isEmpty {
            
            // Show placeholder text.
            textView.text = ViewController.placeholderText
            textView.textColor = ViewController.placeholderTextColor
            textView.selectedTextRange = textView.textRange(
                from: textView.beginningOfDocument,
                to: textView.beginningOfDocument
            )
            
        } else if !textView.text.isEmpty && textView.text.count >= 1 {
            
            // Check if the placeholder text should be replaced with the text
            // that the user has typed.
            let text = textView.text.dropFirst()
            if text == ViewController.placeholderText,
                textView.textColor == ViewController.placeholderTextColor {
                textView.text = String(textView.text.first!)
                textView.textColor = ViewController.textColor
            }
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        
        if textView.text.count > 1 && textView.text == ViewController.placeholderText {
            textView.text = ""
            textView.textColor = ViewController.textColor
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        // Prevent the user from putting the cursor anywhere but the beginning,
        // if the placeholder text is displayed.
        if textView.text == ViewController.placeholderText &&
            textView.textColor == ViewController.placeholderTextColor {
            
            textView.selectedTextRange = textView.textRange(
                from: textView.beginningOfDocument,
                to: textView.beginningOfDocument
            )
        }
    }
}


