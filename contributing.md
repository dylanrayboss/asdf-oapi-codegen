# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test oapi-codegen https://github.com/dylanrayboss/asdf-oapi-codegen.git "oapi-codegen --version"
```

Tests are automatically run in GitHub Actions on push and PR.
