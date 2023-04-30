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
        setupRgbSlider()
        changeColor()
        rgbSliderChanged(self)
        
        colorView.layer.cornerRadius = 12
        colorView.layer.masksToBounds = true
        
    }
    
    func changeColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1 )
    }
    
    @IBAction func rgbSliderChanged(_ sender: Any) {
        changeColor()
        let valueRed = redSlider.value
        let valueGreen = greenSlider.value
        let valueBlue = blueSlider.value
        
        redLabel.text = String(format: "%.2f", valueRed)
        greenLabel.text = String(format: "%.2f", valueGreen)
        blueLabel.text = String(format: "%.2f", valueBlue)
    }
    
    // MARK: - Private Methods
    
    private func setupRgbSlider(){
        redSlider.value = 0.5
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        
        greenSlider.value = 0.5
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        
        blueSlider.value = 0.5
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
        
        changeColor()
        
    }
    
}




