#!/usr/bin/env bash

set -euox pipefail

find .github/workflows -type f \( -name '*.yml' -o -name '*.yaml' \) -print0 \
  | xargs -0 -t actionlint
find .github/workflows -type f \( -name '*.yml' -o -name '*.yaml' \) -print0 \
  | xargs -0 -t yamllint -d '{"extends": "relaxed", "rules": {"line-length": "disable"}}'
