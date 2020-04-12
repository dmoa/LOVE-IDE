cd ..

LOVE_BINARIES=$(pwd)/LOVE/11.3
project_path=$1
platform=$2
bits=$3

lovefile() {
  mkdir -p releases
  "echo" "Converting project to .love file"
  zip -r ./releases/game.love . -x './releases/*' '.*'
}

windows() {
  rm -rf "$LOVE_BINARIES"/temp
  cp -R "$LOVE_BINARIES"/windows-"$bits" "$LOVE_BINARIES"/temp
  cp "$project_path"/releases/game.love "$LOVE_BINARIES"/temp
  cat "$LOVE_BINARIES"/temp/love.exe "$LOVE_BINARIES"/temp/game.love > "$LOVE_BINARIES"/temp/game.exe
  rm "$LOVE_BINARIES"/temp/game.love
  rm "$LOVE_BINARIES"/temp/love.exe
  cd "$LOVE_BINARIES"/temp/ || exit 1
  zip -r "$project_path"/releases/"$PROJECT_NAME"windows-"$bits".zip .
  rm -rf "$LOVE_BINARIES"/temp
}

mac() {
  rm -rf "$SCRIPT_PATH"/temp
  cp -R "$SCRIPT_PATH"/mac "$SCRIPT_PATH"/temp
  cp "$PROJECT_PATH"/releases/game.love "$SCRIPT_PATH"/temp/mac.app/Contents/Resources
  cd "$SCRIPT_PATH"/temp || exit 1
  zip -r -y "$PROJECT_PATH"/releases/"$PROJECT_NAME"_mac.zip . -x './releases/*' '.*'
  rm -rf "$SCRIPT_PATH"/temp
}

linux() {
  rm -rf "$SCRIPT_PATH"/temp
  cp -R "$SCRIPT_PATH"/linux "$SCRIPT_PATH"/temp
  cp "$PROJECT_PATH"/releases/game.love "$SCRIPT_PATH"/temp/application
  cd "$SCRIPT_PATH"/temp || exit 1
  zip -r "$PROJECT_PATH"/releases/"$PROJECT_NAME"_linux.zip .
  rm -rf "$SCRIPT_PATH"/temp
}

cd $project_path
mkdir -p releases

lovefile
$platform