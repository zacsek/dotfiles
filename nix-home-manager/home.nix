{ config, pkgs, pkgs-unstable ? pkgs, username ? "zacsek", ... }:

let
  # Helper to resolve packages from pkgs, falling back to pkgs-unstable, or null
  getPkg = name: pkgs.${name} or pkgs-unstable.${name} or null;
in
{
  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
  home.stateVersion = "25.05";

  # ---------------------------------------------------------------------------
  # CLI Tools (Synchronized with bom.txt)
  # ---------------------------------------------------------------------------
  home.packages = builtins.filter (p: p != null) [
    # -------------------------------------------------------------------------
    # 1. Package Managers, Runtimes & Version Managers
    # -------------------------------------------------------------------------
    pkgs.cargo
    pkgs.rustc
    pkgs.nodejs
    pkgs.yarn
    pkgs.python3
    pkgs.python3Packages.pip
    pkgs.ruby
    pkgs.mise
    pkgs.stow
    pkgs.mkcert
    pkgs.flatpak
    pkgs.dpkg
    pkgs.frum
    (getPkg "pacman")

    # -------------------------------------------------------------------------
    # 2. Shells, Prompts & History
    # -------------------------------------------------------------------------
    pkgs.zsh
    pkgs.bash
    pkgs.atuin
    pkgs.zoxide
    pkgs.direnv
    pkgs.zsh-powerlevel10k
    pkgs.zsh-autosuggestions
    pkgs.zsh-history-substring-search
    pkgs.zsh-syntax-highlighting
    (getPkg "pkgfile")

    # -------------------------------------------------------------------------
    # 3. Terminal Workspaces & Multiplexers
    # -------------------------------------------------------------------------
    pkgs.alacritty
    (getPkg "ghostty")
    pkgs.tmux
    pkgs.zellij

    # -------------------------------------------------------------------------
    # 4. Text Editors & Interactive Development Tools
    # -------------------------------------------------------------------------
    pkgs.neovim
    pkgs.vim
    (getPkg "opencode")

    # -------------------------------------------------------------------------
    # 5. File System, Search & Navigation Utilities
    # -------------------------------------------------------------------------
    pkgs.bat
    (pkgs.bat-extras.batman or null)
    (pkgs.bat-extras.batdiff or null)
    pkgs.colordiff
    pkgs.universal-ctags
    pkgs.delta
    pkgs.diff-so-fancy
    pkgs.dos2unix
    pkgs.dua
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.jdupes
    pkgs.less
    pkgs.lesspipe
    pkgs.rm-improved # rip
    pkgs.ripgrep
    (getPkg "yazi")

    # -------------------------------------------------------------------------
    # 6. Terminal User Interfaces (TUIs) & Database Tools
    # -------------------------------------------------------------------------
    pkgs.lazygit
    pkgs.lazydocker
    (getPkg "lazysql")
    (getPkg "lazyjournal")
    (getPkg "jqp")
    (getPkg "lq")

    # -------------------------------------------------------------------------
    # 7. Language Servers, Linters & Formatters
    # -------------------------------------------------------------------------
    pkgs.black
    pkgs.clang-tools # clangd, clang-format
    pkgs.codespell
    pkgs.isort
    (getPkg "lua-language-server")
    (getPkg "prettierd")
    (pkgs.nodePackages.prettier or pkgs.prettier or null)
    (pkgs.nodePackages.eslint or pkgs.eslint or null)
    (getPkg "pyright")
    (getPkg "rubocop")
    (getPkg "ruby-lsp")
    pkgs.rustfmt
    (getPkg "standardrb")
    pkgs.stylua
    (getPkg "vscode-langservers-extracted") # html-lsp, cssls, jsonls
    (getPkg "yaml-language-server")

    # -------------------------------------------------------------------------
    # 8. Version Control & Development
    # -------------------------------------------------------------------------
    pkgs.git
    pkgs.gh
    pkgs.gitg
    pkgs.gnumake
    pkgs.ninja

    # -------------------------------------------------------------------------
    # 9. System, Monitoring & Process Management
    # -------------------------------------------------------------------------
    pkgs.btop
    pkgs.util-linux # dmesg, etc.
    pkgs.gdb
    pkgs.inxi
    pkgs.procps # pgrep, pkill
    pkgs.lm_sensors # sensors
    pkgs.upower

    # -------------------------------------------------------------------------
    # 10. Networking, Remote Access & Cloud
    # -------------------------------------------------------------------------
    pkgs.curl
    pkgs.docker-client
    pkgs.docker-compose
    pkgs.fuse3 # fusermount, fusermount3
    pkgs.gocryptfs
    pkgs.iproute2 # ip
    pkgs.k3s
    pkgs.kubectl
    (pkgs.netcat-gnu or pkgs.netcat or null) # nc
    pkgs.rsync
    pkgs.openssh # ssh
    pkgs.sshfs
    pkgs.tailscale

    # -------------------------------------------------------------------------
    # 11. Clipboard, Media & Terminal Formatting
    # -------------------------------------------------------------------------
    pkgs.copyq
    (getPkg "expac")
    pkgs.figlet
    pkgs.jq
    pkgs.lolcat
    (getPkg "maestral")
    (getPkg "matugen")
    pkgs.libnotify # notify-send
    (getPkg "quickshell")
    pkgs.wl-clipboard # wl-copy
    pkgs.xclip
    pkgs.yt-dlp
    pkgs.qpdf # zlib-flate
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
