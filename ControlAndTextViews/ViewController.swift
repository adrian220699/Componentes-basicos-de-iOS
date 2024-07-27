//
//  ViewController.swift
//  ControlAndTextViews
//
//  Created by Adrian Flores Herrera on 7/22/24.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!

    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myProgresView: UIProgressView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var myTextFiled: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    // Variables
    private let myPickerViewValues = ["Uno", "Dos", "Tres", "Cuatro", "Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Buttons
        myButton.setTitle("Mi botón", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        myButton.isHidden = true
        
        // Pickers
        myPickerView.backgroundColor = .lightGray
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.isHidden = true
        
        // PageControls
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .blue
        myPageControl.pageIndicatorTintColor = .lightGray
        myPageControl.isHidden = true
        
        // SegmentedControls
        mySegmentedControl.removeAllSegments()
        for (index, value) in myPickerViewValues.enumerated() {
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        mySegmentedControl.isHidden = true
        
        // Sliders
        mySlider.minimumTrackTintColor = .red
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        mySlider.isHidden = true
        
        // Steppers
        myStepper.minimumValue = 1
        myStepper.maximumValue = Double(myPickerViewValues.count)
        myStepper.value = 1 // Inicialmente establecido en 1
        myStepper.isHidden = true
        
        // Switch
        
        mySwitch.onTintColor = .purple
        mySwitch.isOn = false
        
        // Progres Indicators
        myProgresView.progress = 0
        
        // Activity Indicator
        
        myActivityIndicator.color = .green
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true
        
        // Labels
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 36)
        
        mySwitchLabel.text = "Esta apagado"
        
        // TextFields
        
        myTextFiled.textColor = .brown
        myTextFiled.placeholder = "Escribe algo"
        myTextFiled.delegate = self
        
        //TextView
        
        myTextView.textColor = .brown
        myTextView.delegate = self
        
        // Actualizar la interfaz inicialmente
        updateUIForStepperValue(1)
    }
    
    // Actions
    
    @IBAction func myButtonAc(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
        } else {
            myButton.backgroundColor = .blue
        }
        
        myTextView.resignFirstResponder()
    }
    
    @IBAction func myPageActionControl(_ sender: Any) {
        let currentPage = myPageControl.currentPage
        updateUIForStepperValue(currentPage + 1)
    }
    
    @IBAction func mySegmentControlAction(_ sender: Any) {
        let selectedIndex = mySegmentedControl.selectedSegmentIndex
        updateUIForStepperValue(selectedIndex + 1)
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        let sliderValue = Int(mySlider.value)
        updateUIForStepperValue(sliderValue)
    }
    
    @IBAction func myStepperAction(_ sender: UIStepper) {
        let stepperValue = Int(sender.value)
        updateUIForStepperValue(stepperValue)
    }
    
    // Función para actualizar la interfaz basada en el valor del Stepper
    private func updateUIForStepperValue(_ value: Int) {
        let selectedIndex = value - 1
        // Update UIButton
        let buttonText = myPickerViewValues[selectedIndex]
        myButton.setTitle(buttonText, for: .normal)
        
        // Update PageControl
        myPageControl.currentPage = selectedIndex
        
        // Update SegmentedControl
        mySegmentedControl.selectedSegmentIndex = selectedIndex
        
        // Update Slider
        mySlider.value = Float(value)
        
        // Update UIPickerView
        myPickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        
        // ProgresView
        myProgresView.progress = Float(value-1) / 4
        
        myStepperLabel.text = "\(value)"
        
        
        // Update Stepper
        myStepper.value = Double(value)
    }
    
    @IBAction func mySwitchAction(_ sender: Any) {
        
        if mySwitch.isOn {
            
            myPickerView.isHidden = false
            myButton.isHidden = false
            myStepper.isHidden = false
            mySlider.isHidden = false
            myPageControl.isHidden = false
            mySegmentedControl.isHidden = false
            myActivityIndicator.stopAnimating()
            mySwitchLabel.text = "Esta encendido"
            
        } else {
            
            myPickerView.isHidden = true
            myButton.isHidden = true
            myStepper.isHidden = true
            mySlider.isHidden = true
            myPageControl.isHidden = true
            mySegmentedControl.isHidden = true
            myActivityIndicator.startAnimating()
            mySwitchLabel.text = "Esta apagado"
        }
        
    }
    
}

// UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateUIForStepperValue(row + 1)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(myTextFiled.text, for: .normal)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextFiled.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextFiled.isHidden = false
    }
}
