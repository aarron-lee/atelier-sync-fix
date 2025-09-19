#!/bin/bash

if [ "$EUID" -eq 0 ]
  then echo "Please do not run as root"
  exit
fi

D3DLL_FILE=$HOME/Downloads/atelier-d3d11.dll

echo "downloading atelier-sync-fix"
curl -L $(curl -s https://api.github.com/repos/TellowKrinkle/atelier-sync-fix/releases/tags/atelier-sophie-20231022 | grep "browser_download_url" | cut -d '"' -f 4) -o $D3DLL_FILE

GAME_DIR_PREFIX="$HOME/.local/share/Steam/steamapps/common"

DEST_DIRS=(
    "$GAME_DIR_PREFIX/Atelier Ayesha DX/"
    "$GAME_DIR_PREFIX/Atelier Escha and Logy DX/"
    "$GAME_DIR_PREFIX/Atelier Shallie DX/"
    "$GAME_DIR_PREFIX/Atelier Ryza/"
)

for dir in "${DEST_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Copying d3d11.dll to $dir..."
        ln "$D3DLL_FILE" "$dir/d3d11.dll"
    else
        echo "Directory not found: $dir"
    fi
done

echo "Copying complete."

rm $D3DLL_FILE

echo 'Installation complete. You still need to add the wine override to each game:'
echo 'WINEDLLOVERRIDES="d3d11=n,b" %command%'
