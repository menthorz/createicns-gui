//
//  AppState.swift
//  createicns-gui
//

import SwiftUI
import Backend
import Foundation

@MainActor
class AppState: ObservableObject {
    @Published var inputImagePath: String = ""
    @Published var outputPath: String = ""
    @Published var outputType: OutputType = .infer
    @Published var isProcessing: Bool = false
    @Published var statusMessage: String = ""
    @Published var showingError: Bool = false
    @Published var errorMessage: String = ""
    @Published var showingSuccess: Bool = false
    @Published var dragOver: Bool = false
    
    var hasValidInput: Bool {
        !inputImagePath.isEmpty && FileManager.default.fileExists(atPath: inputImagePath)
    }
    
    var canProcess: Bool {
        hasValidInput && !isProcessing
    }
    
    func selectInputFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.png, .jpeg, .tiff, .bmp, .gif]
        panel.title = "Select Image File"
        panel.message = "Choose an image file to convert to icns/iconset"
        
        if panel.runModal() == .OK {
            if let url = panel.url {
                inputImagePath = url.path
                generateDefaultOutputPath()
            }
        }
    }
    
    func selectOutputPath() {
        let panel = NSSavePanel()
        panel.allowedContentTypes = outputType == .icns ? [.init(filenameExtension: "icns")!] : []
        panel.title = "Save As"
        panel.nameFieldStringValue = suggestedOutputName()
        
        if panel.runModal() == .OK {
            if let url = panel.url {
                outputPath = url.path
            }
        }
    }
    
    func generateDefaultOutputPath() {
        let inputURL = URL(fileURLWithPath: inputImagePath)
        let baseName = inputURL.deletingPathExtension().lastPathComponent
        let directory = inputURL.deletingLastPathComponent()
        
        let fileExtension = outputType == .icns ? "icns" : "iconset"
        outputPath = directory.appendingPathComponent("\(baseName).\(fileExtension)").path
    }
    
    private func suggestedOutputName() -> String {
        if !inputImagePath.isEmpty {
            let inputURL = URL(fileURLWithPath: inputImagePath)
            let baseName = inputURL.deletingPathExtension().lastPathComponent
            let fileExtension = outputType == .icns ? "icns" : "iconset"
            return "\(baseName).\(fileExtension)"
        }
        return outputType == .icns ? "icon.icns" : "icon.iconset"
    }
    
    func processImage() {
        guard canProcess else { return }
        
        isProcessing = true
        statusMessage = "Processing image..."
        
        Task {
            do {
                try await processImageAsync()
                await MainActor.run {
                    isProcessing = false
                    statusMessage = "Conversion completed successfully!"
                    showingSuccess = true
                }
            } catch {
                await MainActor.run {
                    isProcessing = false
                    errorMessage = error.localizedDescription
                    statusMessage = "Conversion failed"
                    showingError = true
                }
            }
        }
    }
    
    private func processImageAsync() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let runner = MainRunner(
                        input: self.inputImagePath,
                        output: self.outputPath.isEmpty ? nil : self.outputPath,
                        type: self.outputType,
                        listFormats: false,
                        helpMessage: { "" }
                    )
                    
                    try runner.validate()
                    runner.run()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func handleDroppedFiles(_ providers: [NSItemProvider]) {
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier("public.file-url") {
                provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { item, error in
                    if let data = item as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil) {
                        DispatchQueue.main.async {
                            self.inputImagePath = url.path
                            self.generateDefaultOutputPath()
                        }
                    }
                }
                break
            }
        }
    }
}

import AppKit
