//
//  ViewController.swift
//  Demo02_UITextField
//
//  Created by Zorn on 16/8/30.
//  Copyright © 2016年 任大树. All rights reserved.
//

import UIKit

/**
 一、遵守代理传值协议
 */
class ViewController: UIViewController,UITextFieldDelegate,OtherViewControllerDelegate {
    
    var textField: UITextField!
    
    
    @IBOutlet weak var btn: UIButton!
    
    //MARK: - 实现协议方法
    func changeValueWithUITextField(text: String) {
        self.textField.text = text
    }
    
    //MARK: - 代理传值方法 -> 跳转页面
    @IBAction func clicked(sender: AnyObject) {
        //代理传值
        let otherVC: OtherViewController = OtherViewController()
        otherVC.delegate = self
        self.navigationController?.pushViewController(otherVC, animated: true)
    }
    
    //MARK: - 移除监听
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.mainScreen().bounds.width
        
        //一、创建UITextField,并设置背景颜色
        let textField: UITextField = UITextField(frame: CGRectMake(50,100,width - 100,30))
//        textField.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(textField)
        self.textField = textField
        
        
        //二、设置背景视图,设置占位符，使用KVC设置占位符的颜色，文本字体及其颜色
//        textField.background = UIImage(named: "1.jpg")
        textField.placeholder = "任大树有感"
        textField.setValue(UIColor.blueColor(), forKeyPath: "placeholderLabel.textColor")
        textField.font = UIFont.systemFontOfSize(17)//系统默认字体
        textField.font = UIFont(name: "CourierNewPSMT", size: 17)//自定义字体和大小
        textField.textColor = UIColor.blackColor()
        textField.tintColor = UIColor.redColor()//光标及清除按钮颜色
        
        
        //三、设置对齐方式及垂直对齐方式,文本框样式，最小字体，自动适应标签大小
        textField.textAlignment = .Center
        textField.contentVerticalAlignment = .Bottom 
        /* 文本框样式
         None  不做修饰
         Line  线条
         Bezel 斜面
         RounderRect  扁平化
         */
        textField.borderStyle = .RoundedRect
        textField.minimumFontSize = 10.0//默认0.0
        textField.adjustsFontSizeToFitWidth = true
        
        
        
        //四、设置删除效果，编辑状态，文本框是否可用，首字母是否大写
         appearanceAction()
        //五、创建左视图及其显示类型，创建右视图及其显示类型
        viewAction()
        //六、富文本设置
        attributedAction()
        //七、设置Delegate
        textField.delegate = self
        //八、键盘外观
        keyboardAction()
        
        
    }
    
    //MARK: - 设置删除效果等
    func appearanceAction() {
        /* 删除效果
         Never 不显示清除按钮
         WhileEditing 编辑时才出现清除按钮
         UnlessEditing 完成编辑后才出现清除按钮
         Always 一直都显示清除按钮
         */
        textField.clearButtonMode = .Always
        textField.editing
        //        textField.enabled = false
        /* 首字母是否大写
         enum UITextAutocapitalizationType : Int {
         
         case None   不自动大写
         case Words  单词首字母大写
         case Sentences  句子的首字母大写
         case AllCharacters  所有字母都大写
         }
         */
        self.textField.autocapitalizationType = .AllCharacters
        self.textField.becomeFirstResponder()//成为第一响应
    }
    
    //MARK: - 键盘外观
    func keyboardAction() {
        /*
         1.键盘外观
         enum UIKeyboardAppearance : Int {
         
         case Default 默认外观
         case Dark  深灰石墨色
         case Light  浅灰色
         
         }
         */
        textField.keyboardAppearance = .Dark
        
        /*
         2.完成的按钮样式
         enum UIReturnKeyType : Int {
         
         case Default   默认灰色按钮，标有Return
         case Go   标有go的蓝色按钮
         case Google  标有Search的蓝色按钮
         case Join   标有Join的蓝色按钮
         case Next  标有Next的灰色按钮
         case Route  标有Route的蓝色按钮
         case Search  标有Search的蓝色按钮
         case Send    标有Send的蓝色按钮
         case Yahoo  标有Search的蓝色按钮
         case Done   标有Done的蓝色按钮
         case EmergencyCall   标有EmergencyCall(紧急呼叫)的蓝色按钮
         @available(iOS 9.0, *)
         case Continue     标有Continue的灰色按钮
         }
         */
        textField.returnKeyType = .Continue
    }
    //MARK: - 左视图和右视图
    func viewAction() {
        
        let leftView: UIImageView = UIImageView(frame: CGRectMake(0,0,30,30))
        leftView.image = UIImage(named: "1.jpg")
        /* 同上
         Never 不显示
         WhileEditing 编辑时才出现
         UnlessEditing 完成编辑后才出现
         Always 一直都显示
         */
        textField.leftView = leftView
        textField.leftViewMode = .Always
        //右视图，可能盖住了清除按钮
        let rightView: UIImageView = UIImageView(frame: CGRectMake(0,0,30,30))
        rightView.backgroundColor = UIColor.purpleColor()
        textField.rightView = rightView
        textField.rightViewMode = .UnlessEditing

    }
    //MARK: - 富文本设置
    func attributedAction() {
        
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString(string: "任大树有感")
        attributeStr.addAttribute(NSFontAttributeName, value: UIFont(name: "CourierNewPSMT", size: 17)!, range: NSRange(location: 0,length: 3))
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: NSRange(location: 0,length: 5))
        attributeStr.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellowColor(), range: NSRange(location: 3, length: 2))
        
        self.textField.attributedPlaceholder = attributeStr
        
        notificationAction()
    }
    
    
    //MARK: - 监听的方法
    func notificationAction() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidChange), name: UITextFieldTextDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidEndEditing), name: UITextFieldTextDidEndEditingNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidBeginEditing), name: UITextFieldTextDidBeginEditingNotification, object: nil)
    }
    func textDidChange() {
       print("每次编辑触发该事件")
    }
    func textDidEndEditing() {
       print("结束编辑触发该事件")
    }
    func textDidBeginEditing() {
       print("开始编辑")
    }
    
    //MARK: - 点击View撤回键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.textField.resignFirstResponder()
    }

     //MARK: - UITextField协议方法
    //1.文本框将要开始编辑时，触发的事件
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{ // return NO to disallow editing.(如果返回 false 文本框将不允许编辑)
        
        return true
    }
    //2.文本框开始编辑，所作的事儿
    func textFieldDidBeginEditing(textField: UITextField){ // became first responder
    
    }
    //3.文本框将要结束编辑时，触发该事件
    func textFieldShouldEndEditing(textField: UITextField) -> Bool{ // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

        return true
    }
    //4.文本框结束编辑，触发的事件。
    func textFieldDidEndEditing(textField: UITextField){ // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        
        
    }
    //5.文本框内容改变触发该事件，能得到改变的坐标和改变的内容
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{ // return NO to not change text(返回 false 不可改变文本)
        
        
        return true
    }
    //6.文本框清空时触发该事件
    func textFieldShouldClear(textField: UITextField) -> Bool{ // called when clear button pressed. return NO to ignore (no notifications) (返回true，当清除按钮点击时回调此方法，返回false则忽视)
    
        print("文本框内容被清除拉！！")
        
       
        return true
    }
    //7.点击键盘中的return键，触发该事件
    func textFieldShouldReturn(textField: UITextField) -> Bool{ // called when 'return' key pressed. return NO to ignore.
        
        print("点击了键盘中的return")//微信把此事件改为 发送消息事件
        return true
    }
}

