# KeyLit

KeyLit is a lightweight macOS menu bar utility that allows you to easily toggle the keyboard backlight brightness. It operates entirely in the background and is accessed directly from your macOS menu bar.

## Features

- **Toggle Keyboard Backlight**: Click the menu bar icon to toggle the keyboard brightness between off (`0.0`) and on (`0.0001` or very dim).
- **Status Synced UI**: The icon opacity updates dynamically depending on whether the keyboard backlight is currently active.
- **Easy Quit**: Right-click (or Control-click) the menu bar icon to display a context menu to terminate the application.
- **Native Implementation**: No external CLI subprocesses or Homebrew packages. The app dynamically links to macOS's private `CoreBrightness.framework` under the hood.

## Acknowledgements

This project is based on the core logic and reverse-engineered private API headers of the [mac-brightnessctl](https://github.com/rakalex/mac-brightnessctl) project by rakalex.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
