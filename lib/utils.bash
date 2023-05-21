#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for oapi-codegen.
GO_INSTALL="github.com/deepmap/oapi-codegen/cmd/oapi-codegen"
GH_REPO="https://github.com/deepmap/oapi-codegen"
TOOL_NAME="oapi-codegen"
TOOL_TEST="oapi-codegen --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if oapi-codegen is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# TODO: Adapt this. By default we simply list the tag names from GitHub releases.
	# Change this function if oapi-codegen has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	# TODO: Adapt the release URL convention for oapi-codegen
	url="$GH_REPO/archive/v${version}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" = "version" ]; then
    version="v$version"
  fi

  (
    asdf current golang >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      echo "An asdf Go version has already been selected; I'll use that to build $TOOL_NAME."
    else
      echo "No asdf Go version is selected; I'll install the latest version to build $TOOL_NAME."

      # In order to build a Go application from source, we need a Go compiler.
      asdf plugin add golang || true
      asdf install golang latest

      # We can't use `asdf shell` within an `asdf plugin test` environment. For
      # compatibility with both `asdf plugin test` and `asdf install`, we'll
      # configure the Go version with `asdf local`; and to avoid making unwanted
      # modifications to .tool-versions in the pwd, we'll move somewhere else.
      mkdir -p "$install_path"
      cd "$install_path"
      asdf local golang latest
    fi

    # Now we can let the Go toolchain retrieve and install the application as
    # normal, except that we'll dump the binary into the install path instead
    # of $GOPATH/bin.
    export GOBIN="$install_path"
    go install "$GO_INSTALL"@"$version" || fail "An error occurred while installing $TOOL_NAME $version."

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
