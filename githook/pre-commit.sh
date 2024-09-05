#!/usr/bin/env bash

set -euox pipefail

N_PYTHON_FILES=$(find . -type f -name '*.py' | wc -l)
if [[ "${N_PYTHON_FILES}" -gt 0 ]]; then
  package_directory="$(find . -type f -name 'pyproject.toml' -exec dirname {} \; | head -n 1)"
  if [[ -f "${package_directory}/poetry.lock" ]]; then
    poetry -C "${package_directory}" run ruff format .
    poetry -C "${package_directory}" run isort .
    poetry -C "${package_directory}" run mypy .
    poetry -C "${package_directory}" run pyright .
    poetry -C "${package_directory}" run flake8 .
    poetry -C "${package_directory}" run ruff check .
    poetry -C "${package_directory}" run bandit .
  else
    ruff format --exclude=build --line-length=79 "${package_directory}"
    isort --skip-glob=build "${package_directory}"
    mypy --exclude=build --install-types --non-interactive --ignore-missing-imports "${package_directory}"
    pyright "${package_directory}"
    flake8 --exclude=build "${package_directory}"
    ruff check --exclude=build "${package_directory}"
    bandit --exclude=build --recursive "${package_directory}"
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
