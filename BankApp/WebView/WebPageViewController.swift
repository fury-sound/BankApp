//
//  WebPageViewController.swift
//  BankApp
//
//  Created by Valery Zvonarev on 16.05.2026.
//

import UIKit
import WebKit
import SwiftUI

final class WebPageViewController: UIViewController {

    // MARK: - Properties
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    private var loadingWorkItem: DispatchWorkItem?
    private var loadingTimeoutInterval: TimeInterval = 10
//    private var loadingTimeoutTask: DispatchWorkItem?
    private var url: URL?

    init(url: URL? = nil) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        openPage()
    }

    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .red
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(webView)
        view.addSubview(activityIndicatorView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func openPage() {
//        guard let url = URL(string: "https://apple.com") else { return }
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }

    private func updateLoadingState() {
        if webView.isLoading {
//            activityIndicatorView.startAnimating()
            startLoading()
        } else {
//            activityIndicatorView.stopAnimating()
            stopLoading()
        }
    }

    // MARK: - Actions
    //    @objc private func didTapButton(){
    //    }
}

extension WebPageViewController: WKNavigationDelegate {

    private func startLoading() {
        activityIndicatorView.startAnimating()
        loadingWorkItem?.cancel()

        let workItem = DispatchWorkItem { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.showTimeoutMessage()
        }
        loadingWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + loadingTimeoutInterval, execute: workItem)
    }

    private func stopLoading() {
        loadingWorkItem?.cancel()
        activityIndicatorView.stopAnimating()
    }

    private func showTimeoutMessage() {
        let alert = UIAlertController(title: "Timeout", message: "Слишком длительная загрузка", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping @MainActor (WKNavigationResponsePolicy) -> Void) {
//        activityIndicatorView.stopAnimating()
        stopLoading()
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("🟢 didStartProvisionalNavigation")
        updateLoadingState()
//        activityIndicatorView.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("🔴 didFinish")
        updateLoadingState()
//        activityIndicatorView.stopAnimating()
//        urlTextField.text = webView.url?.absoluteString
    } // конец загрузки

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        print("🔴 didFail")
        print(error.localizedDescription)
        updateLoadingState()
//        activityIndicatorView.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("🔴 didFailProvisionalNavigation 3")
        print("Provisional navigation failed: \(error.localizedDescription)")
        updateLoadingState()
//        activityIndicatorView.stopAnimating()
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("Received server redirect")
    }
}

#Preview {
    let url = URL(string: "https://www.apple.com")
    return WebPageViewController(url: url)
}

