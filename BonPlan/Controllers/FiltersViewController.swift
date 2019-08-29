//
//  FiltersViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 26/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

protocol categoryDelegate {
    func valueLable(update : String)
}
class FiltersViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    @IBOutlet weak var appliquer: UIButtonX!
   // var vc = DashboardViewController()
    
    @IBOutlet weak var exitBtn: UIButtonX!
    
    var delegate : categoryDelegate?
    
    @IBOutlet weak var categorie: SkyFloatingLabelTextFieldWithIcon!
    var selectedCategory : String = " "
    @IBAction func appliquerAction(_ sender: Any) {
        
        if (categorie.text?.characters.count)! > 0 {
            delegate!.valueLable(update: categorie.text!)
        self.dismiss(animated: true, completion: nil)
          }
    }
  
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .ended:
                print (Int(slider.value))
                break
            default:
                break
            }
        }
    }
    @IBAction func exitBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        self.dismiss(animated: true, completion: nil)

    }
    var picker: UIPickerView?
   // var pickerData: [String] = ["Sport", "Café", "Resto", "Santé "]
    @IBOutlet weak var slider: UISlider!
    
    
    var pickerData: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        //self.picker?.reloadAllComponents()
        picker?.delegate = self
        picker?.dataSource = self
        categorie?.inputView = picker
        categorie?.inputAccessoryView = UIToolbar().ToolbarPicker(mySelect: #selector(pickerShouldReturn))
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    }
    
      
    override func viewDidAppear(_ animated: Bool) {
        fillCategoryArray()
    }
       
    func fillCategoryArray(){
        WebServiceBP.init().getCategories() { (response, isTrue) in
            if isTrue{
                self.pickerData.removeAll()
                print (response)
                for rep in response{
                    let categoryName = rep.object(forKey: "category_name") as! String
                    self.pickerData.append(categoryName)
                    
                }
                
            }
            else{
                print ("something went wrong")
            }
        }
    }
    }
        extension FiltersViewController{
            @objc func pickerShouldReturn()
    {
        self.categorie.resignFirstResponder()
    }
            override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        categorie.text = pickerData[row]
        
    }
}
