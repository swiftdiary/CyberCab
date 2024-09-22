//
//  QRCodeViewer.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRReaderView: View {
    @State private var inputText: String = "https://www.apple.com"
    @State private var qrImage: UIImage? = nil
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            TextField("Enter text or URL", text: $inputText, onCommit: {
                generateQRCode(from: inputText)
            })
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.URL)
            
            if let uimage = qrImage {
                Image(uiImage: uimage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Text("Enter text to generate a QR code")
                    .padding()
            }
            
            Spacer()
        }
        .onAppear {
            generateQRCode(from: inputText)
        }
    }
    
    // Generate a high-quality QR Code from a string
    func generateQRCode(from string: String) {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        if let outputImage = filter.outputImage?.transformed(by: transform) {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                qrImage = UIImage(cgImage: cgimg)
            }
        }
    }
}
