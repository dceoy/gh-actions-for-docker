#!/usr/bin/env bash

set -euox pipefail

find .github/workflows -type f \( -name '*.yml' -o -name '*.yaml' \) -exec actionlint {} \;
find .github/workflows -type f \( -name '*.yml' -o -name '*.yaml' \) -exec yamllint -d '{"extends": "relaxed", "rules": {"line-length": "disable"}}' {} \;
