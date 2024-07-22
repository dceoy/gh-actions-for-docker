gh-actions-for-devops
=====================

GitHub Actions workflows for DevOps

[![CI](https://github.com/dceoy/gh-actions-for-devops/actions/workflows/ci.yml/badge.svg)](https://github.com/dceoy/gh-actions-for-devops/actions/workflows/ci.yml)

Reusable workflows
------------------

- [.github/workflows/](.github/workflows/)

  - [aws-cloudformation-lint.yml](.github/workflows/aws-cloudformation-lint.yml)
    - Lint for AWS CloudFormation

  - [dependabot-auto-merge.yml](.github/workflows/dependabot-auto-merge.yml)
    - Dependabot auto-merge

  - [docker-build-and-push.yml](.github/workflows/docker-build-and-push.yml)
    - Docker image build and push

  - [docker-build-with-multi-targets.yml](.github/workflows/docker-build-with-multi-targets.yml)
    - Docker image build and save for multiple build targets

  - [docker-compose-build-and-push.yml](.github/workflows/docker-compose-build-and-push.yml)
    - Docker image build and push using docker-compose

  - [docker-lint-and-scan.yml](.github/workflows/docker-lint-and-scan.yml)
    - Lint and security scan for Dockerfile

  - [docker-pull-from-aws.yml](.github/workflows/docker-pull-from-aws.yml)
    - Docker image pull from AWS

  - [docker-save-and-terraform-deploy-to-aws.yml](.github/workflows/docker-save-and-terraform-deploy-to-aws.yml)
    - Docker image save and resource deployment to AWS using Terraform

  - [github-actions-lint.yml](.github/workflows/github-actions-lint.yml)
    - Lint for GitHub Actions workflows

  - [github-codeql-analysis.yml](.github/workflows/github-codeql-analysis.yml)
    - GitHub CodeQL Analysis

  - [github-release.yml](.github/workflows/github-release.yml)
    - Release on GitHub

  - [json-lint.yml](.github/workflows/json-lint.yml)
    - Lint for JSON

  - [microsoft-defender-for-devops.yml](.github/workflows/microsoft-defender-for-devops.yml)
    - Microsoft Defender for Devops

  - [pr-agent.yml](.github/workflows/pr-agent.yml)
    - PR-agent

  - [python-package-format-and-pr.yml](.github/workflows/python-package-format-and-pr.yml)
    - Formatter for Python

  - [python-package-lint-and-scan.yml](.github/workflows/python-package-lint-and-scan.yml)
    - Lint and security scan for Python

  - [python-package-release-on-pypi-and-github.yml](.github/workflows/python-package-release-on-pypi-and-github.yml)
    - Python package release on PyPI and GitHub

  - [python-pyinstaller.yml](.github/workflows/python-pyinstaller.yml)
    - Build using PyInstaller

  - [r-package-format-and-pr.yml](.github/workflows/r-package-format-and-pr.yml)
    - Formatter for R

  - [r-package-lint.yml](.github/workflows/r-package-lint.yml)
    - Lint for R

  - [shell-lint.yml](.github/workflows/shell-lint.yml)
    - Lint for Shell

  - [terraform-deploy-to-aws.yml](.github/workflows/terraform-deploy-to-aws.yml)
    - Deployment of AWS resources using Terraform

  - [terraform-format-and-pr.yml](.github/workflows/terraform-format-and-pr.yml)
    - Formatter for Terraform

  - [terraform-lint-and-scan.yml](.github/workflows/terraform-lint-and-scan.yml)
    - Lint and security scan for Terraform

  - [terragrunt-aws-switch-resources.yml](.github/workflows/terragrunt-aws-switch-resources.yml)
    - Switcher to apply or destroy AWS resources using Terragrunt

  - [terragrunt-upgrade-lock-files.yml](.github/workflows/terragrunt-upgrade-lock-files.yml)
    - Terraform lock files upgrader for Terragrunt

  - [toml-lint.yml](.github/workflows/toml-lint.yml)
    - Lint for TOML

  - [yaml-lint.yml](.github/workflows/yaml-lint.yml)
    - Lint for YAML
