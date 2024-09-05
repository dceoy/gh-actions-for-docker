#!/usr/bin/env bash

set -euox pipefail

package_directory="$(find . -type f -name 'pyproject.toml' -exec dirname {} \;)"
if [[ -f "${package_directory}/poetry.lock" ]]; then
  cd "${package_directory}"
  poetry run ruff format .
  poetry run isort .
  poetry run flake8 .
  poetry run ruff check .
  # poetry run mypy .
  poetry run pyright .
  poetry run bandit .
else
  ruff format --exclude=build --line-length=79 .
  isort --skip-glob=build .
  flake8 --exclude=build .
  ruff check --exclude=build .
  # mypy --exclude=build --install-types --non-interactive --ignore-missing-imports .
  pyright --exclude=build .
  bandit --exclude=build --recursive .
fi
