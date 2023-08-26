# .config

this is just your regular old dotfile repository. In here you'll find
- theovim (a heavily personalized neovim)
- wezterm (probably the best terminal there is)
- a lightweight zsh setup (with vim bindings & pretty prompt ofc)
- some useful bash scripts
- a bunch of global config files (global gitignore, starship...)

## bootstrap

clone this repo (probably can’t use ssh yet) 🤖
```
git clone https://github.com/Theo-Steiner/.config.git

```

make the bootstrap script executable & then run it

```
chmod +x .config/bootstrap
.config/bootstrap

```

this will install `homebrew` (`xcode-cli`), setup symlinks for .zshrc/.zshenv and... WIP

eventually should do:

- install nvim/fnm/starship
- add fira code
- install & start wezterm
