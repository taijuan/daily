//
//  WebViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/6.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var divider: UIView!
    private lazy var loadingDialog = LoadingView(self.view)
    private let webView = WKWebView()
    private var xTitle:String = ""
    private var url:String = ""
    func setTitle(_ title:String){
        self.xTitle = title
    }
    func setUrl(_ url:String){
        self.url = url
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingDialog.showLoading()
        self.divider.backgroundColor = dividerGray
        self.titleLabel.text = xTitle
        self.backBtn.setBackground()
        self.webViewContainer.addSubview(self.webView)
        self.webView.backgroundColor = .white
        self.webView.load(URLRequest(url: URL(string: self.url)!))
        self.webView.navigationDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        self.webView.frame = self.webViewContainer.bounds
    }
}

extension WebViewController:WKNavigationDelegate{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        self.navigationItem.title = "加载中..."
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        self.loadingDialog.hideLoading()
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url?.absoluteString ?? ""
        if self.url != url && url.contains(".pdf"){
            self.navigationController?.pushViewController(webViewController("ePaper", url), animated: true)
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
    }
}
