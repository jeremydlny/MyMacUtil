# MyMacUtil

## MyMacUtil
Automated setup script for configuring your macOS terminal with essential tools and customizations.

## Features
- Homebrew installation and configuration
- Nerd Font (Cascadia Code) installation
- Oh My Posh with atomic theme
- Fastfetch system information tool
- Improved terminal experience with modern prompt

## Requirements
- macOS
- Zsh (default shell on macOS)
- Internet connection

## Installation
Download and run the bootstrap script:
```bash
curl -s https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/develop/Mac-Setup/bootstrap.sh | bash
```

## Usage
After installation, you'll need to:

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
