#!/usr/bin/env bash

<<<<<<< HEAD
shellcheck --shell=bash --external-sources \
	bin/* --source-path=template/lib/ \
	lib/* \
	scripts/*

shfmt --language-dialect bash --diff \
	./**/*
=======
# lint this repo
shellcheck --shell=bash --external-sources \
	setup.bash \
	scripts/*

shfmt --language-dialect bash --diff \
	setup.bash \
	scripts/*

# lint the template/
shellcheck --shell=bash --external-sources \
	template/bin/* --source-path=template/lib/ \
	template/lib/* \
	template/scripts/*

shfmt --language-dialect bash --diff \
	template/**/*
>>>>>>> f31da0c3fc5a28058f20e5ec6fb81e225e70b1eb
