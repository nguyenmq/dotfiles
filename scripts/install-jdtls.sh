#!/bin/bash
# install-jdtls.sh - Installs a jdtls (Eclipse JDT Language Server) release for nvim-jdtls
#
# Usage: install-jdtls.sh <path-to-jdtls-release.tar.gz>
#
# The installed paths mirror the paths hard-coded in nvim/ftplugin/java.lua.
# New releases of jdtls can be found here: https://github.com/eclipse-jdtls/eclipse.jdt.ls

set -euo pipefail

JDTLS_HOME="${HOME}/.local/share/nvim/lsp_servers/jdtls"

tarball="${1:-}"
if [[ -z "$tarball" ]]; then
    echo "Usage: $(basename "$0") <path-to-jdtls-release.tar.gz>" >&2
    exit 1
fi

if [[ ! -f "$tarball" ]]; then
    echo "Not a file: $tarball" >&2
    exit 1
fi

# Extract to its own directory under /tmp, cleaned up on exit.
extract_dir="$(mktemp -d /tmp/jdtls-install.XXXXXX)"
trap 'rm -rf "$extract_dir"' EXIT

echo "Extracting $tarball -> $extract_dir"
tar -xzf "$tarball" -C "$extract_dir"

# The release ships plugins/ and config_linux/ at its root.
plugins_src="$(find "$extract_dir" -maxdepth 2 -type d -name plugins | head -1)"
config_src="$(find "$extract_dir" -maxdepth 2 -type d -name config_linux | head -1)"

if [[ -z "$plugins_src" ]]; then
    echo "Could not find a 'plugins' directory in the tarball." >&2
    exit 1
fi
if [[ -z "$config_src" ]]; then
    echo "Could not find a 'config_linux' directory in the tarball." >&2
    exit 1
fi

mkdir -p "$JDTLS_HOME"

# Always install a fresh copy of plugins/ and config_linux/
echo "Installing plugins -> ${JDTLS_HOME}/plugins"
rm -rf "${JDTLS_HOME}/plugins"
cp -r "$plugins_src" "${JDTLS_HOME}/plugins"

echo "Installing config_linux -> ${JDTLS_HOME}/config_linux"
rm -rf "${JDTLS_HOME}/config_linux"
cp -r "$config_src" "${JDTLS_HOME}/config_linux"

# The launcher jar is versioned e.g. org.eclipse.equinox.launcher_1.7.200.v20260619-2039.jar
# Discover its real name and symlink the unversioned name that java.lua expects
launcher="$(find "${JDTLS_HOME}/plugins" -maxdepth 1 -type f \
    -name 'org.eclipse.equinox.launcher_*.jar' -printf '%f\n' | head -1)"

if [[ -z "$launcher" ]]; then
    echo "Could not find org.eclipse.equinox.launcher_*.jar in plugins." >&2
    exit 1
fi

echo "Linking org.eclipse.equinox.launcher.jar -> $launcher"
ln -sfn "$launcher" "${JDTLS_HOME}/plugins/org.eclipse.equinox.launcher.jar"

echo "Done. jdtls installed to ${JDTLS_HOME}"
