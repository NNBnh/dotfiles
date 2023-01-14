<h1 align="center"><code>Đotfiles</code></h1>
<p align="center">https://user-images.githubusercontent.com/43980777/204318909-e894d71b-6c98-40a7-a698-626f4d08f135.webm</p>
<p align="center">
  <a href="https://github.com/NNBnh/dotfiles/wiki"><img src="https://img.shields.io/badge/wiki%20-%23DE5D6E.svg?style=for-the-badge" alt="Wiki"></a>
  <a href="https://github.com/NNBnh/dotfiles/wiki/which"><img src="https://img.shields.io/badge/which%20-%23FF9470.svg?style=for-the-badge" alt="WHICH"></a>
  <a href="https://github.com/NNBnh/dotfiles/releases"><img src="https://img.shields.io/badge/gallery%20-%2376A85D.svg?style=for-the-badge" alt="Gallery"></a>
</p>


## 💡 About

My personal Đotfiles.

### ✨ Starring

| 💾 **OS**             | [**Nobara**]()
| :-------------------- | :- |
| 🏞️ **DE**             | [**KDE**]()
| 🎨 **Theme**          | [**Catppuccin**]()
| 📝 **IDE**            | [**VScode**]()
| 🐚 **Shell**          | [**Bash**]()
| 🌏 **Browser**        | [**Firefox**]()
| 🎥 **Media editor**   | [**Blender**]()
| 🎮 **Game engine**    | [**Godot**]()

## 🚀 Setup

### 🖥️ Desktop

First install [Nobara KDE](https://nobaraproject.org/download-nobara) on your machine.

Then install application style, fonts and input method:

```sh
sudo dnf install --assumeyes lightly jetbrains-mono-fonts fcitx5-unikey
```

Install [Catppuccin themes for KDE](https://github.com/catppuccin/kde):

```sh
git clone --depth 1 https://github.com/catppuccin/kde catppuccin-kde
mkdir -p ~/.local/share/color-schemes
find catppuccin-kde -type f -name "*.colors" -exec cp "{}" ~/.local/share/color-schemes \;
find catppuccin-kde -type f -name "*.tar.gz" -exec kpackagetool5 -i "{}" \;
rm -rf catppuccin-kde
```

Set the <kbd>GUI</kbd> key as a shortcut to open KRunner:

```sh
kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.krunner,/App,,toggleDisplay"
qdbus org.kde.KWin /KWin reconfigure
```

Add this setting into `~/.config/kwinrc`:

```ini
[Windows]
BorderlessMaximizedWindows=true
```

### 📦 Applications

Install applications using [Flatpak](https://flatpak.org):

```sh
flatpak install --assumeyes flathub \
  org.kde.krita org.blender.Blender org.godotengine.Godot \
  org.libretro.RetroArch org.yuzu_emu.yuzu \
  org.prismlauncher.PrismLauncher sh.ppy.osu
```

Install [Catppuccin themes for Konsole](https://github.com/catppuccin/konsole):

```sh
git clone --depth 1 https://github.com/catppuccin/konsole catppuccin-konsole
mkdir -p ~/.local/share/konsole
cp catppuccin-konsole/*.colorscheme ~/.local/share/konsole
rm -rf catppuccin-konsole
```

### 🧰 IDE

Install [VScode](https://code.visualstudio.com):

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code
```

Install command-line utilities:

```sh
sudo dnf install --assumeyes starship ruby irb ruby-doc rust cargo nodejs
```

Install [Starship prompt](https://starship.rs):

```sh
echo 'eval "$(starship init bash)"' >> ~/.bashrc
```

Config Git:

```sh
git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
git config --global pull.rebase true
```

<a href="https://github.com/NNBnh"><img width="100%" src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"/></a>
