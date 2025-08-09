//
//  ContentView.swift
//  createicns-gui
//

import SwiftUI
import Backend

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HeaderView()
            
            // Main Content
            VStack(spacing: 16) {
                // Drop Zone / File Selection
                DropZoneView(appState: appState)
                
                // Output Type Selection
                OutputTypePickerView(appState: appState)
                
                // Output Path
                OutputPathView(appState: appState)
                
                // Action Button
                ActionButtonView(appState: appState)
                
                // Status
                StatusView(appState: appState)
            }
            .padding()
            .background(Color(.controlBackgroundColor))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .background(Color(.windowBackgroundColor))
        .alert("Error", isPresented: $appState.showingError) {
            Button("OK") { }
        } message: {
            Text(appState.errorMessage)
        }
        .alert("Success", isPresented: $appState.showingSuccess) {
            Button("OK") { }
        } message: {
            Text("Icon conversion completed successfully!")
        }
        .frame(minWidth: 500, minHeight: 400)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "app.dashed")
                .font(.system(size: 48))
                .foregroundColor(.accentColor)
            
            Text("CreateICNS")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Create icns and iconset files from images")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top)
    }
}

struct DropZoneView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                
                Text("Input Image")
                    .font(.headline)
                
                Spacer()
                
                Button("Browse...") {
                    appState.selectInputFile()
                }
                .buttonStyle(.bordered)
            }
            
            if appState.inputImagePath.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.down.on.square.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.secondary)
                    
                    Text("Drop an image here or click Browse")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                    Text("Supported formats: PNG, JPEG, TIFF, BMP, GIF")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(appState.dragOver ? Color.accentColor.opacity(0.1) : Color(.controlColor))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    appState.dragOver ? Color.accentColor : Color(.separatorColor),
                                    style: StrokeStyle(lineWidth: 2, dash: [5])
                                )
                        )
                )
                .onDrop(of: ["public.file-url"], isTargeted: $appState.dragOver) { providers in
                    appState.handleDroppedFiles(providers)
                    return true
                }
            } else {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    Text(URL(fileURLWithPath: appState.inputImagePath).lastPathComponent)
                        .lineLimit(1)
                        .truncationMode(.middle)
                    
                    Spacer()
                    
                    Button("Change") {
                        appState.selectInputFile()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                }
                .padding(12)
                .background(Color(.controlColor))
                .cornerRadius(8)
            }
        }
    }
}

struct OutputTypePickerView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.accentColor)
                
                Text("Output Type")
                    .font(.headline)
                
                Spacer()
            }
            
            Picker("Output Type", selection: $appState.outputType) {
                Text("ICNS File").tag(OutputType.icns)
                Text("Iconset Folder").tag(OutputType.iconset)
                Text("Auto Detect").tag(OutputType.infer)
            }
            .pickerStyle(.segmented)
            .onChange(of: appState.outputType) { _ in
                if !appState.inputImagePath.isEmpty {
                    appState.generateDefaultOutputPath()
                }
            }
        }
    }
}

struct OutputPathView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "folder")
                    .foregroundColor(.accentColor)
                
                Text("Output Location")
                    .font(.headline)
                
                Spacer()
                
                Button("Choose...") {
                    appState.selectOutputPath()
                }
                .buttonStyle(.bordered)
                .disabled(appState.inputImagePath.isEmpty)
            }
            
            if !appState.outputPath.isEmpty {
                HStack {
                    Text(URL(fileURLWithPath: appState.outputPath).lastPathComponent)
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding(8)
                .background(Color(.controlColor))
                .cornerRadius(6)
            } else {
                Text("Output path will be auto-generated")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .italic()
                    .padding(.leading, 4)
            }
        }
    }
}

struct ActionButtonView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        Button(action: {
            appState.processImage()
        }) {
            HStack {
                if appState.isProcessing {
                    ProgressView()
                        .scaleEffect(0.8)
                        .progressViewStyle(CircularProgressViewStyle())
                }
                
                Image(systemName: appState.isProcessing ? "gearshape.2" : "play.fill")
                
                Text(appState.isProcessing ? "Converting..." : "Convert to Icon")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .disabled(!appState.canProcess)
    }
}

struct StatusView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        if !appState.statusMessage.isEmpty {
            HStack {
                Image(systemName: appState.statusMessage.contains("success") ? "checkmark.circle.fill" : "info.circle.fill")
                    .foregroundColor(appState.statusMessage.contains("success") ? .green : .blue)
                
                Text(appState.statusMessage)
                    .font(.callout)
                
                Spacer()
            }
            .padding(8)
            .background(Color(.controlColor))
            .cornerRadius(6)
        }
    }
}
