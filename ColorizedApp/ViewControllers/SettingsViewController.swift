//
//  ViewController.swift
//  ColorizedApp
//
//  Created by mac on 28.04.2023.
//
//ColorizedApp
//

import UIKit

final class SettingsViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    //MARK: - Public properties
    
    var startVCBackgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.keyboardType = UIKeyboardType.decimalPad
        greenTextField.keyboardType = UIKeyboardType.decimalPad
        blueTextField.keyboardType = UIKeyboardType.decimalPad
        
        doneButton.layer.cornerRadius = 15
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = startVCBackgroundColor
        
        getDefaultColor()
        keyboardToolbar()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    
    @IBAction func doneButtonPressed() {
        delegate?.setBackgroundColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func rgbSliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(to: redLabel)
        case greenSlider:
            setValue(to: greenLabel)
        default: setValue(to: blueLabel)
            
        }
        
        setColor()
    }
    
}

//MARK: - Delegate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        guard let valueTF = Float(text) else { return }
        
        switch textField {
        case redTextField:
            redSlider.setValue(valueTF, animated: true)
            
        case greenTextField:
            greenSlider.setValue(valueTF, animated: true)
        default:
            blueSlider.setValue(valueTF, animated: true)
            
        }
        setColor()
        setValue(to: redLabel, greenLabel, blueLabel)
    }
    
}

extension SettingsViewController {
    
    private func getDefaultColor() {
        let CiColor = CIColor(color: startVCBackgroundColor)
        
        redSlider.value = Float(CiColor.red)
        greenSlider.value = Float(CiColor.green)
        blueSlider.value = Float(CiColor.blue)
        
        setValue(to: redLabel, greenLabel, blueLabel)
    }
    
    // MARK: - Private Methods
    private func setValue(to labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = stringFrom(redSlider)
                redTextField.text = redLabel.text
            case greenLabel:
                greenLabel.text = stringFrom(greenSlider)
                greenTextField.text = greenLabel.text
            default:
                blueLabel.text = stringFrom(blueSlider)
                blueTextField.text = blueLabel.text
            }
        }
    }
    
    private func stringFrom(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func keyboardToolbar() {
        
        let toolbar = UIToolbar()
        let emptySpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        let buttonDone = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(butDonePressed)
        )
        
        toolbar.barStyle = .default
        toolbar.items = [emptySpace, buttonDone]
        toolbar.sizeToFit()
        
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
    
    @objc private func butDonePressed() {
        view.endEditing(true)
    }
}





