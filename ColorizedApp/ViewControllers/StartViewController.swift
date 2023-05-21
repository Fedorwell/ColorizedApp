//
//  StartViewController.swift
//  ColorizedApp
//
//  Created by mac on 20.05.2023.
//

import UIKit


protocol SettingsViewControllerDelegate: AnyObject {
    func setBackgroundColor(_ color: UIColor)
}

final class StartViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.startVCBackgroundColor = view.backgroundColor
        settingsVC.delegate = self
  
    }
}
   
extension StartViewController: SettingsViewControllerDelegate {
        func setBackgroundColor(_ color: UIColor) {
            view.backgroundColor = color
        }
    }
    
    

    

    


