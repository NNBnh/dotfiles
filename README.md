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

  |      OS | 💽 | [Nobara](https://nobaraproject.org)
  | ------: | -- | :- |
  |      DE | 🏞️ | [Gnome](https://www.gnome.org)
  |   Theme | 🎨 | [Catppuccin](https://github.com/catppuccin/catppuccin)
  |     IDE | 📝 | [VScode](https://code.visualstudio.com)
  |   Shell | 🐚 | [Ruby on Shell](https://www.ruby-lang.org)
  | Browser | 🌏 | [Firefox](https://nnbnh.github.io/blog/en/posts/3)

</div>

> **Note** I will make [a blog](https://nnbnh.github.io/blog) explain how I use Ruby as a shell.

## 🚀 Setup

Install the following Gnome extensions:

- [Unite](https://extensions.gnome.org/extension/1287/unite)
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell)
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect)

Then run:

<pre><code class="sh"><a href="https://flatpak.org">flatpak</a> install --assumeyes flathub \
  <a href="https://godotengine.org">org.godotengine.Godot</a> \
  <a href="https://www.retroarch.com">org.libretro.RetroArch</a> <a href="https://ryujinx.org">org.ryujinx.Ryujinx</a> \
  <a href="https://prismlauncher.org">org.prismlauncher.PrismLauncher</a> <a href="https://osu.ppy.sh">sh.ppy.osu</a>

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install --assumeyes <a href="https://code.visualstudio.com">code</a>

<a href="https://brew.sh">bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"</a>
printf '\n%s' 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install <a href="https://www.nushell.sh">nushell</a> <a href="https://www.ruby-lang.org">ruby</a> <a href="https://www.rust-lang.org">rust</a> <a href="https://nodejs.org">node</a>

printf '\n%s\n%s' 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' 'case $- in *i*) exec nu ;; esac' >> ~/.bashrc

gem install <a href="https://solargraph.org">solargraph</a> <a href="https://rubocop.org">rubocop</a>

<a href="https://github.com/catppuccin/gnome-terminal">curl -fsSL https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 -</a>

<a href="https://github.com/rafaelmardojai/firefox-gnome-theme">bash -c "$(curl -fsSL https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh)"</a>

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
git config --global pull.rebase true</code></pre>

<a href="https://github.com/NNBnh">
  <img
    width="100%"
    src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"
    alt="Made with <3 by NNB"
  />
</a>
