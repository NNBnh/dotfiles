<div align="center">
  <img
    width="100%"
    src="https://codeberg.org/attachments/5613c6b6-0604-49b7-b40e-126036751417"
    alt="Screenshot"
  />
  <p>
    <a href="https://www.pixiv.net/artworks/72727430">Wallpaper</a>
    by
    <a href="https://www.pixiv.net/users/864706">けみ猫</a>
  </p>

  <br />

  ## 🌟 Starring 🌟

  |      OS | 💽 | [BlendOS](https://NNB.codeberg.page/blog/en/posts/13)
  | ------: | -- | :- |
  |      DE | 🏞️ | [Gnome](https://NNB.codeberg.page/blog/en/posts/13#desktop-environment)
  |   Theme | 🎨 | [Catppuccin](https://NNB.codeberg.page/blog/en/posts/8/#da-one)
  |     IDE | 📝 | [VScode](https://nnb.codeberg.page/blog/en/posts/14)
  |   Shell | 🐚 | [Ruby on Shell](https://NNB.codeberg.page/blog/en/posts/7)
  | Browser | 🌏 | [Firefox](https://NNB.codeberg.page/blog/en/posts/3)

</div>

## 🚀 Setup

Install the following Gnome extensions:

- [Unite](https://extensions.gnome.org/extension/1287/unite)
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell)
- [Rounded Window Corners](https://extensions.gnome.org/extension/5237/rounded-window-corners)
- [Compiz windows effect](https://extensions.gnome.org/extension/3210/compiz-windows-effect)
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect)
- [Pano](https://extensions.gnome.org/extension/5278/pano)
- [Color Picker](https://extensions.gnome.org/extension/3396/color-picker)

Then run:

<pre><code class="sh"><a href="https://flatpak.org">flatpak</a> install --assumeyes flathub \
  <a href="https://github.com/mjakeman/extension-manager">com.mattjakeman.ExtensionManager</a> \
  <a href="https://usebottles.com">com.usebottles.bottles</a> \
  <a href="https://code.visualstudio.com">com.visualstudio.code</a> \
  <a href="https://godotengine.org">org.godotengine.Godot</a> \
  <a href="https://www.blender.org">org.blender.Blender</a> \
  <a href="https://store.steampowered.com">com.valvesoftware.Steam</a> \
  <a href="https://ryujinx.org">org.ryujinx.Ryujinx</a> \
  <a href="https://prismlauncher.org">org.prismlauncher.PrismLauncher</a>
<a href="https://github.com/flathub/org.blender.Blender/issues/130">sudo flatpak override --nosocket=wayland --socket=x11 org.blender.Blender</a>

sudo system install <a href="https://gitlab.gnome.org/GNOME/gnome-tweaks">gnome-tweaks</a> <a href="https://github.com/vn-input/ibus-unikey">ibus-unikey</a> <a href="https://github.com/oae/gnome-shell-pano#installation">libgda6</a>
user create-container a <a href="https://archlinux.org">arch</a>
sudo pacman.a -Suy --noconfirm <a href="https://www.rust-lang.org">rustup</a> <a href="https://nodejs.org">npm</a>
yay.a -S --noconfirm <a href="https://github.com/postmodern/ruby-install">ruby-install</a>
ruby-install.a ruby

<a href="https://github.com/rafaelmardojai/firefox-gnome-theme">bash -c "$(curl -fsSL https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh)"</a>

git.a config --global user.email nnbnh@protonmail.com
git.a config --global user.name NNB
git.a config --global credential.helper store
git.a config --global pull.rebase true</code></pre>

<a href="https://nnb.codeberg.page">
  <img
    width="100%"
    src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"
    alt="Made with <3 by NNB"
  />
</a>
