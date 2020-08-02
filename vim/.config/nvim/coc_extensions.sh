#!/usr/bin/bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install extensions
mkdir -p $HOME/.config/coc/extensions
cd $HOME/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install	coc-highlight coc-fzf-preview coc-snippets coc-clangd coc-tsserver coc-vimlsp coc-cmake coc-yank coc-marketplace coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
