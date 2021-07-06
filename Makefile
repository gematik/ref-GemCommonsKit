#
# Makefile
#

PROJECT_DIR	:= $(PWD)

.PHONY: bootstrap setup test build lint cibuild

bootstrap:
	$(PROJECT_DIR)/scripts/bootstrap

setup:
	$(PROJECT_DIR)/scripts/setup

test:
	$(PROJECT_DIR)/scripts/test

build:
	$(PROJECT_DIR)/scripts/build

lint:
	$(PROJECT_DIR)/scripts/lint

cibuild:
	$(PROJECT_DIR)/scripts/cibuild
