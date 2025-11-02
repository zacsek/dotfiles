#!/bin/bash

# Path to your Ruby LSP executable
RUBY_LSP_EXECUTABLE="/home/zacsek/.local/share/mise/installs/ruby/3.4.7/bin/ruby-lsp"

# Port to run the LSP server on
PORT=3000

# Start the Ruby LSP server
$RUBY_LSP_EXECUTABLE --tcp --port $PORT
