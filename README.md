<h1 align="center"><code>Đotfiles</code></h1>
<p align="center">https://user-images.githubusercontent.com/43980777/204318909-e894d71b-6c98-40a7-a698-626f4d08f135.webm</p>
<p align="center">
  <a href="https://github.com/NNBnh/dotfiles/wiki"><img src="https://img.shields.io/badge/wiki%20-%23DE5D6E.svg?style=for-the-badge" alt="Wiki"></a>
  <a href="https://github.com/NNBnh/dotfiles/wiki/which"><img src="https://img.shields.io/badge/which%20-%23FF9470.svg?style=for-the-badge" alt="WHICH"></a>
  <a href="https://github.com/NNBnh/dotfiles/releases"><img src="https://img.shields.io/badge/gallery%20-%2376A85D.svg?style=for-the-badge" alt="Gallery"></a>
</p>


## 💡 About

> _Đot_ **_Đot_** **Đot**

My personal Đotfiles.

### ✨ Starring

- 💾 OS: [**Nobara**]()
- 🏞️ DE: [**Gnome**]()
- 📝 IDE: [**VScode**]()
- 🐚 Shell: [**Zsh**]()
- 🌏 Browser: [**Firefox**]()
- 🎥 Graphic editor: [**Blender**]()
- 🎮 Game engine: [**Godot**]()

## 🚀 Setup

### 🖥️ Desktop

First install [Nobara (Gnome)](https://nobaraproject.org) operating system on your machine.

Then install some Gnome extensions to enhance the experience:

- [Unite](https://extensions.gnome.org/extension/1287/unite).
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell).
- [Launch new instance](https://extensions.gnome.org/extension/600/launch-new-instance).
- [Pano](https://extensions.gnome.org/extension/5278/pano).
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect).

Install input method:

```sh
sudo dnf install --assumeyes ibus-unikey
```

Install [Victor Mono](https://rubjo.github.io/victor-mono) [(Nerd font version)](https://www.nerdfonts.com):

```sh
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/VictorMono.zip -o fonts.zip
mkdir -p ~/.local/share/fonts
unzip fonts.zip -d ~/.local/share/fonts
rm fonts.zip
```

### 📦 Applications

Install applications using [Flatpak](https://flatpak.org):

```sh
flatpak install --assumeyes flathub \
  com.visualstudio.code org.blender.Blender org.godotengine.Godot \
  com.usebottles.bottles org.libretro.RetroArch org.prismlauncher.PrismLauncher sh.ppy.osu
```

Install [Firefox Gnome theme](https://github.com/rafaelmardojai/firefox-gnome-theme):

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh)"
```

### 📟 Command-line

First install [Homebrew](https://brew.sh):

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install command-line utilities:

```sh
brew install \
  ruby zsh trash-cli p7zip git \
  figlet genact cmatrix no-more-secrets asciinema
```

Install [`kickstart.zsh`](https://github.com/NNBnh/kickstart.zsh):

```sh
curl https://raw.githubusercontent.com/NNBnh/kickstart.zsh/main/.zshrc > ~/.zshrc
```

Add Ruby's `bin/` to `$PATH`:

```sh
echo 'export PATH="$PATH:/home/linuxbrew/.linuxbrew/lib/ruby/gems/3.1.0/bin"' > ~/.zshrc
```

Config Git:

```sh
git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
git config --global pull.rebase true
```

<a href="https://github.com/NNBnh"><img width="100%" src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"/></a>
