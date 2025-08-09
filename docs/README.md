# Documentation Assets

This directory contains documentation assets for the CreateICNS GUI project.

## Screenshots

### Required Screenshots
- `screenshot.png` - Main app screenshot for README
- `main-interface.png` - Full interface overview
- `drag-drop.png` - Drag and drop functionality
- `processing.png` - Processing state

### Screenshot Guidelines

#### Capture Requirements
- **Resolution**: Retina quality (2x scaling)
- **Format**: PNG with transparency where appropriate
- **Size**: Optimize for web (under 500KB per image)
- **Content**: Use realistic but non-copyrighted images

#### Consistency
- Use the same test image across screenshots
- Capture on macOS with standard system appearance
- Include window shadows and proper spacing
- Show realistic file names and paths

#### Privacy
- Avoid personal information in file paths
- Use generic usernames like "User" instead of real names
- Obscure sensitive information if necessary

## Adding Screenshots

To add screenshots to this documentation:

1. **Capture Screenshots**
   ```bash
   # Use built-in Screenshot app (Cmd+Shift+5)
   # Or use command line
   screencapture -w screenshot.png  # Window only
   screencapture -s screenshot.png  # Selection
   ```

2. **Optimize Images**
   ```bash
   # Using ImageOptim or similar
   # Target size: < 500KB per image
   # Maintain quality for UI elements
   ```

3. **Update Documentation**
   - Add images to this docs/ directory
   - Update README.md with proper image references
   - Test image links in preview

## Current Status

- [ ] screenshot.png - Main hero image
- [ ] main-interface.png - Complete interface
- [ ] drag-drop.png - Drag and drop demo
- [ ] processing.png - Processing state

## Placeholder Content

Until real screenshots are available, the README references placeholder images. These should be replaced with actual app screenshots once available.
