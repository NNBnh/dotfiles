<div align="center">
  <img
    width="100%"
    src="https://user-images.githubusercontent.com/43980777/218121026-2d2ddb94-5105-4df8-a6a9-8ab632b69ce3.png"
    alt="Screenshot"
  />
  <p>
    <a href="https://www.pixiv.net/artworks/76523866">Wallpaper</a>
    by
    <a href="https://www.pixiv.net/users/211515">防人</a>
  </p>

  <br />

  ## 🌟 Starring 🌟

  |      OS | 💾 | [Vanilla OS](https://vanillaos.org)
  | ------: | -- | :- |
  |      DE | 🏞️ | [Gnome](https://www.gnome.org)
  |   Theme | 🎨 | [Catppuccin](https://github.com/catppuccin/catppuccin)
  |     IDE | 📝 | [VScode](https://code.visualstudio.com)
  |   Shell | 🐚 | [Ruby on Shell](https://www.ruby-lang.org)
  | Browser | 🌏 | [Firefox](https://nnbnh.github.io/blog/en/posts/3)

</div>

> **Note** I will make [a blog](https://nnbnh.github.io/blog) explain how I use Ruby as a shell.

## 🚀 Setup

```sh
flatpak install --assumeyes flathub \
  org.mozilla.firefox com.usebottles.bottles \
  com.visualstudio.code org.blender.Blender org.godotengine.Godot \
  com.valvesoftware.Steam org.libretro.RetroArch org.ryujinx.Ryujinx \
  org.prismlauncher.PrismLauncher sh.ppy.osu

apx install --aur ttf-iosevka-nerd ibus-bamboo aseprite git ruby{,-docs} rust nodejs

apx run --aur gem install solargraph rubocop

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
git config --global pull.rebase true
```

<a href="https://github.com/NNBnh">
  <img
    width="100%"
    src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"
    alt="Made with <3 by NNB"
  />
</a>
