<div align="center">
  <img width="100%" src="https://capsule-render.vercel.app/api?type=waving&section=header&color=0284C7&fontColor=F0F9FF&height=256&text=%C4%90otfiles&desc=My%20personal%20%C4%90otfiles&fontAlignY=40" />

  <img src="https://codeberg.org/attachments/5613c6b6-0604-49b7-b40e-126036751417" />

  <p><a href="https://www.pixiv.net/artworks/72727430">Wallpaper</a> by <a href="https://www.pixiv.net/users/864706">けみ猫</a></p>

  <br />

  ## 🌟 Starring 🌟

  |      OS | 💽 | [Dank Linux](https://danklinux.com)
  | ------: | -- | :- |
  |      DE | 🏞️ | [Niri](https://github.com/niri-wm/niri)
  |   Shell | 🐚 | [Flyline](https://github.com/HalFrgrd/flyline)
  | Browser | 🌏 | [Helium](https://helium.computer)
  |  Editor | 📝 | [Helix](https://helix-editor.com)

</div>

## 🚀 Setup

### 🪟 Install applications

<pre class="code-block"><code class="chroma language-sh display"><a href="https://flatpak.org">flatpak</a> install flathub --assumeyes <a href="https://github.com/fcitx/fcitx5-unikey">org.fcitx.Fcitx5</a> <a href="https://github.com/fcitx/fcitx5-unikey">org.fcitx.Fcitx5.Addon.Unikey</a> <a href="https://usebottles.com">com.usebottles.bottles</a></code></pre>

### 📟 Install CLI packages

Install Homebrew:

```sh
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"
```

Install [Homebrew](https://brew.sh)'s packages:

<pre class="code-block"><code class="chroma language-sh display">brew install <a href="https://starship.rs">starship</a> <a href="https://eza.rocks">eza</a> <a href="https://helix-editor.com">helix</a> <a href="https://7-zip.org">sevenzip</a> <a href="https://github.com/andreafrancia/trash-cli">trash-cli</a> <a href="https://bun.com">bun</a> <a href="https://gleam.run">gleam</a> <a href="https://www.ruby-lang.org">ruby</a></code></pre>

Or install [Termux](https://wiki.termux.com/wiki/Package_Management)'s packages:

<pre class="code-block"><code class="chroma language-sh display">pkg install --yes <a href="https://starship.rs">starship</a> <a href="https://eza.rocks">eza</a> <a href="https://helix-editor.com">helix</a> <a href="https://7-zip.org">7zip</a> <a href="https://github.com/andreafrancia/trash-cli">python-trash-cli</a> <a href="https://gleam.run">gleam</a> <a href="https://www.ruby-lang.org">ruby</a></code></pre>

> Then install [Bun](https://bun.com) separately:
>
> ```sh
> curl -fsSL "https://bun.sh/install" | bash
> ```

Install [Flyline](https://github.com/HalFrgrd/flyline):

```sh
curl -fsSL "https://github.com/HalFrgrd/flyline/releases/latest/download/install.sh" | sh
```

### 📄 Install Dotfiles

```sh
curl "https://codeberg.org/NNB/dotfiles/raw/branch/main/.bashrc" > ~/.bashrc
```

That's all!

<a href="https://nnb.codeberg.page">
  <img
    width="100%"
    src="https://capsule-render.vercel.app/api?type=waving&section=footer&color=0284C7&fontColor=F0F9FF&height=128&desc=Made%20with%20%26lt;3%20by%20NNB&descAlignY=80"
    alt="Made with <3 by NNB"
  />
</a>
