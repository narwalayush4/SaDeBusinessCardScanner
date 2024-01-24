//
//  ScannerView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI
import AVFoundation

struct QRScannerView: View {
    var body: some View {
        Text("QRScannerView")
    }
}

#Preview {
    QRScannerView()
}

struct QRCodeScanner: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<QRCodeScanner>) -> UIViewController {
        // Create a QR code scanner
        let scannerViewController = QRCodeScannerViewController()
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<QRCodeScanner>) {
        // Update the view controller
    }
}

class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // Set up the camera and capture session
    let captureSession = AVCaptureSession()
    let videoPreviewLayer: AVCaptureVideoPreviewLayer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // Initialize videoPreviewLayer in init method
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the capture session
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let input = try? AVCaptureDeviceInput(device: captureDevice!)
        captureSession.addInput(input!)
        
        // Set up the metadata output
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        // Start the capture session
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadata object contains a QR code
        if metadataObjects.count == 0 {
            return
        }
        
        // Get the first metadata object
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Check if the QR code contains a valid URL
        if metadataObj.type == AVMetadataObject.ObjectType.qr, let urlString = metadataObj.stringValue, let url = URL(string: urlString) {
            // Handle the valid URL
        }
    }
}
