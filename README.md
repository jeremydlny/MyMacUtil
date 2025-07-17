# MyMacUtil
Automated setup script for configuring your macOS terminal with essential tools and customizations.

## Features
- Homebrew installation and configuration
- Nerd Font (Cascadia Code) installation
- Oh My Posh with atomic theme
- Fastfetch system information tool
- Improved terminal experience with modern prompt
- Custom aliases and Zsh configuration
- Comprehensive application installation

## Requirements
- macOS
- Zsh (default shell on macOS)
- Internet connection

## Installation
Download and run the bootstrap script:
```bash
<<<<<<< HEAD
curl -s https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Setup/bootstrap.sh | bash
=======
curl -s https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Mac-Setup/bootstrap.sh | bash
>>>>>>> develop
```

## Usage
After installation, you'll need to:

1. Manually install the downloaded fonts using Font Book (from `~/.fonts` directory)
2. Restart your terminal or run `source ~/.zshrc` to apply changes

## Installed Applications
The script installs the following essential applications:

### Browsers
- Brave Browser

### Development Tools
- GitKraken

### Communication
- Discord

### Media
- VLC

### Security
- ProtonVPN

### Torrent
- Transmission

### System Utilities
- CleanMyMac

### Window Management
- Rectangle

### Display Management
- Scroll Reverser

### System Monitoring
- iStat Menus

### AI Tools
- ChatGPT

### Battery Management
- AlDente

### Window Switching
- Alt-Tab

### Maintenance
- KeyboardCleanTool

## Custom Zsh Configuration
The script sets up a custom Zsh configuration with:
- Custom aliases for common tasks
- Improved prompt with Oh My Posh
- Enhanced system information display with Fastfetch
- Modern terminal theme

## Post-Installation Steps
After running the installation script:

1. Manually install the downloaded fonts via Font Book
2. Restart your terminal or run `source ~/.zshrc`
3. Configure your applications as needed

## License
MIT License

## Author
Created by Jeremy Delannoy

If you find this script useful, please consider starring the repository! 🌟

1. Manually install the downloaded fonts using Font Book (from `~/.fonts` directory)
2. Restart your terminal or run `source ~/.zshrc` to apply changes

## Configuration
The script configures:
- Homebrew with optimized settings
- Custom font configuration
- Oh My Posh prompt with atomic theme
- Fastfetch for system information

## Customization
You can customize the Oh My Posh theme by modifying the configuration in your `~/.zshrc` file.

To change the theme, list available themes with:
```bash
ls $(brew --prefix oh-my-posh)/themes
```

Then update your `~/.zshrc` with your preferred theme.

## License
MIT License

## Author
Created by [Jeremy Delannoy](https://github.com/jeremydlny)

If you find this script useful, please consider starring the repository! 🌟
