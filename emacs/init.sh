#/bin/sh

if ! command -v curl &>/dev/null; then
    echo "curl command is not available"
    exit 1
fi

HERE="$(dirname $(realpath $0))"
HXLOCAL="$HERE/hxlocal"

mkdir -p "$HXLOCAL"
touch "$HERE/custom.el"

echo "Getting odin-mode..."
curl -L# \
     https://github.com/mattt-b/odin-mode/raw/refs/heads/master/odin-mode.el \
     > "$HXLOCAL/odin-mode.el" || echo "failed to get odin-mode"
