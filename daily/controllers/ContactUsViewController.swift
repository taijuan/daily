//
//  ContactUsViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!{
        didSet{
            self.backBtn.setBackground()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            self.titleLabel.textColor = textBlack
            self.titleLabel.font = latoBold(20)
        }
    }
    @IBOutlet weak var logoView: UIView!{
        didSet{
            self.logoView.backgroundColor = dividerGray
        }
    }
    
    @IBOutlet weak var appNameLabel: UILabel!{
        didSet{
            self.appNameLabel.font = latoBold(18)
            self.appNameLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var contactUSLabel: UILabel!{
        didSet{
            self.contactUSLabel.font = latoBold(16)
            self.contactUSLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var addressLabel: UILabel!{
        didSet{
            self.addressLabel.font = latoRegular(16)
            self.addressLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var addressBtn: UIButton!{
        didSet{
            self.addressBtn.titleLabel?.font = latoRegular(12)
            self.addressBtn.setTitleColor(textGray, for: .normal)
            self.addressBtn.setTitleColor(textGray, for: .highlighted)
            self.addressBtn.setViewShadow(borderColor: textBlue)
            self.addressBtn.setBackground()
        }
    }
    @IBOutlet weak var hotlineLabel: UILabel!{
        didSet{
            self.hotlineLabel.font = latoRegular(16)
            self.hotlineLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var hotlineBtn: UIButton!{
        didSet{
            self.hotlineBtn.titleLabel?.font = latoRegular(12)
            self.hotlineBtn.setTitleColor(textGray, for: .normal)
            self.hotlineBtn.setTitleColor(textGray, for: .highlighted)
            self.hotlineBtn.setViewShadow(borderColor: textBlue)
            self.hotlineBtn.setBackground()
        }
    }
    @IBOutlet weak var faxLabel: UILabel!{
        didSet{
            self.faxLabel.font = latoRegular(16)
            self.faxLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var faxBtn: UIButton!{
        didSet{
            self.faxBtn.titleLabel?.font = latoRegular(12)
            self.faxBtn.setTitleColor(textGray, for: .normal)
            self.faxBtn.setTitleColor(textGray, for: .highlighted)
            self.faxBtn.setViewShadow(borderColor: textBlue)
            self.faxBtn.setBackground()
        }
    }
    @IBOutlet weak var emailLabel: UILabel!{
        didSet{
            self.emailLabel.font = latoRegular(16)
            self.emailLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var emailBtn: UIButton!{
        didSet{
            self.emailBtn.titleLabel?.font = latoRegular(12)
            self.emailBtn.setTitleColor(textGray, for: .normal)
            self.emailBtn.setTitleColor(textGray, for: .highlighted)
            self.emailBtn.setViewShadow(borderColor: textBlue)
            self.emailBtn.setBackground()
        }
    }
    @IBOutlet weak var divider: UIView!{
        didSet{
            self.divider.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var accessLabel: UILabel!{
        didSet{
            self.accessLabel.font = latoBold(16)
            self.accessLabel.textColor = textBlack
        }
    }
    
    @IBOutlet weak var accessContentLabel: UILabel!{
        didSet{
            self.accessContentLabel.font = latoRegular(16)
            self.accessContentLabel.textColor = textBlack
        }
    }
    
    @IBOutlet weak var accessEmailLabel: UILabel!{
        didSet{
            self.accessEmailLabel.font = latoRegular(16)
            self.accessEmailLabel.textColor = textBlack
        }
    }
    
    @IBOutlet weak var aceessEmailBtn: UIButton!{
        didSet{
            self.aceessEmailBtn.titleLabel?.font = latoRegular(12)
            self.aceessEmailBtn.setTitleColor(textGray, for: .normal)
            self.aceessEmailBtn.setTitleColor(textGray, for: .highlighted)
            self.aceessEmailBtn.setViewShadow(borderColor: textBlue)
            self.aceessEmailBtn.setBackground()
        }
    }
    
    @IBOutlet weak var footerView: UIView!{
        didSet{
            self.footerView.backgroundColor = backgroundBlue
        }
    }
    
    @IBOutlet weak var footerLabel: UILabel!{
        didSet{
            self.footerLabel.font = latoRegular(12)
            self.footerLabel.textColor = textWhite
            self.footerLabel.text = "\(year()) China Daily Hong Kong Limited.  All rights reserved. "
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addressAction(_ sender: Any) {
        UIPasteboard.general.string = "Unit 1818, 18/F, Hing Wai Centre, 7 Tin Wan Praya Road, Aberdeen, Hong Kong"
        self.view.showToast("success")
    }
    @IBAction func hotlineAction(_ sender: Any) {
        UIPasteboard.general.string = "(852) 2518 5111"
        self.view.showToast("success")
    }
    @IBAction func faxAction(_ sender: Any) {
        UIPasteboard.general.string = "(852) 2554 7704"
        self.view.showToast("success")
    }
    @IBAction func emailAction(_ sender: Any) {
        UIPasteboard.general.string = "editor@chinadailyhk.com"
        self.view.showToast("success")
    }
    @IBAction func aceessEmailAction(_ sender: Any) {
        UIPasteboard.general.string = "accessibility@chinadailyhk.com"
        self.view.showToast("success")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
