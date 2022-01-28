<h1 align="center"><code>Đotfiles</code></h1>
<p align="center">End-game Đotfiles</p>
<p align="center"><img src="https://user-images.githubusercontent.com/43980777/149666467-fe0c9390-a03d-45e4-bda8-21826f6a58b0.png"></p>
<p align="center">
  <a href="https://github.com/NNBnh/dots/wiki"><img src="https://img.shields.io/badge/wiki%20-%23DE5D6E.svg?style=for-the-badge" alt="Wiki"></a>
  <a href="https://github.com/NNBnh/dots/wiki/which"><img src="https://img.shields.io/badge/which%20-%23FF9470.svg?style=for-the-badge" alt="WHICH"></a>
  <a href="https://github.com/NNBnh/dots/releases"><img src="https://img.shields.io/badge/gallery%20-%2376A85D.svg?style=for-the-badge" alt="Gallery"></a>
  <br>
  <a href="sys.nix"><img src="https://img.shields.io/badge/sys.nix%20-%2364B5A7.svg?style=flat-square" alt="sys.nix"></a>
  <a href="home.nix"><img src="https://img.shields.io/badge/home.nix%20-%235890F8.svg?style=flat-square" alt="home.nix"></a>
  <a href="tty.nix"><img src="https://img.shields.io/badge/tty.nix%20-%23C173D1.svg?style=flat-square" alt="tty.nix"></a>
</p>

## 💡 About

> ⬤ ⬤ ⬤

Welcome to my `Đotfiles` configured with a high level of **portable** for **minimalism** and **optimization**.

### ✨ Features

- **Portable:**
  - Using [**Home Manager**](https://nixos.wiki/wiki/Home_Manager) which can be run on pretty much [any OS](https://github.com/NNBnh/dots#-pre-install), even on [Android](https://github.com/NNBnh/dots#-android).
- **Minimalism:**
  > Ricing on Nix is so convenient and elegant. I can sink my dotfiles from a big and mess structure config into some small tightly optimize `.nix` files. My whole dotfiles is now just:
  >
  > ![File count](https://img.shields.io/badge/files-3%20-%235890F8.svg?labelColor=525866&style=flat-square)
  > ![Lines of code](https://img.shields.io/tokei/lines/github/NNBnh/dots?labelColor=525866&color=5890F8&style=flat-square)
  - No need for tiling WM, a simple and quick floating WM is perfect for my workflow:
    - 🪟 Windows manager: [**Wayfire**](https://github.com/NNBnh/dots/wiki/which#-windows-manager)
  - Almost all actions are through the CLI powered by:
    - 📟 Terminal: [**Kitty**](https://github.com/NNBnh/dots/wiki/which#-terminal-emulator)
    - 🐚 Shell: [**Xonsh**](https://github.com/NNBnh/dots/wiki/which#-interactive-shell)
    - 📝 Text editor: [**Helix**](https://github.com/NNBnh/dots/wiki/which#-text-editor "Also used as a $PAGER")
  - And only 3 GUI applications:
    - 🌏 Browser: [**UG Chromium**](https://github.com/NNBnh/dots/wiki/which#-web-browser)
    - 🎥 Graphic editor: [**Blender**](https://github.com/NNBnh/dots/wiki/which#-graphic-editor)
    - 🎮 Game engine: [**Godot**](https://github.com/NNBnh/dots/wiki/which#-game-engine)
- **Optimization:**
  - [Maximize the screen real estate.](https://github.com/NNBnh/dots/wiki/which#-bar)
  - [Harmony workflow.](https://github.com/NNBnh/dots/wiki/keyboard#-workflow)
  - [Clean home file structure with short file naming.](https://github.com/NNBnh/dots/wiki/spring-cleaning#-file-structure)
  - [Convenient CLI files management.](https://github.com/NNBnh/dots/wiki/files-manager)

## 🚀 Setup

### 🚧 Pre-Install

#### ❄️ NixOS

On [NixOS](https://nixos.org), follow [this instruction](https://nixos.org/manual/nixos/stable/index.html) from the beginning to section [2.3. Installing](https://nixos.org/manual/nixos/stable/index.html#sec-installation-installing).
Right after step 3, generate an initial configuration file for your system:

```sh
sudo nixos-generate-config --root /mnt
```

```sh
sudo curl https://raw.githubusercontent.com/NNBnh/dots/main/sys.nix -o /mnt/etc/nixos/configuration.nix
```

Then run the installation:

```sh
sudo nixos-install
```

Finally reboot your system.

#### 📱 Android

Install [Nix-on-Droid](https://github.com/t184256/nix-on-droid) as a Termux replacement.

#### 🎲 Other OS

Do a [quick install of Nix](https://nixos.org/download.html#nix-quick-install):

```sh
curl -L https://nixos.org/nix/install | sh
```

> _Make sure to follow the instructions output by the script._

### 📥 Installation

1. Clone this repository:

```
nix-env -iA nixos.git # Use "nixpkgs.git" if you are not on NixOS
git clone https://github.com/NNBnh/dots.git ~/c
```

2. Install [the standalone Home manager tool](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).

3. Finally activate the dotfiles:

```sh
home-manager switch -f ~/c/home.nix
```

Or if you just want to activate only for terminal use:

```sh
home-manager switch -f ~/c/tty.nix
```

<br><br><br><br>

---

> <h1 align="center">Made with ❤️ by <a href="https://github.com/NNBnh"><i>NNB</i></a></h1>
>
> <p align="center"><a href="https://www.buymeacoffee.com/nnbnh"><img src="https://img.shields.io/badge/buy_me_a_coffee%20-%23FFC387.svg?logo=buy-me-a-coffee&logoColor=333333&style=for-the-badge" alt="Buy Me a Coffee"></a></p>
