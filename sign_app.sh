#!/bin/bash

# Script opcional para assinar a aplicação (requer certificado de desenvolvedor)

APP_PATH="dist/CreateICNS.app"
IDENTITY="Developer ID Application: Your Name"

echo "🔐 Script de assinatura da aplicação CreateICNS"
echo "⚠️  Este script requer um certificado de desenvolvedor Apple válido"
echo ""

# Verificar se a aplicação existe
if [ ! -d "$APP_PATH" ]; then
    echo "❌ Aplicação não encontrada em: $APP_PATH"
    echo "Execute primeiro o script create_app_bundle.sh"
    exit 1
fi

# Listar identidades disponíveis
echo "🔍 Certificados de desenvolvedor disponíveis:"
security find-identity -v -p codesigning

echo ""
echo "📝 Para assinar a aplicação, edite este script e:"
echo "   1. Substitua 'Your Name' pelo nome do seu certificado"
echo "   2. Execute: ./sign_app.sh"
echo ""
echo "🚀 Comandos para assinar:"
echo "   codesign --force --verify --verbose --sign \"$IDENTITY\" \"$APP_PATH\""
echo "   spctl --assess --type execute --verbose \"$APP_PATH\""
echo ""
echo "📦 Para notarizar (Apple Developer Program):"
echo "   xcrun notarytool submit CreateICNS-0.1.1.dmg --keychain-profile \"notary-profile\" --wait"
