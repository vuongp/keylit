# KeyLit

KeyLit is a lightweight macOS menu bar utility that allows you to easily toggle the keyboard backlight brightness. Since I personally only turn off the backlight or have it on the dimmest level possible I've made this. It doesn't support anything else.

## Preview

https://github.com/user-attachments/assets/f8cc72fe-9640-4f82-aa5a-85f7eb241230

## Features

- **Toggle Keyboard Backlight**: Click the menu bar icon to toggle the keyboard brightness between off (`0.0`) and on (`0.0001` or very dim).
- **Easy Quit**: Right-click (or Control-click) the menu bar icon to display a context menu to terminate the application.
- **Native Implementation**: No external CLI subprocesses or Homebrew packages. The app dynamically links to macOS's private `CoreBrightness.framework` under the hood.

## Acknowledgements

This project is based on the core logic and reverse-engineered private API headers of the [mac-brightnessctl](https://github.com/rakalex/mac-brightnessctl) project by rakalex. Which in turn was inspired by the work of [EthanRDoesMC](https://github.com/EthanRDoesMC) and their repository [KBPulse](https://github.com/EthanRDoesMC/KBPulse).

I've only added a menu icon :)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
