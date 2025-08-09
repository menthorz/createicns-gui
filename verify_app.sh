#!/bin/bash

# Script para verificar a integridade da aplicação CreateICNS

APP_PATH="dist/CreateICNS.app"
DMG_PATH="CreateICNS-0.1.1.dmg"

echo "🔍 Verificando integridade da aplicação CreateICNS..."
echo ""

# Verificar se os arquivos existem
if [ ! -d "$APP_PATH" ]; then
    echo "❌ Aplicação não encontrada: $APP_PATH"
    exit 1
fi

if [ ! -f "$DMG_PATH" ]; then
    echo "❌ DMG não encontrado: $DMG_PATH"
    exit 1
fi

echo "✅ Arquivos encontrados:"
echo "   📱 App: $APP_PATH"
echo "   💿 DMG: $DMG_PATH"
echo ""

# Verificar estrutura do bundle
echo "🔍 Verificando estrutura do bundle..."

required_files=(
    "$APP_PATH/Contents/Info.plist"
    "$APP_PATH/Contents/MacOS/CreateICNS"
    "$APP_PATH/Contents/Resources/AppIcon.icns"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ $file (não encontrado)"
    fi
done

echo ""

# Verificar executável
echo "🔍 Verificando executável..."
executable="$APP_PATH/Contents/MacOS/CreateICNS"

if [ -x "$executable" ]; then
    echo "   ✅ Executável tem permissões corretas"
    
    # Verificar arquitetura
    file_info=$(file "$executable")
    echo "   📋 Arquitetura: $file_info"
    
    # Verificar dependências
    echo "   📚 Dependências principais:"
    otool -L "$executable" | grep -E "(Foundation|SwiftUI|Cocoa)" | head -3
else
    echo "   ❌ Executável não tem permissões ou não existe"
fi

echo ""

# Verificar Info.plist
echo "🔍 Verificando Info.plist..."
plist_path="$APP_PATH/Contents/Info.plist"

if [ -f "$plist_path" ]; then
    bundle_id=$(plutil -extract CFBundleIdentifier raw "$plist_path" 2>/dev/null)
    version=$(plutil -extract CFBundleShortVersionString raw "$plist_path" 2>/dev/null)
    min_os=$(plutil -extract LSMinimumSystemVersion raw "$plist_path" 2>/dev/null)
    
    echo "   ✅ Bundle ID: $bundle_id"
    echo "   ✅ Versão: $version"
    echo "   ✅ macOS mínimo: $min_os"
else
    echo "   ❌ Info.plist não encontrado"
fi

echo ""

# Verificar ícone
echo "🔍 Verificando ícone..."
icon_path="$APP_PATH/Contents/Resources/AppIcon.icns"

if [ -f "$icon_path" ]; then
    icon_size=$(ls -lh "$icon_path" | awk '{print $5}')
    echo "   ✅ Ícone encontrado (${icon_size})"
    
    # Verificar se é um arquivo icns válido
    file_type=$(file "$icon_path")
    if [[ $file_type == *"Mac OS X icon"* ]]; then
        echo "   ✅ Formato de ícone válido"
    else
        echo "   ⚠️  Formato de ícone pode estar incorreto"
    fi
else
    echo "   ❌ Ícone não encontrado"
fi

echo ""

# Verificar DMG
echo "🔍 Verificando DMG..."
dmg_size=$(ls -lh "$DMG_PATH" | awk '{print $5}')
echo "   ✅ Tamanho do DMG: $dmg_size"

# Tentar verificar o conteúdo do DMG
if command -v hdiutil &> /dev/null; then
    echo "   🔍 Verificando conteúdo do DMG..."
    hdiutil verify "$DMG_PATH" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "   ✅ DMG verificado com sucesso"
    else
        echo "   ⚠️  Verificação do DMG falhou ou não foi possível"
    fi
fi

echo ""
echo "🎉 Verificação concluída!"
echo ""
echo "🚀 Para testar a aplicação:"
echo "   open \"$APP_PATH\""
echo ""
echo "📦 Para instalar via DMG:"
echo "   open \"$DMG_PATH\""
