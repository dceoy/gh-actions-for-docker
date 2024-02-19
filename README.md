gh-actions-for-devops
=====================

GitHub Actions workflows for DevOps

[![Lint and scan](https://github.com/dceoy/gh-actions-for-devops/actions/workflows/local-lint-and-scan.yml/badge.svg)](https://github.com/dceoy/gh-actions-for-devops/actions/workflows/local-lint-and-scan.yml)

Reusable workflows
------------------

- .github/workflows/

  - aws-cloudformation-lint.yml
    - Lint for AWS CloudFormation

  - docker-build-and-push.yml
    - Docker image build and push

  - docker-compose-build-and-push.yml
    - Docker image build and push using docker-compose

  - json-lint.yml
    - Lint for JSON

  - python-package-format.yml
    - Formatter for a Python package

  - python-package-lint-and-scan.yml
    - Lint and security scan for a Python package

  - python-package-release-on-pypi-and-github.yml
    - Python package release on PyPI and GitHub

  - python-pyinstaller.yml
    - Build an executable file using PyInstaller

  - r-lint.yml
    - Lint for an R project

  - shell-lint.yml
    - Lint for Shell

  - terraform-lint-and-scan.yml
    - Lint and security scan for Terraform

  - yaml-lint.yml
    - Lint for YAML
