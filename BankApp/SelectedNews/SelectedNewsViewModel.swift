//
//  SelectedNewsViewModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 16.05.2026.
//

import UIKit

final class SelectedNewsViewModel {

    var imageHeightConstraint: NSLayoutConstraint?
//    private var pendingHTML: String?
//    private var didRenderHTML: Bool = false

//    func dateFormatted(with dateString: String) -> String {
//        let formatter = DateFormatter()
//        formatter.locale = Locale.current
////        formatter.locale = Locale(identifier: "ru_RU")
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd"
//        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
//        guard let date = inputFormatter.date(from: dateString) else {
//            return dateString
//        }
//        let outputFormatter = DateFormatter()
//        outputFormatter.dateStyle = .long
////        outputFormatter.locale = Locale.current
//        outputFormatter.locale = Locale(identifier: "ru_RU")
////        outputFormatter.timeStyle = .none
//        return outputFormatter.string(from: date)
//    }

    func htmlToText(_ html: String) -> String {
        guard let data = html.data(using: .utf8) else { return html }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: options,
                documentAttributes: nil
            )
            return attributedString.string
        } catch {
            return html
        }
        //        return html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    func updateImageHeight(_ image: UIImage, imageWidthValue: CGFloat) {
        //        view.layoutIfNeeded()
        //        let screenWidth = UIScreen.main.bounds.width - 20
        //        let imageWidth = cellImageView.bounds.width
        guard imageWidthValue > 0 else { return }
        let aspectRatio = image.size.height / image.size.width
        let newHeight = imageWidthValue * aspectRatio
        imageHeightConstraint?.constant = newHeight
    }

}


/*
    private func renderHTMLIfNeeded() {
        guard !didRenderHTML, let html = pendingHTML else { return }
        didRenderHTML = true
        displayHTML(htmlString: html, textView: mainText, maxWidth: mainText.bounds.width)
    }


    private func displayHTML(htmlString: String, textView: UITextView, maxWidth: CGFloat) {
        //            let styledHTML = """
        //        <style>
        //            body {
        //                color: \(UIColor.label);
        //                font-family: -apple-system, system-ui;
        //                font-size: 17px;
        //                margin: 0;
        //                padding: 0;
        //            }
        //            img {
        //                max-width: 100%;
        //                height: auto;
        //                display: block;
        //                margin: 10px 0;
        //            }
        //            /* Для адаптации к контейнеру */
        //            .content img {
        //                width: 100%;
        //                object-fit: contain;
        //            }
        //        </style>
        //        <div class="content">
        //        \(htmlString)
        //        </div>
        //        """

        //        guard let data = styledHTML.data(using: .utf8) else { return }
        guard let data = htmlString.data(using: .utf8) else { return }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue,
        ]

        //        let attributes: [NSAttributedString.Key: Any] = [
        //            .foregroundColor: UIColor.label,
        //            .font: UIFont.systemFont(ofSize: 18)
        //            //            .font: UIFont.preferredFont(forTextStyle: .body)
        //        ]

        do {
            //            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            //            attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
            let fullRange = NSRange(location: 0, length: attributedString.length)
            var attachments: [(range: NSRange, image: UIImage)] = []


            attributedString.enumerateAttribute(.attachment, in: fullRange, options: []) { value, range, _ in
                guard let attachment = value as? NSTextAttachment else { return }
                let image = attachment.image ?? attachment.image(forBounds: attachment.bounds, textContainer: nil, characterIndex: range.location)
                if let image {
                    attachments.append((range, image))
                }
            }

            let availableWidth = maxWidth - textView.textContainerInset.left - textView.textContainerInset.right

            for item in attachments.reversed() {
                let image = item.image
                guard image.size.width > 0 else { continue }
                let scale = min(1, availableWidth / image.size.width)
                let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
                let resizedAttachment = NSTextAttachment()
                resizedAttachment.image = image
                resizedAttachment.bounds = CGRect(origin: .zero, size: size)
                let imageString = NSMutableAttributedString(attachment: resizedAttachment)
                imageString.addAttributes([
                    .font: UIFont.systemFont(ofSize: 18)
                ], range: NSRange(location: 0, length: imageString.length))
                attributedString.replaceCharacters(in: item.range, with: imageString)
            }

            let wholeRange = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttributes([
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 18)
            ], range: wholeRange)

            textView.attributedText = attributedString
        } catch {
            print("HTML parsing error: \(error.localizedDescription)")
            textView.text = htmlString
        }
    }
*/


