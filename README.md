# CreateICNS GUI

A modern graphical user interface for [CreateICNS](https://github.com/jordanbaird/createicns), the command-line tool that creates 'icns' and 'iconset' files from standard images.

## 🎯 About

This project extends the original [CreateICNS by Jordan Baird](https://github.com/jordanbaird/createicns) with a native macOS graphical interface built with SwiftUI. It maintains all the functionality of the original command-line tool while providing an intuitive drag-and-drop interface for everyday users.

## ✨ Features

### GUI Features
- 🖱️ **Drag & Drop Interface** - Simply drag images into the app
- 🎨 **Visual Type Selection** - Choose between ICNS, Iconset, or Auto Detect
- 📁 **Smart Output Paths** - Automatic output naming and location
- 🔄 **Real-time Progress** - Visual feedback during conversion
- ✅ **Success Notifications** - Clear status messages and alerts
- 🖼️ **Multi-format Support** - PNG, JPEG, TIFF, BMP, GIF

### Original CLI Features (Included)
- ⚡ **Fast Conversion** - Optimized image processing
- 📐 **Multiple Sizes** - Automatic generation of all required icon sizes
- 🎯 **Perfect Quality** - High-resolution output with proper scaling
- 🔧 **Flexible Options** - Command-line interface for automation

## 📦 Installation

### Option 1: Download DMG (Recommended)
1. Download `CreateICNS-0.1.1.dmg` from the releases
2. Open the DMG file
3. Drag `CreateICNS.app` to your Applications folder
4. Launch from Applications or Spotlight

### Option 2: Build from Source
```bash
git clone git@github.com:menthorz/createicns-gui.git
cd createicns-gui
./create_app_bundle.sh
open dist/CreateICNS.app
```

## 🚀 Usage

### GUI Usage
1. **Launch** the CreateICNS app
2. **Add Image**: Click "Browse..." or drag an image file into the drop zone
3. **Select Type**: Choose your preferred output format:
   - **ICNS File** - Standard macOS icon format
   - **Iconset Folder** - Folder with multiple icon sizes
   - **Auto Detect** - Infer from output file extension
4. **Choose Location** (Optional): Select where to save the output
5. **Convert**: Click "Convert to Icon" and wait for completion

### Command Line Usage
The original CLI tool is also included:

```bash
# Basic usage
createicns input.png output.icns

# Create iconset
createicns --type iconset input.png

# See all options
createicns --help
```

## 🖼️ Supported Formats

| Input Formats | Output Formats |
|---------------|----------------|
| PNG           | ICNS           |
| JPEG/JPG      | Iconset        |
| TIFF          |                |
| BMP           |                |
| GIF           |                |

## ⚙️ Requirements

- **macOS 12.0** or later
- **Apple Silicon** or Intel Mac
- Square images (width = height) recommended for best results

## 🛠️ Development

### Prerequisites
- Xcode 14.0+
- Swift 5.8+
- macOS 12.0+ SDK

### Building
```bash
# Clone the repository
git clone git@github.com:menthorz/createicns-gui.git
cd createicns-gui

# Build CLI version
swift build

# Build GUI version
swift build --product createicns-gui

# Create app bundle
./create_app_bundle.sh

# Verify build
./verify_app.sh
```

### Project Structure
```
Sources/
├── Backend/           # Core image processing (original CreateICNS)
│   ├── ImageProcessing/
│   ├── FileManagement/
│   ├── Runners/
│   └── Utilities/
├── Frontend/          # Command-line interface (original)
└── GUI/              # SwiftUI graphical interface (new)
    ├── Models/
    └── Views/
```

## 📸 Screenshots

Screenshots will be added in future updates to showcase the interface.

## 🐛 Troubleshooting

### App Won't Open
- Ensure you're running macOS 12.0 or later
- Right-click the app and select "Open" to bypass Gatekeeper
- Check System Preferences > Security & Privacy

### Conversion Errors
- Ensure your image is square (same width and height)
- Verify you have write permissions to the output directory
- Use supported image formats (PNG, JPEG, TIFF, BMP, GIF)

### Icon Quality Issues
- Use high-resolution images (512x512 or 1024x1024)
- Prefer PNG format with transparent background
- Avoid very small details that won't scale well

## 📋 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Credits

### Original CreateICNS
- **Author**: [Jordan Baird](https://github.com/jordanbaird)
- **Repository**: [jordanbaird/createicns](https://github.com/jordanbaird/createicns)
- **License**: MIT License

This GUI extension builds upon Jordan Baird's excellent CreateICNS command-line tool. All core image processing functionality is based on the original implementation.

### GUI Extension
- **SwiftUI Interface**: Added graphical user interface
- **App Bundle**: Created native macOS application packaging
- **Enhanced UX**: Drag-and-drop functionality and visual feedback

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
1. Maintain compatibility with the original CLI interface
2. Follow SwiftUI best practices for GUI components
3. Test on multiple macOS versions (12.0+)
4. Update documentation for new features

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/menthorz/createicns-gui/issues)
- **Discussions**: [GitHub Discussions](https://github.com/menthorz/createicns-gui/discussions)
- **Original Project**: [CreateICNS Issues](https://github.com/jordanbaird/createicns/issues)

## ⭐ Acknowledgments

- Jordan Baird for creating the original CreateICNS tool
- Apple for SwiftUI and excellent development tools
- The Swift community for continued support and resources

---

**Note**: This is an unofficial GUI extension. For the original command-line tool, please visit [jordanbaird/createicns](https://github.com/jordanbaird/createicns).
