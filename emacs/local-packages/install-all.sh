#/bin/sh

if ! command -v curl &>/dev/null; then
    echo "curl command is not available"
    exit 1
fi

HERE="$(dirname $(realpath $0))"

echo "Getting odin-mode..."
curl -L# \
     -o "$HERE/odin-mode.el" \
     https://github.com/mattt-b/odin-mode/raw/refs/heads/master/odin-mode.el \
     || echo "failed to get odin-mode"
