<h1 align="center"><code>Đotfiles</code></h1>
<p align="center"><img src="https://user-images.githubusercontent.com/43980777/218121026-2d2ddb94-5105-4df8-a6a9-8ab632b69ce3.png"></p>
<p align="center"><a href="https://www.pixiv.net/artworks/76523866">Wallpaper</a> by <a href="https://www.pixiv.net/users/211515">防人</a></p>

<br>

<div align="center">

  ## 🌟 Starring 🌟

  | 💾 **OS**             | [**Vanilla OS**](https://vanillaos.org)
  | :-------------------- | :- |
  | 🏞️ **DE**             | [**Gnome**](https://www.gnome.org)
  | 🎨 **Theme**          | [**Catppuccin**](https://github.com/catppuccin/catppuccin)
  | 📝 **IDE**            | [**VScode**](https://code.visualstudio.com)
  | 🐚 **Shell**          | [**Ruby**](https://www.ruby-lang.org)
  | 🌏 **Browser**        | [**Firefox**](https://nnbnh.github.io/blog/en/posts/3)

</div>

> **Note** I will make [a blog](https://nnbnh.github.io/blog) explain how I use Ruby as a shell.

## 🚀 Setup

### 🖥️ Desktop

First install [Vanilla OS](https://vanillaos.org) on your machine.

Then install application style, fonts and input method:

```sh
sudo dnf install --assumeyes jetbrains-mono-fonts fcitx5-unikey
```

### 📦 Applications

Install applications using [Flatpak](https://flatpak.org):

```sh
flatpak install --assumeyes flathub \
  com.visualstudio.code org.blender.Blender org.godotengine.Godot \
  com.valvesoftware.Steam org.libretro.RetroArch org.ryujinx.Ryujinx \
  org.prismlauncher.PrismLauncher sh.ppy.osu
```

### 📟 Command-line

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

<a href="https://github.com/NNBnh"><img width="100%" src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80" /></a>
