<h1 align="center"><code>Đotfiles</code></h1>
<p align="center"><img src="https://user-images.githubusercontent.com/43980777/214214244-60b68efc-d52b-48a1-a926-3c85c25b9a5d.png"></p>
<p align="center"><a href="https://www.pixiv.net/artworks/75924288">Wallpaper</a> by <a href="https://www.pixiv.net/users/2033916">あすてろid</a></p>

<br>

<div align="center">

  ## 🌟 Starring 🌟

  | 💾 **OS**             | [**Nobara**]()
  | :-------------------- | :- |
  | 🏞️ **DE**             | [**KDE**]()
  | 🎨 **Theme**          | [**Catppuccin**]()
  | 📝 **IDE**            | [**VScode**]()
  | 🐚 **Shell**          | [**Bash**]()
  | 🌏 **Browser**        | [**Firefox**]()
  
</div>

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

Install [Catppuccin themes for Firefox](https://github.com/catppuccin/firefox).

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
sudo dnf install --assumeyes starship ruby{,{-doc,-devel}} irb rust cargo nodejs
gem install solargraph rubocop
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
