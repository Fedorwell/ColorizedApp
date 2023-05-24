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

/*
 Строка "view.backgroundColor = color" устанавливает цвет фона для представления (view) текущего StartViewController.

 В методе setBackgroundColor в расширении StartViewController, который соответствует протоколу SettingsViewControllerDelegate, переданный цвет сохраняется в качестве цвета фона представления.

 Когда метод setBackgroundColor вызывается в SettingsViewController, он передает выбранный цвет на экран StartViewController через его делегата, который является экземпляром StartViewController. Затем цвет фона представления StartViewController обновляется, используя переданный цвет.
 */
    
    

    

    


