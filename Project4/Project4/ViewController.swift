//
//  ViewController.swift
//  Project4
//
//  Created by Mitali Kulkarni on 3/2/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Set Navigation Bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, back, forward, space, refresh]
        navigationController?.isToolbarHidden = false
        
        // The addObserver() method takes four parameters:
        // who the observer is (we're the observer, so we use self),
        // what property we want to observe (we want the estimatedProgress property of WKWebView),
        // which value we want (we want the value that was just set, so we want the new one), and
        // a context value.
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
            //        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        
        // IMP for iPAD property is used only on iPad, and tells iOS where it should make the action sheet be anchored
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true, completion: nil)
    }
    
    // This method takes one parameter, which is the UIAlertAction object that was selected by the user. Obviously it won't be called if Cancel was tapped, because that had a nil handler rather than openPage.
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }

    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // Decide to allow or block navigation to happen
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // url to be equal to the URL of the navigation.
        let url = navigationAction.request.url
        
        // "host" it means "website domain"
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        let av = UIAlertController(title: "Blocked!", message: "This website is blocked", preferredStyle: .alert)
        av.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(av, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        if(webView.canGoBack) {
            webView.goBack()
        }
    }
    
    @objc func goForward(sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}


//  all view controllers automatically come with a toolbarItems array that automatically gets read in when the view controller is active inside a UINavigationController.
