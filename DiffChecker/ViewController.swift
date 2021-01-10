//
//  ViewController.swift
//  DiffChecker
//
//  Created by Madji on 4.01.21.
//

import UIKit
import PDFKit


class ViewController: UIViewController {

    let fileName: String = "text.txt"
    var textReady: String?
    
    @IBOutlet var loadButton: UIView!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loadButtonTappped(_ sender: Any) {
        loadFile(with: fileName)
    
    }
}

extension ViewController {
    
    private func loadFile(with fileName: String) {
        
        let documentPicker =
            UIDocumentPickerViewController(documentTypes: ["public.image", "public.jpeg", "public.text", "com.adobe.pdf"],
                                           in: .open)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true
//        documentPicker.modalPresentationStyle = .fullScreen
        self.present(documentPicker, animated: true, completion: nil)
    }
}

extension ViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("documentPicker with urls \(urls)")
        
        guard controller.documentPickerMode == .open, let url = urls.first, url.startAccessingSecurityScopedResource() else {
            print("documentPicker with ERROR")
            return
        }
        defer {
            DispatchQueue.main.async {
                url.stopAccessingSecurityScopedResource()
            }
        }
        
                
        
        // MARK: - load text document
        
        let textDoc = (fileURL: url)
        textView.text = textDoc
        

        
        // MARK: - load PDFDocument
        /*
        guard let pdf = PDFDocument(url: url) else { return }
        let pdfPages = pdf.pageCount
        let documentContent = NSMutableAttributedString()
        
        for i in 1 ..< pdfPages {
            guard let page = pdf.page(at: i) else { continue }
            guard let pageContent = page.attributedString else { continue }
            documentContent.append(pageContent)
        }
        
        
        textView.attributedText = documentContent
        */
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("documentPicker was canceled")
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("documentPicker with url \(url)")
    }
}

/*
 if let pdf = PDFDocument(url: url) {
     let pageCount = pdf.pageCount
     let documentContent = NSMutableAttributedString()

     for i in 1 ..< pageCount {
         guard let page = pdf.page(at: i) else { continue }
         guard let pageContent = page.attributedString else { continue }
         documentContent.append(pageContent)
     }
 }
 */




/*
 
 let file = "file.txt" //this is the file. we will write to and read from it

 let text = "some text" //just a text

 if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

     let fileURL = dir.appendingPathComponent(file)

     //writing
     do {
         try text.write(to: fileURL, atomically: false, encoding: .utf8)
     }
     catch {/* error handling here */}

     //reading
     do {
         let text2 = try String(contentsOf: fileURL, encoding: .utf8)
     }
     catch {/* error handling here */}
 }
 
 let fileName = "Test"
 let dir = try? FileManager.default.url(for: .documentDirectory,
       in: .userDomainMask, appropriateFor: nil, create: true)

 // If the directory was found, we write a file to it and read it back
 if let fileURL = dir?.appendingPathComponent(fileName).appendingPathExtension("txt") {

     // Write to the file named Test
     let outString = "Write this text to the file"
     do {
         try outString.write(to: fileURL, atomically: true, encoding: .utf8)
     } catch {
         print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
     }

     // Then reading it back from the file
     var inString = ""
     do {
         inString = try String(contentsOf: fileURL)
     } catch {
         print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
     }
     print("Read from the file: \(inString)")
 }
 

 */
