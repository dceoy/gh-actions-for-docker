#!/usr/bin/env bash

set -euox pipefail

ruff format --exclude=build --line-length=79 . && isort --skip-glob=build .
flake8 --exclude=build . && ruff check --exclude=build .
mypy --exclude=build --install-types --non-interactive --ignore-missing-imports .
bandit --exclude=build --recursive .
