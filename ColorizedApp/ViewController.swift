//
//  ViewController.swift
//  ColorizedApp
//
//  Created by mac on 28.04.2023.
//
//ColorizedApp
//


import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColor()
        rgbSliderChanged(redSlider)
        rgbSliderChanged(greenSlider)
        rgbSliderChanged(blueSlider)
        
        colorView.layer.cornerRadius = 12
        colorView.layer.masksToBounds = true
        
    }
    
    @IBAction func rgbSliderChanged(_ sender: UISlider) {
        changeColor()
        
        var valueRed = redSlider.value
        var valueGreen = greenSlider.value
        var valueBlue = blueSlider.value
        
        switch sender {
             case redSlider:
                 valueRed = sender.value
            redLabel.text = String(format: "%.2f", valueRed)
             case greenSlider:
                 valueGreen = sender.value
            greenLabel.text = String(format: "%.2f", valueGreen)
             case blueSlider:
                 valueBlue = sender.value
            blueLabel.text = String(format: "%.2f", valueBlue)
             default:
                 break
             }
        
        
//        if sender == redSlider {
//            valueRed = sender.value
//        } else if sender == greenSlider {
//            valueGreen = sender.value
//        } else if sender == blueSlider {
//            valueBlue = sender.value
//        }
//
//        redLabel.text = String(format: "%.2f", valueRed)
//        greenLabel.text = String(format: "%.2f", valueGreen)
//        blueLabel.text = String(format: "%.2f", valueBlue)
        
    }
    
    // MARK: - Private Methods
    
   private func changeColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}
    
//    private func setupRgbSlider(){
//        redSlider.value = 0.5  лишний код
//        redSlider.minimumValue = 0
//        redSlider.maximumValue = 1
        
//        greenSlider.value = 0.5 лишний код
//        greenSlider.minimumValue = 0
//        greenSlider.maximumValue = 1
        
//        blueSlider.value = 0.5 лишний код
//        blueSlider.minimumValue = 0
//        blueSlider.maximumValue = 1
        
        
    
    





