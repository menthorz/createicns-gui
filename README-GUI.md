# CreateICNS GUI - Aplicação macOS

Uma interface gráfica moderna e intuitiva para converter imagens em ícones macOS (.icns e .iconset).

## 📦 Arquivos de Distribuição

- **CreateICNS.app** - Aplicação macOS pronta para usar
- **CreateICNS-0.1.1.dmg** - Instalador DMG para distribuição

## 🚀 Como Usar

### Instalação via DMG
1. Abra o arquivo `CreateICNS-0.1.1.dmg`
2. Arraste `CreateICNS.app` para a pasta Applications
3. Execute a aplicação

### Uso da Interface
1. **Selecionar Imagem**: Clique em "Browse..." ou arraste uma imagem para a área indicada
2. **Escolher Tipo**: Selecione entre ICNS, Iconset ou Auto Detect
3. **Local de Saída**: Opcionalmente escolha onde salvar (padrão: mesmo local da imagem)
4. **Converter**: Clique em "Convert to Icon"

## 📋 Formatos Suportados

### Entrada
- PNG
- JPEG/JPG
- TIFF
- BMP
- GIF

### Saída
- `.icns` - Arquivo de ícone do macOS
- `.iconset` - Pasta com múltiplos tamanhos

## ⚙️ Requisitos do Sistema

- macOS 12.0 ou superior
- Imagens quadradas (largura = altura) para melhores resultados

## 🛠️ Recursos da Interface

- **Drag & Drop**: Arraste imagens diretamente para a aplicação
- **Visualização**: Veja o arquivo selecionado antes da conversão
- **Progresso**: Indicador visual durante o processamento
- **Notificações**: Alertas de sucesso ou erro
- **Auto-geração**: Nomes e locais de saída automáticos

## 🔧 Linha de Comando

Esta aplicação também inclui uma versão de linha de comando:

```bash
# Usar o executável incluído
./createicns input.png output.icns

# Ou via terminal
createicns --help
```

## 📝 Notas Técnicas

- A aplicação processa imagens localmente (sem internet)
- Suporta imagens de alta resolução (até 1024x1024)
- Gera automaticamente todos os tamanhos necessários para ícones macOS
- Interface construída com SwiftUI para performance nativa

## 🐛 Solução de Problemas

### A aplicação não abre
- Verifique se você está usando macOS 12.0 ou superior
- Tente executar pelo terminal para ver mensagens de erro
- Verifique as permissões de segurança em Preferências do Sistema

### Erro ao converter
- Certifique-se de que a imagem é quadrada (mesma largura e altura)
- Verifique se você tem permissões de escrita no local de destino
- Formatos suportados: PNG, JPEG, TIFF, BMP, GIF

### Ícone não aparece corretamente
- Use imagens de alta qualidade (512x512 ou 1024x1024)
- Prefira PNG com fundo transparente
- Evite detalhes muito pequenos que podem se perder em tamanhos menores

## 📞 Suporte

Para reportar bugs ou sugerir melhorias, visite o repositório do projeto.

---

**CreateICNS GUI v0.1.1**  
© 2025 - Criado com Swift e SwiftUI
