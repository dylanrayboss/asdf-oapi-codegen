<div align="center">

# asdf-oapi-codegen [![Build](https://github.com/dylanrayboss/asdf-oapi-codegen/actions/workflows/build.yml/badge.svg)](https://github.com/dylanrayboss/asdf-oapi-codegen/actions/workflows/build.yml) [![Lint](https://github.com/dylanrayboss/asdf-oapi-codegen/actions/workflows/lint.yml/badge.svg)](https://github.com/dylanrayboss/asdf-oapi-codegen/actions/workflows/lint.yml)


[oapi-codegen](https://github.com/deepmap/oapi-codegen) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add oapi-codegen
# or
asdf plugin add oapi-codegen https://github.com/dylanrayboss/asdf-oapi-codegen.git
```

oapi-codegen:

```shell
# Show all installable versions
asdf list-all oapi-codegen

# Install specific version
asdf install oapi-codegen latest

# Set a version globally (on your ~/.tool-versions file)
asdf global oapi-codegen latest

# Now oapi-codegen commands are available
oapi-codegen --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/dylanrayboss/asdf-oapi-codegen/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [dylan](https://github.com/dylanrayboss/)
