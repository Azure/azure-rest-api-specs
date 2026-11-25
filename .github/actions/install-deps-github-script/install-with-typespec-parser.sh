#!/usr/bin/env bash

set -euo pipefail

pnpm install --frozen-lockfile --prod --prefer-offline --config.trust-lockfile=true --filter=azure-rest-api-specs-github...
npm ci --prefix .github/typespec-import-parser --omit=dev --ignore-scripts
