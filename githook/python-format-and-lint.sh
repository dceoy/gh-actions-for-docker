#!/usr/bin/env bash

set -euox pipefail

PYTHON_LINE_LENGTH=88
RUFF_LINT_EXTEND_SELECT='F,E,W,C90,I,N,D,UP,S,B,A,COM,C4,PT,Q,SIM,ARG,ERA,PD,PLC,PLE,PLW,TRY,FLY,NPY,PERF,FURB,RUF'
RUFF_LINT_IGNORE='D100,D103,D203,D213,S101,B008,A002,A004,COM812,PLC2701,TRY003'
PACKAGE_DIRECTORY="$(find . -type f -name 'pyproject.toml' -exec dirname {} \; | head -n 1)"
if [[ -n "${PACKAGE_DIRECTORY}" ]] && [[ -f "${PACKAGE_DIRECTORY}/poetry.lock" ]]; then
  poetry -C "${PACKAGE_DIRECTORY}" run ruff format .
  poetry -C "${PACKAGE_DIRECTORY}" run ruff check --fix .
  poetry -C "${PACKAGE_DIRECTORY}" run pyright .
elif [[ -n "${PACKAGE_DIRECTORY}" ]]; then
  ruff format .
  ruff check --fix .
  pyright .
else
  ruff format --exclude=build "--line-length=${PYTHON_LINE_LENGTH}" .
  ruff check --fix --exclude=build "--line-length=${PYTHON_LINE_LENGTH}" --extend-select="${RUFF_LINT_EXTEND_SELECT}" --ignore="${RUFF_LINT_IGNORE}" .
  pyright --threads 0 .
fi
