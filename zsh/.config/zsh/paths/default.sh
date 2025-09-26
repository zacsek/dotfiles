# Add ~/opt/bin to PATH
path+=("$HOME/opt/bin")

# Add all bin directories in subdirectories of ~/opt to PATH
path+=($HOME/opt/*/bin)
path+=($HOME/opt/*/*/bin)

# Remove duplicates
typeset -U path
