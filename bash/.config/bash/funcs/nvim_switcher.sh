alias nvim-astro="NVIM_APPNAME=nvim-astro nvim"
alias nvim-chad="NVIM_APPNAME=nvim-chad nvim"
alias nvim-lazy="NVIM_APPNAME=nvim-lazy nvim"

nvims() {
  items=("default" "nvim-astro" "nvim-chad" "nvim-lazy")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

#bindkey -s ^a "nvims\n"
