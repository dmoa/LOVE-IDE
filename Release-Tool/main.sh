#!/bin/sh

cd ..

LOVE_BINARIES=$(pwd)/LOVE/11.3
project_path=$1
project_name=$2
platform=$3
bits=$4

lovefile() {
  mkdir -p releases
  zip -r -1 -qq ./releases/game.love . -x './releases/*' '.*'
}

windows() {
  rm -rf "$LOVE_BINARIES"/temp
  cp -R "$LOVE_BINARIES"/windows-"$bits" "$LOVE_BINARIES"/temp
  cp "$project_path"/releases/game.love "$LOVE_BINARIES"/temp
  cat "$LOVE_BINARIES"/temp/love.exe "$LOVE_BINARIES"/temp/game.love > "$LOVE_BINARIES"/temp/game.exe
  rm "$LOVE_BINARIES"/temp/game.love
  rm "$LOVE_BINARIES"/temp/love.exe
  cd "$LOVE_BINARIES"/temp/ || exit 1
  zip -r -1 -qq "$project_path"/releases/"$project_name"windows-"$bits".zip .
  rm -rf "$LOVE_BINARIES"/temp
}

mac() {
  rm -rf "$LOVE_BINARIES"/temp
  cp -R "$LOVE_BINARIES"/mac "$LOVE_BINARIES"/temp
  cp "$project_path"/releases/game.love "$LOVE_BINARIES"/temp/love.app/Contents/Resources
  cd "$LOVE_BINARIES"/temp || exit 1
  zip -r -y -1 -qq "$project_path"/releases/"$project_name"mac.zip . -x './releases/*' '.*'
  rm -rf "$LOVE_BINARIES"/temp
}

linux() {
  rm -rf "$SCRIPT_PATH"/temp
  cp -R "$SCRIPT_PATH"/linux "$SCRIPT_PATH"/temp
  cp "$PROJECT_PATH"/releases/game.love "$SCRIPT_PATH"/temp/application
  cd "$SCRIPT_PATH"/temp || exit 1
      cat > love <<'EOF'
#!/bin/sh
LOVE_LAUNCHER_LOCATION="$(dirname "$(command -v "$0")")"
export LD_LIBRARY_PATH="${LOVE_LAUNCHER_LOCATION}/lib/x86_64-linux-gnu:${LOVE_LAUNCHER_LOCATION}/usr/bin:${LOVE_LAUNCHER_LOCATION}/usr/lib:${LOVE_LAUNCHER_LOCATION}/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
/sbin/ldconfig -p | grep -q libstdc++ || export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${LOVE_LAUNCHER_LOCATION}/libstdc++/"
exec "${LOVE_BIN_WRAPPER}" "${LOVE_LAUNCHER_LOCATION}/usr/bin/love" "${LOVE_LAUNCHER_LOCATION}/game.love"
EOF
  zip -r "$PROJECT_PATH"/releases/"$project_name"_linux.zip .
  rm -rf "$SCRIPT_PATH"/temp
}

cd $project_path
mkdir -p releases

lovefile
$platform

exit 0