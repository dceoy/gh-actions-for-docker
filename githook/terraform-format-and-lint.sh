#!/usr/bin/env bash

set -euox pipefail

terraform fmt -recursive . && terragrunt hclfmt --diff --working-dir .
tflint --recursive --filter .
trivy filesystem --scanners vuln,secret,misconfig .
