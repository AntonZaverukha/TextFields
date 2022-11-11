//
//  LinkRecognizeViewController.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit
import SafariServices

protocol LinkValidatorDelegate: AnyObject {
    func sfSafariOpen(urlString: String)
}

class LinkRecognizeViewController: UIViewController, UITextFieldDelegate, SFSafariViewControllerDelegate {
    @IBOutlet weak var linkRecognizeTextField: UITextField!
    var fourthProcess = LinkValidator()
    override func viewDidLoad() {
        super.viewDidLoad()
        fourthProcess.linkValidatorDelegate = self
        linkRecognizeTextField.delegate = self
        linkRecognizeTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        linkRecognizeTextField.layer.cornerRadius = 4
    }
}

extension LinkRecognizeViewController: LinkValidatorDelegate {
    func sfSafariOpen(urlString: String){
        if String.isValidUrl(url: urlString){
            var url: URL?
                url = URL(string: urlString)
            if let url = url {
                let sfViewController = SFSafariViewController(url: url)
                self.present(sfViewController, animated: true, completion: nil)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return fourthProcess.processFourthTextField(text: textField.text, replacementString: string)
    }
}
