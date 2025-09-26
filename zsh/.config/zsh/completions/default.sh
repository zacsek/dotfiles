# k3s completion
if command -v k3s &> /dev/null; then
  source <(k3s completion zsh)
fi

# You can add more zsh-native completions here.
# For example, for kubectl:
# if command -v kubectl &> /dev/null; then
#   source <(kubectl completion zsh)
# fi
