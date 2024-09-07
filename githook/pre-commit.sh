#!/usr/bin/env bash

set -euox pipefail

PYTHON_LINE_LENGTH=88
N_PYTHON_FILES=$(find . -type f -name '*.py' | wc -l)
if [[ "${N_PYTHON_FILES}" -gt 0 ]]; then
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
    isort --skip-glob=build "--line-length=${PYTHON_LINE_LENGTH}" .
    mypy --exclude=build --install-types --non-interactive --ignore-missing-imports --strict --strict-equality --strict-optional .
    pyright --threads 0 .
    flake8 --exclude=build "--max-line-length=${PYTHON_LINE_LENGTH}" .
    ruff check --exclude=build "--line-length=${PYTHON_LINE_LENGTH}" .
    bandit --exclude=build --recursive --skip B101 .
  fi
fi

N_BASH_FILES=$(find . -type f \( -name '*.sh' -o -name '*.bash' -o -name '*.bats' \) | wc -l)
if [[ "${N_BASH_FILES}" -gt 0 ]]; then
  find . -type f \( -name '*.sh' -o -name '*.bash' -o -name '*.bats' \) -print0 | xargs -0 -t shellcheck
fi

if [[ -d '.github/workflows' ]]; then
  find .github/workflows -type f \( -name '*.yml' -o -name '*.yaml' \) -print0 \
    | xargs -0 -t actionlint
  find .github/workflows -type f \( -name '*.yml' -o -name '*.yaml' \) -print0 \
    | xargs -0 -t yamllint -d '{"extends": "relaxed", "rules": {"line-length": "disable"}}'
fi

N_TERRAFORM_FILES=$(find . -type f \( -name '*.tf' -o -name '*.hcl' \) | wc -l)
if [[ "${N_TERRAFORM_FILES}" -gt 0 ]]; then
  terraform fmt -recursive . && terragrunt hclfmt --terragrunt-diff --terragrunt-working-dir .
  tflint --recursive --filter .
fi

N_DOCKER_FILES=$(find . -type f -name 'Dockerfile' | wc -l)
if [[ "${N_DOCKER_FILES}" -gt 0 ]] || [[ "${N_TERRAFORM_FILES}" -gt 0 ]]; then
  trivy filesystem --scanners vuln,secret,misconfig .
fi
