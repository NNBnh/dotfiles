<h1 align="center"><code>Đotfiles</code></h1>
<p align="center">End-game Đotfiles</p>
<p align="center"><img src="https://user-images.githubusercontent.com/43980777/108480424-85941700-72c9-11eb-8380-89ddb5202607.png"></p>
<p align="center">
  <a href="home.nix"><img src="https://img.shields.io/badge/home.nix%20-%235890F8.svg?style=for-the-badge" alt="home.nix"></a>
  <a href="https://github.com/NNBnh/dots/releases"><img src="https://img.shields.io/badge/gallery%20-%2376A85D.svg?style=for-the-badge" alt="Gallery"></a>
  <a href="https://github.com/NNBnh/dots/wiki/which"><img src="https://img.shields.io/badge/which%20-%23FF9470.svg?style=for-the-badge" alt="WHICH"></a>
  <a href="https://github.com/NNBnh/dots/wiki"><img src="https://img.shields.io/badge/wiki%20-%23DE5D6E.svg?style=for-the-badge" alt="Wiki"></a>
</p>

## 💡 About

Welcome to my `Đotfiles` configured with a high level of **portable** for **minimalism** and **optimization**:

> ⬤ ⬤ ⬤

### ✨ Features

- **Portable**
  - Using [**Home Manager**](https://nixos.wiki/wiki/Home_Manager) which can be run on pretty much any OS.
- **Minimalism**
  - Almost all actions are through the [`CLI`](https://en.wikipedia.org/wiki/Command-line_interface) powered by:
    - 📟 Terminal: [**Kitty**](https://github.com/NNBnh/dots/wiki/which#-terminal-emulator)
    - 🐚 Shell: [**Xonsh**](https://github.com/NNBnh/dots/wiki/which#-interactive-shell)
    - 📝 Text editor: [**Helix**](https://github.com/NNBnh/dots/wiki/which#-text-editor "Also used as a $PAGER")
  - And only 4 [`GUI`](https://en.wikipedia.org/wiki/Graphical_user_interface "Graphical user interface") applications:
    - 🌏 Browser: [**UG Chromium**](https://github.com/NNBnh/dots/wiki/which#-web-browser)
    - 🎨 Image editor: [**Krita**](https://github.com/NNBnh/dots/wiki/which#%EF%B8%8F-image-editor)
    - 🎥 Motion graphics: [**Blender**](https://github.com/NNBnh/dots/wiki/which#-motion-graphics)
    - 🎮 Game engine: [**Godot**](https://github.com/NNBnh/dots/wiki/which#-game-engine)
- **Optimization**
  - 🪟 Windows manager: [**Qtile**](https://github.com/NNBnh/dots/wiki/which#-windows-manager)
    - A tree-base tiling windows manager for endless freedom.
    - Maximize the screen real estate.
    - No menu! No bar! No notification!

## 📥 Installation

### ❄️ On [NixOS](https://nixos.org)

Follow [this instruction](https://nixos.org/manual/nixos/stable/index.html) from the beginning to section [2.3. Installing](https://nixos.org/manual/nixos/stable/index.html#sec-installation-installing), right after step 3 then:

1. generate an initial configuration file for your system:

```sh
sudo nixos-generate-config --root /mnt
```

2. Clone this repository:

```sh
nix-env -iA nixos.git
git clone https://github.com/NNBnh/dots.git ~/c
```

3. Run the installation:

```sh
sudo nixos-install -I nixos-config=~/c/configuration.nix
```

4. Install [the standalone Home manager tool](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).

5. Finally activate this dotfiles:

```sh
home-manager switch -f ~/c/home.nix
```

### 🎲 On other OS

1. Do a [quick install of Nix](https://nixos.org/download.html#nix-quick-install):

```sh
curl -L https://nixos.org/nix/install | sh
```

> _Make sure to follow the instructions output by the script._

2. Clone this repository:

```
git clone https://github.com/NNBnh/dots.git ~/c
```

3. Install [the standalone Home manager tool](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).

4. Finally activate this dotfiles:

```sh
home-manager switch -f ~/c/home.nix
```

<br><br><br><br>

---

> <h1 align="center">Made with ❤️ by <a href="https://github.com/NNBnh"><i>NNB</i></a></h1>
>
> <p align="center"><a href="https://www.buymeacoffee.com/nnbnh"><img src="https://img.shields.io/badge/buy_me_a_coffee%20-%23FFC387.svg?logo=buy-me-a-coffee&logoColor=333333&style=for-the-badge" alt="Buy Me a Coffee"></a></p>
