# Contributing to CreateICNS GUI

Thank you for your interest in contributing to CreateICNS GUI! This project extends the original [CreateICNS by Jordan Baird](https://github.com/jordanbaird/createicns) with a modern SwiftUI interface.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Guidelines](#contributing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)
- [Project Structure](#project-structure)

## 🤝 Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/). By participating, you agree to uphold this code.

## 🚀 Getting Started

### Prerequisites
- macOS 12.0 or later
- Xcode 14.0 or later
- Swift 5.8 or later
- Git

### Development Setup

1. **Fork and Clone**
   ```bash
   git clone git@github.com:menthorz/createicns-gui.git
   cd createicns-gui
   ```

2. **Build the Project**
   ```bash
   # Build CLI version
   swift build
   
   # Build GUI version
   swift build --product createicns-gui
   ```

3. **Test the Build**
   ```bash
   # Create app bundle
   ./create_app_bundle.sh
   
   # Verify integrity
   ./verify_app.sh
   ```

4. **Run Tests** (when available)
   ```bash
   swift test
   ```

## 📖 Contributing Guidelines

### Types of Contributions

We welcome several types of contributions:

1. **🐛 Bug Fixes**: Fix issues in existing functionality
2. **✨ New Features**: Add new GUI features or improvements
3. **📚 Documentation**: Improve README, code comments, or guides
4. **🎨 UI/UX**: Enhance the SwiftUI interface
5. **⚡ Performance**: Optimize image processing or UI responsiveness
6. **🧪 Testing**: Add unit tests or integration tests

### Development Principles

1. **Maintain Compatibility**: Don't break the original CLI interface
2. **Native Experience**: Follow macOS Human Interface Guidelines
3. **SwiftUI Best Practices**: Use modern SwiftUI patterns
4. **Performance First**: Keep image processing efficient
5. **Accessibility**: Support VoiceOver and other accessibility features

### Code Style

#### Swift Code
- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use SwiftLint (configuration coming soon)
- Prefer explicit types for clarity
- Use meaningful variable and function names

#### SwiftUI Specifics
- Use `@State` and `@ObservedObject` appropriately
- Separate views into logical components
- Follow View composition patterns
- Use proper accessibility modifiers

#### Example Code Style
```swift
// Good
struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView()
            DropZoneView(appState: appState)
        }
        .padding()
    }
}

// Avoid
struct ContentView: View {
    @StateObject var appState = AppState()
    var body: some View {
        VStack(spacing:20){
            HeaderView()
            DropZoneView(appState:appState)
        }.padding()
    }
}
```

## 🔧 Project Structure

Understanding the project organization helps with contributions:

```
Sources/
├── Backend/           # Original CreateICNS core (minimize changes)
│   ├── ImageProcessing/
│   ├── FileManagement/
│   ├── Runners/
│   └── Utilities/
├── Frontend/          # Original CLI interface (preserve compatibility)
│   ├── CreateICNS.swift
│   ├── Options.swift
│   └── Help.swift
└── GUI/              # New SwiftUI interface (main contribution area)
    ├── Models/        # App state and data models
    │   └── AppState.swift
    ├── Views/         # SwiftUI views and components
    │   └── ContentView.swift
    └── main.swift     # GUI app entry point
```

### Contribution Areas

#### 🎯 High-Priority Areas
- **SwiftUI Views**: Improve existing or add new UI components
- **User Experience**: Enhance drag-and-drop, progress indicators
- **Error Handling**: Better error messages and recovery
- **Accessibility**: VoiceOver support, keyboard navigation

#### 🔄 Medium-Priority Areas
- **Performance**: Optimize image processing workflows
- **Testing**: Unit tests for GUI components
- **Documentation**: Code comments and user guides
- **Localization**: Multi-language support

#### 📦 Backend Changes (Careful)
- Only modify `Backend/` if absolutely necessary
- Ensure CLI compatibility is maintained
- Test both CLI and GUI after changes

## 📝 Pull Request Process

### Before Submitting

1. **Test Thoroughly**
   ```bash
   # Build both versions
   swift build
   swift build --product createicns-gui
   
   # Test app bundle creation
   ./create_app_bundle.sh
   ./verify_app.sh
   
   # Test CLI compatibility
   .build/debug/createicns --help
   ```

2. **Update Documentation**
   - Update README if adding user-facing features
   - Add code comments for complex logic
   - Update CHANGELOG.md with your changes

3. **Check Compatibility**
   - Ensure CLI interface still works
   - Test on different macOS versions if possible
   - Verify app bundle builds correctly

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other: ___

## Testing
- [ ] Built and tested locally
- [ ] CLI interface still works
- [ ] App bundle creates successfully
- [ ] No regressions in existing features

## Screenshots
(For UI changes, include before/after screenshots)

## Additional Notes
Any additional context or considerations
```

### Review Process

1. **Automated Checks**: CI will run basic build tests
2. **Code Review**: Maintainers will review code quality and design
3. **Testing**: Changes will be tested on multiple systems
4. **Documentation**: Ensure changes are properly documented

## 🐛 Issue Reporting

### Bug Reports

Use the bug report template and include:

- macOS version
- App version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Console logs if relevant

### Feature Requests

For new features, please:

- Check existing issues first
- Describe the use case clearly
- Explain how it fits with the project goals
- Consider implementation complexity

### Questions

For questions:

- Check existing documentation first
- Use GitHub Discussions for general questions
- Use Issues only for specific bugs or feature requests

## 🏆 Recognition

Contributors will be recognized in:

- README.md acknowledgments
- Release notes for significant contributions
- Special mention for major features

## 📞 Getting Help

- **General Questions**: [GitHub Discussions]
- **Bug Reports**: [GitHub Issues]
- **Development Chat**: [Contact info]

## 🙏 Credits

This project builds upon:

- **Original CreateICNS**: [Jordan Baird](https://github.com/jordanbaird)
- **SwiftUI**: Apple's declarative UI framework
- **Swift Community**: For excellent resources and support

Thank you for contributing! 🎉
