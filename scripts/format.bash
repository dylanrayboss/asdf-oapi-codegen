#!/usr/bin/env bash

<<<<<<< HEAD
shfmt --language-dialect bash --write \
	./**/*
=======
# format this repo
shfmt --language-dialect bash --write \
	setup.bash \
	scripts/*.bash

# format the template/
shfmt --language-dialect bash --write \
	template/**/*
>>>>>>> f31da0c3fc5a28058f20e5ec6fb81e225e70b1eb
