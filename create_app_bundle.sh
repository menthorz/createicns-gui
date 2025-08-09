#!/bin/bash

# Script para criar o bundle .app do CreateICNS GUI

APP_NAME="CreateICNS"
BUNDLE_ID="com.createicns.gui"
VERSION="0.1.2"
BUILD_DIR=".build/release"
APP_DIR="dist/${APP_NAME}.app"

echo "🚀 Criando bundle .app para ${APP_NAME}..."

# Limpar diretório de distribuição anterior
rm -rf dist
mkdir -p dist

# Construir a aplicação em modo release
echo "📦 Construindo aplicação em modo release..."
swift build --configuration release --product createicns-gui

if [ ! -f "${BUILD_DIR}/createicns-gui" ]; then
    echo "❌ Erro: Executável não encontrado em ${BUILD_DIR}/createicns-gui"
    exit 1
fi

# Criar estrutura do bundle .app
echo "📁 Criando estrutura do bundle..."
mkdir -p "${APP_DIR}/Contents/MacOS"
mkdir -p "${APP_DIR}/Contents/Resources"

# Copiar executável
echo "📋 Copiando executável..."
cp "${BUILD_DIR}/createicns-gui" "${APP_DIR}/Contents/MacOS/${APP_NAME}"
chmod +x "${APP_DIR}/Contents/MacOS/${APP_NAME}"

# Criar Info.plist
echo "📄 Criando Info.plist..."
cat > "${APP_DIR}/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${APP_NAME}</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>CFBundleIdentifier</key>
    <string>${BUNDLE_ID}</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>${VERSION}</string>
    <key>CFBundleVersion</key>
    <string>${VERSION}</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSHumanReadableCopyright</key>
    <string>Copyright © 2025 CreateICNS. All rights reserved.</string>
    <key>CFBundleDocumentTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeExtensions</key>
            <array>
                <string>png</string>
                <string>jpg</string>
                <string>jpeg</string>
                <string>tiff</string>
                <string>bmp</string>
                <string>gif</string>
            </array>
            <key>CFBundleTypeIconFile</key>
            <string>AppIcon</string>
            <key>CFBundleTypeName</key>
            <string>Image File</string>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>LSHandlerRank</key>
            <string>Alternate</string>
        </dict>
    </array>
</dict>
</plist>
EOF

# Criar ícone da aplicação usando sips e iconutil (se disponível)
echo "🎨 Criando ícone da aplicação..."

# Criar um ícone temporário usando um símbolo do sistema
cat > create_icon.swift << 'EOF'
import Cocoa
import SwiftUI

let size = NSSize(width: 1024, height: 1024)
let image = NSImage(size: size)

image.lockFocus()

// Background gradient
let gradient = NSGradient(colors: [
    NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0),
    NSColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 1.0)
])
gradient?.draw(in: NSRect(origin: .zero, size: size), angle: 45)

// Draw app icon shape (gear-like icon)
let rect = NSRect(x: 200, y: 200, width: 624, height: 624)
NSColor.white.setFill()

// Create a simple icon shape
let path = NSBezierPath(roundedRect: rect, xRadius: 100, yRadius: 100)
path.fill()

// Add a smaller inner circle
let innerRect = NSRect(x: 350, y: 350, width: 324, height: 324)
NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0).setFill()
let innerPath = NSBezierPath(ovalIn: innerRect)
innerPath.fill()

image.unlockFocus()

// Save as PNG
if let tiffData = image.tiffRepresentation,
   let bitmapImage = NSBitmapImageRep(data: tiffData),
   let pngData = bitmapImage.representation(using: .png, properties: [:]) {
    try? pngData.write(to: URL(fileURLWithPath: "app_icon_1024.png"))
}
EOF

# Compilar e executar o gerador de ícone
if command -v swiftc &> /dev/null; then
    echo "  📐 Gerando ícone com Swift..."
    swiftc -framework Cocoa create_icon.swift -o create_icon
    ./create_icon
    rm create_icon create_icon.swift
    
    if [ -f "app_icon_1024.png" ]; then
        # Criar iconset
        mkdir -p AppIcon.iconset
        
        # Gerar diferentes tamanhos
        sips -z 16 16 app_icon_1024.png --out AppIcon.iconset/icon_16x16.png
        sips -z 32 32 app_icon_1024.png --out AppIcon.iconset/icon_16x16@2x.png
        sips -z 32 32 app_icon_1024.png --out AppIcon.iconset/icon_32x32.png
        sips -z 64 64 app_icon_1024.png --out AppIcon.iconset/icon_32x32@2x.png
        sips -z 128 128 app_icon_1024.png --out AppIcon.iconset/icon_128x128.png
        sips -z 256 256 app_icon_1024.png --out AppIcon.iconset/icon_128x128@2x.png
        sips -z 256 256 app_icon_1024.png --out AppIcon.iconset/icon_256x256.png
        sips -z 512 512 app_icon_1024.png --out AppIcon.iconset/icon_256x256@2x.png
        sips -z 512 512 app_icon_1024.png --out AppIcon.iconset/icon_512x512.png
        cp app_icon_1024.png AppIcon.iconset/icon_512x512@2x.png
        
        # Criar arquivo icns
        iconutil -c icns AppIcon.iconset -o "${APP_DIR}/Contents/Resources/AppIcon.icns"
        
        # Limpar arquivos temporários
        rm -rf AppIcon.iconset app_icon_1024.png
        
        echo "  ✅ Ícone criado com sucesso!"
    else
        echo "  ⚠️  Falha ao gerar ícone, continuando sem ícone..."
    fi
else
    echo "  ⚠️  swiftc não encontrado, continuando sem ícone..."
fi

# Verificar se a aplicação foi criada corretamente
if [ -d "${APP_DIR}" ] && [ -f "${APP_DIR}/Contents/MacOS/${APP_NAME}" ]; then
    echo "✅ Bundle .app criado com sucesso!"
    echo "📍 Localização: $(pwd)/${APP_DIR}"
    echo "📏 Tamanho do bundle:"
    du -sh "${APP_DIR}"
    echo ""
    echo "🚀 Para executar a aplicação:"
    echo "   open \"${APP_DIR}\""
    echo ""
    echo "📦 Para criar um DMG:"
    echo "   hdiutil create -volname \"${APP_NAME}\" -srcfolder dist -ov -format UDZO \"${APP_NAME}-${VERSION}.dmg\""
else
    echo "❌ Erro ao criar bundle .app"
    exit 1
fi
