#!/usr/bin/env bash

set -euox pipefail

terraform fmt -recursive . && terragrunt hclfmt --terragrunt-diff --terragrunt-working-dir .
tflint --recursive --filter .
trivy config .
