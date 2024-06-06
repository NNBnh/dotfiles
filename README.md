<div align="center">
  <img width="100%" src="https://capsule-render.vercel.app/api?type=waving&section=header&color=0284C7&fontColor=F0F9FF&height=256&text=%C4%90otfiles&desc=My%20personal%20%C4%90otfiles&fontAlignY=40" />

  <img src="https://codeberg.org/attachments/5613c6b6-0604-49b7-b40e-126036751417" />

  <p><a href="https://www.pixiv.net/artworks/72727430">Wallpaper</a> by <a href="https://www.pixiv.net/users/864706">けみ猫</a></p>

  <br />

  ## 🌟 Starring 🌟

  |      OS | 💽 | [Fedora](https://NNB.codeberg.page/blog/en/posts/13)
  | ------: | -- | :- |
  |      DE | 🏞️ | [Gnome](https://NNB.codeberg.page/blog/en/posts/13#desktop-environment)
  |     IDE | 📝 | [VScode](https://nnb.codeberg.page/blog/en/posts/14)
  |   Shell | 🐚 | [Nushell](https://NNB.codeberg.page/blog/en/posts/7)
  | Browser | 🌏 | [Brave](https://NNB.codeberg.page/blog/en/posts/3)

</div>

## 🚀 Setup

Run the following commands:

<pre><code class="sh">sudo dnf install --assumeyes <a href="https://github.com/lassekongo83/adw-gtk3">adw-gtk3-theme</a> <a href="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme">papirus-icon-theme</a> <a href="https://www.jetbrains.com/lp/mono">jetbrains-mono-fonts</a> <a href="https://github.com/vn-input/ibus-unikey">ibus-unikey</a> <a href="https://github.com/GSConnect/gnome-shell-extension-gsconnect/wiki/Error#openssl-not-found">openssl</a>

gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 12'

<a href="https://flatpak.org">flatpak</a> install flathub --assumeyes \
  <a href="https://usebottles.com">com.usebottles.bottles</a> \
  <a href="https://obsproject.com">com.obsproject.Studio</a> \
  <a href="https://brave.com">com.brave.Browser</a> \
  <a href="https://code.visualstudio.com">com.visualstudio.code</a> \
  <a href="https://godotengine.org">org.godotengine.Godot</a> \
  <a href="https://www.blender.org">org.blender.Blender</a> \
  <a href="https://store.steampowered.com">com.valvesoftware.Steam</a> \
  <a href="https://ryujinx.org">org.ryujinx.Ryujinx</a> \
  <a href="https://prismlauncher.org">org.prismlauncher.PrismLauncher</a>

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
git config --global pull.rebase true</code></pre>

Then install the following Gnome extensions:

- [Unite](https://extensions.gnome.org/extension/1287/unite)
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell)
- [Compiz windows effect](https://extensions.gnome.org/extension/3210/compiz-windows-effect)
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect)
- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator)
- [Color Picker](https://extensions.gnome.org/extension/3396/color-picker)

That's all!

<a href="https://nnb.codeberg.page">
  <img
    width="100%"
    src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"
    alt="Made with <3 by NNB"
  />
</a>
