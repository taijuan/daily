//
//  SettingsViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift

class SettingsViewController: BaseViewController {
    @IBOutlet weak var backBtn: UIButton!{
        didSet{
            self.backBtn.setBackground()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            self.titleLabel.textColor = textBlack
            self.titleLabel.font = latoBold(20)
            self.titleLabel.text = "Settings"
        }
    }
    @IBOutlet weak var divider1: UIView!{
        didSet{
            self.divider1.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var divider2: UIView!{
        didSet{
            self.divider2.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var divider3: UIView!{
        didSet{
            self.divider3.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var divider4: UIView!{
        didSet{
            self.divider4.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var divider5: UIView!{
        didSet{
            self.divider5.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var notifictionPushLabel: UILabel!{
        didSet{
            self.notifictionPushLabel.textColor = textBlack
            self.notifictionPushLabel.font = latoRegular(16)
            self.notifictionPushLabel.text = "Notification Push"
        }
    }
    @IBOutlet weak var notificationPushSwitch: UISwitch!{
        didSet{
            self.notificationPushSwitch.onTintColor = textBlue
        }
    }
    @IBOutlet weak var clearCacheBtn: UIButton!{
        didSet{
            self.clearCacheBtn.setBackground()
        }
    }
    @IBOutlet weak var clearCacheLabel: UILabel!{
        didSet{
            self.clearCacheLabel.textColor = textBlack
            self.clearCacheLabel.font = latoRegular(16)
            self.clearCacheLabel.text = "Clear Cache"
        }
    }
    @IBOutlet weak var clearCacheValueLabel: UILabel!{
        didSet{
            self.clearCacheValueLabel.textColor = textGray
            self.clearCacheValueLabel.font = latoRegular(16)
            self.clearCacheValueLabel.text = "0.0M"
        }
    }
    @IBOutlet weak var aboutUsBtn: UIButton!{
        didSet{
            self.aboutUsBtn.setBackground()
        }
    }
    @IBOutlet weak var aboutUsLabel: UILabel!{
        didSet{
            self.aboutUsLabel.textColor = textBlack
            self.aboutUsLabel.font = latoRegular(16)
            self.aboutUsLabel.text = "About Us"
        }
    }
    private let clearCacheViewModel = ClearCacheViewModel()
    @IBOutlet weak var contactUsBtn: UIButton!{
        didSet{
            self.contactUsBtn.setBackground()
        }
    }
    @IBOutlet weak var contactUsLabel: UILabel!{
        didSet{
            self.contactUsLabel.textColor = textBlack
            self.contactUsLabel.font = latoRegular(16)
            self.contactUsLabel.text = "Contact Us"
        }
    }
    @IBOutlet weak var feedbackLable: UILabel!{
        didSet{
            self.feedbackLable.textColor = textBlack
            self.feedbackLable.font = latoRegular(16)
            self.feedbackLable.text = "Feedback"
        }
    }
    @IBOutlet weak var tintLabel: UILabel!{
        didSet{
            self.tintLabel.font = latoRegular(14)
            self.tintLabel.textColor = textGray.withAlphaComponent(0.8)
        }
    }
    @IBOutlet weak var feedbackTextView: UITextView!{
        didSet{
            self.feedbackTextView.font = latoRegular(14)
            self.feedbackTextView.textColor = textBlack
            self.feedbackTextView.keyboardType = .default
            self.feedbackTextView.returnKeyType = .next
        }
    }
    @IBOutlet weak var divdier6: UIView!{
        didSet{
            self.divdier6.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            let attr = [NSAttributedString.Key.foregroundColor:textGray,NSAttributedString.Key.font:latoRegular(14)]
            self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Your email address (optional)",attributes:attr)
            self.emailTextField.font = latoRegular(14)
            self.emailTextField.textColor = textBlack
            self.emailTextField.keyboardType = .default
            self.emailTextField.returnKeyType = .done
        }
    }
    @IBOutlet weak var divider7: UIView!{
        didSet{
            self.divider7.backgroundColor = dividerGray
        }
    }
    
    @IBOutlet weak var submitBtn: UIButton!{
        didSet{
            self.submitBtn.setViewShadow(borderColor:textBlue)
            self.submitBtn.setBackground(normalColor: textBlue, highLightColor: textBlue.withAlphaComponent(0.9))
            self.submitBtn.setTitleColor(textWhite, for: .normal)
            self.submitBtn.setTitleColor(textWhite, for: .highlighted)
            self.submitBtn.titleLabel?.font = latoRegular(16)
        }
    }
    
    @IBAction func contactUsAction(_ sender: Any) {
        self.navigationController?.pushViewController(contactUsViewController(), animated: true)
    }
    @IBAction func acboutUsAction(_ sender: Any) {
        self.navigationController?.pushViewController(aboutUsViewController(), animated: true)
    }
    @IBAction func clearCacheAction(_ sender: Any) {
        self.clearCacheViewModel.clearCache()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearCacheViewModel.cacheSize.observeOn(MainScheduler.instance).subscribe(onNext: { (total) in
            self.clearCacheValueLabel.text = total
        }).disposed(by: disposeBag)
        self.clearCacheViewModel.fetchCacheSize()
        
        self.feedbackTextView.delegate = self
        self.emailTextField.delegate = self
    }
    
    @IBAction func submitAction(_ sender: Any) {
        let content = self.feedbackTextView.text ?? ""
        let email = self.emailTextField.text ?? ""
        if content.isEmpty {
            self.view.showToast("content is empty")
            return
        }
        if email.isEmpty {
            self.view.showToast("email is empty")
            return
        }
        
        if !email.isEmail(){
            self.view.showToast("email is not correct")
            return
        }
        let dialog = LoadingViewController.createLoadingDialog()
        dialog.showLoading()
        FeedbackViewModel().feedback(content: content, email: email).subscribe(onNext: {data in
            //MARK:我不关心成功与否
            self.view.showToast("Success")
            self.navigationController?.popViewController(animated: true)
            dialog.hideLoading()
        }, onError:{ error in
            dialog.hideLoading()
        }).disposed(by: disposeBag)
    }
}

extension SettingsViewController : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text ?? ""
        let count = text.count
        self.tintLabel.isHidden = count != 0
        if count > 500{
            let a:String = String(text.prefix(500))
            textView.text = a
        }
    }
}

extension SettingsViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
