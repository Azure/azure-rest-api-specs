#!/bin/sh

[ -z "$PREPRODUCTION_PIPELINE" ] || {
  echo "Switch to preproduction package.json"
  cp -f .azure-pipelines-preproduction/package.json ./package.json
  cp -f .azure-pipelines-preproduction/package-lock.json ./package-lock.json
  PREPRODUCTION_PIPELINE= npm ci
}
