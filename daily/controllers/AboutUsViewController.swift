//
//  AboutUsViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!{
        didSet{
            self.backBtn.setBackground()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            self.titleLabel.font = latoBold(20)
            self.titleLabel.textColor = textBlack
            self.titleLabel.text = "About Us"
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
    @IBOutlet weak var versionLabel: UILabel!{
        didSet{
            self.versionLabel.font = latoRegular(18)
            self.versionLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var buildLabel: UILabel!{
        didSet{
            self.buildLabel.font = latoRegular(16)
            self.buildLabel.textColor = textGray
            self.buildLabel.text = "\(getVersionName()) Build \(getVersionCode())"
        }
    }
    @IBOutlet weak var divider: UIView!{
        didSet{
            self.divider.backgroundColor = dividerGray
        }
    }
    @IBOutlet weak var dividerLabel: UILabel!{
        didSet{
            self.dividerLabel.font = latoRegular(18)
            self.dividerLabel.textColor = textBlack
        }
    }
    @IBOutlet weak var contentLabel: UILabel!{
        didSet{
            self.contentLabel.setText(text: "Launched in 1997, the China Daily Hong Kong Edition offers a unique local perspective that has become essential reading for decision-makers, including HKSAR government officials, CEOs and senior executives, scholars and academics in Hong Kong.\n\nAs Hong Kong maintains its critical role as the gateway to the Chinese mainland, China Daily Hong Kong Edition offers a ringside view of the dynamic economic and social development underway on the Chinese mainland, both in print and in digital form. The newspaper connects local readers to the Chinese mainland, with first-hand, critical insight that cannot be duplicated by other local news media. A roster of Hong Kong opinion leaders and freelance writers add their contributions, helping to ensure that the newspaper remains closely connected to the local community.\n\nFocus Hong Kong, published every Friday, is a brand new weekly edition specially designed for readers in the city, in addition to the daily fare of news and views.\n\n The new offering covers a wide range of subjects, from business and the economy to social and environmental issues, among many others. It carries incisive and insightful commentaries on current affairs and issues that are important to Hong Kong.", font: latoRegular(16), lineHeight: 25)
            self.contentLabel.textColor = textBlack
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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
