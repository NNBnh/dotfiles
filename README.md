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

  |      OS | 💽 | [Nobara](https://NNB.codeberg.page/blog/en/posts/13)
  | ------: | -- | :- |
  |      DE | 🏞️ | [Gnome](https://NNB.codeberg.page/blog/en/posts/13#desktop-environment)
  |   Theme | 🎨 | [Catppuccin](https://NNB.codeberg.page/blog/en/posts/8/#da-one)
  |     IDE | 📝 | [VScode](https://code.visualstudio.com)
  |   Shell | 🐚 | [Ruby on Shell](https://NNB.codeberg.page/blog/en/posts/7)
  | Browser | 🌏 | [Firefox](https://NNB.codeberg.page/blog/en/posts/3)

</div>

## 🚀 Setup

Install the following Gnome extensions:

- [Unite](https://extensions.gnome.org/extension/1287/unite)
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell)
- [Rounded Window Corners](https://extensions.gnome.org/extension/5237/rounded-window-corners)
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect)
- [Pano](https://extensions.gnome.org/extension/5278/pano)

Then run:

<pre><code class="sh"><a href="https://flatpak.org">flatpak</a> install --assumeyes flathub \
  <a href="https://gradienceteam.github.io">com.github.GradienceTeam.Gradience</a> \
  <a href="https://code.visualstudio.com">com.visualstudio.code</a> \
  <a href="https://godotengine.org">org.godotengine.Godot</a> \
  <a href="https://www.blender.org">org.blender.Blender</a> \
  <a href="https://ryujinx.org">org.ryujinx.Ryujinx</a> \
  <a href="https://prismlauncher.org">org.prismlauncher.PrismLauncher</a>
<a href="https://github.com/flathub/org.blender.Blender/issues/130">flatpak override --nosocket=wayland --socket=x11 org.blender.Blender</a>

sudo dnf copr enable --assumeyes <a href="https://copr.fedorainfracloud.org/coprs/astrawan/nerd-fonts">astrawan/nerd-fonts</a>
sudo dnf install --assumeyes <a href="https://www.jetbrains.com/lp/mono">nerd-jetbrainsmono-fonts</a> <a href="https://github.com/vn-input/ibus-unikey">ibus-unikey</a>

<a href="https://brew.sh">bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"</a>
brew install <a href="https://www.ruby-lang.org">ruby</a> <a href="https://www.rust-lang.org">rust</a> <a href="https://nodejs.org">nodejs</a>

<a href="https://github.com/rafaelmardojai/firefox-gnome-theme">bash -c "$(curl -fsSL https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh)"</a>

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
git config --global pull.rebase true</code></pre>

<a href="https://nnb.codeberg.page">
  <img
    width="100%"
    src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"
    alt="Made with <3 by NNB"
  />
</a>
