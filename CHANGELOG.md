# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2025-08-09

### Changed
- **Version Update**: Incremented to 0.1.2 to clearly differentiate from original CreateICNS
- **Documentation Cleanup**: Removed redundant markdown files for cleaner repository
- **Repository Optimization**: Streamlined project structure with essential files only

### Improved
- **Professional Presentation**: Clear distinction as GUI extension rather than fork
- **Respect for Original**: Emphasizes this is an enhancement, not replacement
- **Cleaner Codebase**: Easier navigation and maintenance

### Notes
- This version specifically acknowledges the excellent work by Jordan Baird
- GUI extension complements rather than competes with original CLI tool
- Version bump demonstrates this is an evolution of the v0.1.1 base

## [0.1.1] - 2025-08-09

### Added - GUI Extension
- **SwiftUI Interface**: Complete graphical user interface for CreateICNS
- **Drag & Drop Support**: Intuitive drag-and-drop functionality for image files
- **Visual Type Selection**: GUI picker for output format (ICNS/Iconset/Auto)
- **Progress Indicators**: Real-time visual feedback during conversion
- **Status Notifications**: Success/error alerts and status messages
- **App Bundle**: Native macOS application (.app) packaging
- **Custom App Icon**: Programmatically generated application icon
- **DMG Distribution**: Ready-to-distribute disk image
- **Multi-format Support**: PNG, JPEG, TIFF, BMP, GIF input formats

### Added - Build & Distribution
- **Automated Build Scripts**: 
  - `create_app_bundle.sh` - Creates complete .app bundle
  - `verify_app.sh` - Verifies app integrity and structure
  - `sign_app.sh` - Optional code signing helper
- **Documentation**: Comprehensive README for GUI usage
- **Git Repository**: Source control with proper .gitignore

### Technical
- **macOS 12.0+ Support**: Updated minimum system requirements for SwiftUI
- **ARM64 Architecture**: Native Apple Silicon support
- **Swift 5.8+**: Modern Swift language features
- **Package.swift Updates**: Added GUI target to Swift Package Manager

### Maintained
- **Original CLI Functionality**: All original command-line features preserved
- **Backend Compatibility**: Zero changes to core image processing logic
- **License Compliance**: Maintained MIT license from original project

## [Original] - Based on CreateICNS by Jordan Baird

### Core Features (From Original Project)
- Command-line interface for creating icons
- ICNS and Iconset output format support
- Multiple image format input support
- High-quality image scaling and processing
- Automatic size generation for macOS icons
- Swift Package Manager support
- MIT License

### Credits
- Original project: [jordanbaird/createicns](https://github.com/jordanbaird/createicns)
- Author: Jordan Baird
- License: MIT License (maintained)

---

## Version History Summary

- **v0.1.1**: GUI Extension - Added complete SwiftUI interface
- **Original**: Command-line tool by Jordan Baird

## Migration Guide

### From Original CLI to GUI
The GUI version maintains full backward compatibility:

1. **Command Line**: Still available via `createicns` executable
2. **Programmatic**: Same Swift API for integration
3. **New GUI**: Added SwiftUI interface in `createicns-gui` executable

### New Features Available
- Drag-and-drop image selection
- Visual output type selection
- Real-time progress feedback
- Native macOS app experience

## Future Roadmap

### Planned Features
- [ ] Batch processing support
- [ ] Image preview before conversion
- [ ] Custom icon size selection
- [ ] Preferences panel
- [ ] Multiple output format simultaneous generation
- [ ] Integration with Finder quick actions

### Under Consideration
- [ ] iOS companion app
- [ ] Cloud processing option
- [ ] Plugin architecture
- [ ] Advanced image filters

## Contributing

This project welcomes contributions! Areas where help is appreciated:

1. **GUI Enhancements**: SwiftUI improvements and new features
2. **Testing**: Cross-platform compatibility testing
3. **Documentation**: User guides and developer documentation
4. **Localization**: Multi-language support
5. **Performance**: Optimization of image processing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.
