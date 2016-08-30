//
//  OtherViewController.swift
//  Demo02_UITextField
//
//  Created by Zorn on 16/8/30.
//  Copyright © 2016年 任大树. All rights reserved.
//

import UIKit

/**
 一、制定代理，实现传值 名称命名规范：本类名＋Delegate
 */
protocol OtherViewControllerDelegate: NSObjectProtocol {
    /**
     二、定义协议方法，用来传值
     */
    func changeValueWithUITextField(text: String)
}

class OtherViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    /**
     三、定义一个weak属性的代理
     */
    weak var delegate: OtherViewControllerDelegate!
    
    @IBAction func clicked(sender: AnyObject) {
        
        /**
         四、发送代理
         */
        self.delegate!.changeValueWithUITextField(self.textField.text!)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.delegate!.changeValueWithUITextField(self.textField.text!)
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
