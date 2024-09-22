#!/usr/bin/env bash

set -euox pipefail

PYTHON_LINE_LENGTH=88
PACKAGE_DIRECTORY="$(find . -type f -name 'pyproject.toml' -exec dirname {} \; | head -n 1)"
if [[ -n "${PACKAGE_DIRECTORY}" ]] && [[ -f "${PACKAGE_DIRECTORY}/poetry.lock" ]]; then
  poetry -C "${PACKAGE_DIRECTORY}" run ruff format .
  poetry -C "${PACKAGE_DIRECTORY}" run isort .
  poetry -C "${PACKAGE_DIRECTORY}" run mypy .
  poetry -C "${PACKAGE_DIRECTORY}" run pyright .
  poetry -C "${PACKAGE_DIRECTORY}" run flake8 .
  poetry -C "${PACKAGE_DIRECTORY}" run ruff check .
  poetry -C "${PACKAGE_DIRECTORY}" run bandit .
elif [[ -n "${PACKAGE_DIRECTORY}" ]]; then
  ruff format .
  isort .
  mypy .
  pyright .
  flake8 .
  ruff check .
  bandit .
else
  ruff format --exclude=build "--line-length=${PYTHON_LINE_LENGTH}" .
  isort --skip-glob=build "--line-length=${PYTHON_LINE_LENGTH}" --profile=black .
  mypy --exclude=build --install-types --non-interactive --ignore-missing-imports --strict --strict-equality --strict-optional .
  pyright --threads 0 .
  flake8 --exclude=build "--max-line-length=${PYTHON_LINE_LENGTH}" --ignore=B008,W503 .
  ruff check --exclude=build "--line-length=${PYTHON_LINE_LENGTH}" .
  bandit --exclude=build --recursive .
fi
