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
    //rewie: добавил weak ссылку, чтобы не было утечек памяти
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    //MARK: - Public properties
    
    unowned var delegate: SettingsViewControllerDelegate!
    var startVCBackgroundColor: UIColor! //rewie: добавил ссылку unowned, также для избежания утечек памяти, так как объекты могу ссылатья друг на друга
    
    //MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rewie: данные настройки лучше делать в storyBoard
        //        redTextField.keyboardType = UIKeyboardType.decimalPad
        //        greenTextField.keyboardType = UIKeyboardType.decimalPad
        //        blueTextField.keyboardType = UIKeyboardType.decimalPad
       
        doneButton.layer.cornerRadius = 15
        colorView.layer.cornerRadius = 15
       
        colorView.backgroundColor = startVCBackgroundColor
        
        //review методы лучше вызвать здесь
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
        
       
        //review: методы здесь не нужны
//        setupSlider() //review:  заменид название функции с getDefaultColor
//        keyboardToolbar()
        
//        //review: инициализация делегатов здесь не нужна
//        redTextField.delegate = self
//        greenTextField.delegate = self
//        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    /*
     My comments: Данный код относится к методу touchesBegan, который вызывается при нажатии (touches) на экран. Этот метод используется для обработки нажатий на экран и выполнения соответствующих действий.
     В данном случае, метод touchesBegan вызывается, когда пользователь нажимает на экран, и выполняет следующие действия:
     Вызывает метод super.touchesBegan, который передает событие дальше по цепочке ответственности (responder chain) для обработки другими объектами.
     Вызывает метод view.endEditing(true), который заканчивает редактирование текстовых полей и скрывает клавиатуру, если она отображается на экране.
     С помощью данного кода мы можем обеспечить удобство использования нашего приложения, позволяя пользователям закрывать клавиатуру, когда они нажимают на пустое место на экране.*/
    
    //MARK: - IBActions
    @IBAction func doneButtonPressed() {
        delegate?.setBackgroundColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    /* My comments: Данный код относится к методу doneButtonPressed, который вызывается при нажатии на кнопку "Готово" в экране SettingsViewController.
     В данном случае, метод doneButtonPressed выполняет следующие действия:
     Вызывает делегата, который был установлен StartViewController, используя свойство delegate.
     Вызывает метод setBackgroundColor у делегата и передает цвет фона, который был выбран пользователем в colorView.backgroundColor.
     Закрывает экран SettingsViewController, используя метод dismiss(animated: true), который закрывает текущий ViewController и возвращает пользователя на предыдущий экран.
     С помощью данного кода мы можем обеспечить изменение цвета фона нашего StartViewController и закрытие экрана SettingsViewController, когда пользователь нажимает на кнопку "Готово".*/
    
    @IBAction func rgbSliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel) //чем отличается for: от to: ?
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default: setValue(for: blueLabel)
            setValue(for: blueTextField)
            
        }
        
        setColor()
    }
    
}


    // MARK: - Private Methods
extension SettingsViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = stringFrom(redSlider)
            case greenLabel:
                label.text = stringFrom(greenSlider)
            default:
                label.text = stringFrom(blueSlider)
            }
        }
    }
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = stringFrom(redSlider)
            case greenTextField:
                textField.text = stringFrom(greenSlider)
            default:
                textField.text = stringFrom(blueSlider)
            }
        }
    }
    
    private func setValue(for colorSlider: UISlider...) {
        let ciColor = CIColor(color: startVCBackgroundColor)
        colorSlider.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(ciColor.red)
            case greenSlider:
                greenSlider.value = Float(ciColor.green)
            default:
                blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    /* My comments: Данный код описывает приватный метод setValue(for:), который используется для установки значений выбранных цветов на соответствующих метках (labels) и текстовых полях (text fields) в зависимости от выбранных значений на слайдерах.
     В данном случае, метод setValue(to:) выполняет следующие действия:
     Принимает в качестве аргумента один или несколько параметров типа UILabel.
     Использует метод forEach для перебора всех меток (labels), переданных в качестве аргументов.
     Для каждой метки (label) проверяет, к какому цветовому компоненту она относится (красному, зеленому или синему) с помощью оператора switch.
     В соответствии с выбранным цветовым компонентом устанавливает текст на метке (label) и текстовом поле (text field) для соответствующего цвета.
     Для установки текста на метке (label) использует метод stringFrom(_:), который преобразует значение на слайдере в строку с точностью до одного знака после запятой.
     С помощью данного кода мы можем установить значения выбранных цветов на соответствующих метках (labels) и текстовых полях (text fields), что позволяет пользователю видеть текущие значения выбранных цветов и вносить изменения в них с помощью слайдеров и текстовых полей.*/
    
    
    
    private func stringFrom(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in  textField?.text = "1.00"
            textField?.becomeFirstResponder() //?
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

    extension SettingsViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() //скрывает клавиатуру
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            guard let text = textField.text else {
            showAlert(title: "Wrong format!", message: "Please enter correct value")
            return
        }
        guard let valueTF = Float(text),
                (0...1).contains(valueTF) else {
            showAlert(
                title: "Wrong format!",
                message: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(valueTF, animated: true)
            setValue(for: redLabel)
        case greenTextField:
            greenSlider.setValue(valueTF, animated: true)
            setValue(for: greenLabel)
        default:
            blueSlider.setValue(valueTF, animated: true)
            setValue(for: blueLabel)
            
        }
        
        setColor()
    }
    
    /* My comments: Данный код описывает приватный метод `setColor()`, который используется для установки цвета на `colorView` в зависимости от значений выбранных цветов на слайдерах.
     В данном случае, метод `setColor()` выполняет следующие действия:
     1. Создает объект `UIColor` с помощью инициализатора `UIColor(red:green:blue:alpha:)`, который принимает четыре аргумента: значения красного, зеленого и синего цветовых компонентов (от 0 до 1) и значение прозрачности (от 0 до 1).
     2. Для установки значений красного, зеленого и синего цветовых компонентов использует значения на соответствующих слайдерах (redSlider, greenSlider и blueSlider), приводя их к типу `CGFloat`.
     3. Устанавливает цвет фона на `colorView` с помощью свойства `backgroundColor`.
     С помощью данного кода мы можем установить цвет фона на `colorView` в зависимости от значений выбранных цветов на слайдерах, что позволяет пользователю видеть текущий выбранный цвет и вносить изменения в него с помощью слайдеров. */
     
    // MARK: - UITextFieldDelegate
    
func textFieldDidBeginEditing(_ textField: UITextField) {
    let keyboardToolbar = UIToolbar()
    keyboardToolbar.sizeToFit()
    textField.inputAccessoryView = keyboardToolbar
    
    let doneButton = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: textField,
        action: #selector(resignFirstResponder)
    )
    
    let flexBarButton = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil
    )

keyboardToolbar.items = [flexBarButton, doneButton]

    }

}



