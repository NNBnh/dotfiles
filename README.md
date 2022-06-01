<h1 align="center"><code>Đotfiles</code></h1>
<p align="center">End-game Đotfiles</p>
<p align="center"><img src="https://user-images.githubusercontent.com/43980777/164358171-f1f58708-05f3-40cf-b654-53f27c25c20f.png"></p>
<p align="center">
  <a href="https://github.com/NNBnh/dots/wiki"><img src="https://img.shields.io/badge/wiki%20-%23DE5D6E.svg?style=for-the-badge" alt="Wiki"></a>
  <a href="https://github.com/NNBnh/dots/wiki/which"><img src="https://img.shields.io/badge/which%20-%23FF9470.svg?style=for-the-badge" alt="WHICH"></a>
  <a href="https://github.com/NNBnh/dots/releases"><img src="https://img.shields.io/badge/gallery%20-%2376A85D.svg?style=for-the-badge" alt="Gallery"></a>
</p>

## 💡 About

> ⬤ ⬤ ⬤

Welcome to my `Đotfiles` configured with a high level of **portable** for **minimalism** and **optimization**.

### ✨ Features

- **Portable:**
  - Using [**Home Manager**](https://nixos.wiki/wiki/Home_Manager) which can be run on pretty much any where.
- **Minimalism:**
  > Ricing on Nix is so convenient and elegant. I can sink my dotfiles from a big and mess structure config into some small tightly optimize `.nix` files.
  - 🪟 Windows manager: [**HerbstLuftWM**](https://github.com/NNBnh/dots/wiki/which#-windows-manager)
  - Almost all actions are through the CLI powered by:
    - 📟 Terminal: [**Kitty**](https://github.com/NNBnh/dots/wiki/which#-terminal-emulator)
    - 🐚 Shell: [**Xonsh**](https://github.com/NNBnh/dots/wiki/which#-interactive-shell)
    - 📝 Text editor: [**Pepper**](https://github.com/NNBnh/dots/wiki/which#-text-editor)
  - And only 3 GUI applications:
    - 🌏 Browser: [**Firefox**](https://github.com/NNBnh/dots/wiki/which#-web-browser)
    - 🎥 Graphic editor: [**Blender**](https://github.com/NNBnh/dots/wiki/which#-graphic-editor)
    - 🎮 Game engine: [**Godot**](https://github.com/NNBnh/dots/wiki/which#-game-engine)
- **Optimization:**
  - [Maximize the screen real estate.](https://github.com/NNBnh/dots/wiki/which#-bar)
  - [Harmony workflow.](https://github.com/NNBnh/dots/wiki/keyboard#-workflow)
  - [Clean home file structure with short file naming.](https://github.com/NNBnh/dots/wiki/spring-cleaning#-file-structure)
  - [Convenient CLI files management.](https://github.com/NNBnh/dots/wiki/files-manager)

## 🚀 Setup

1. Install [Nix](https://nixos.org/download.html).

2. Clone this repository:

```
nix-shell -p git --command "git clone https://github.com/NNBnh/dots.git ~/c"
```

3. Install [the standalone Home manager tool](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).

4. Finally activate the dotfiles:

```sh
home-manager switch -f ~/c/home.nix
```

Or if you just want to activate only for terminal usage:

```sh
home-manager switch -f ~/c/tty.nix
```

## 💌 Credits

Special thanks to:
- [**NixOS tutorial series**](https://www.youtube.com/playlist?list=PL-saUBvIJzOkjAw_vOac75v-x6EzNzZq-) by [Wil T](https://www.youtube.com/user/wilfridtaylor)

<br><br><br><br>

---

> <h1 align="center">Made with ❤️ by <a href="https://github.com/NNBnh"><i>NNB</i></a></h1>
>
> <p align="center"><a href="https://www.buymeacoffee.com/nnbnh"><img src="https://img.shields.io/badge/buy_me_a_coffee%20-%23FFC387.svg?logo=buy-me-a-coffee&logoColor=333333&style=for-the-badge" alt="Buy Me a Coffee"></a></p>
