#!/bin/bash

set -ex

# client generators
npm install -g @typespec/compiler
npm install -g @azure-tools/typespec-client-generator-cli

# go setup
go install golang.org/x/tools/cmd/goimports@latest

echo ". /usr/local/share/nvm/nvm.sh" >> ~/.bashrc

pushd /workspaces

langs=(net js java python go)
for lang in "${langs[@]}"; do
  git clone --depth 1 https://github.com/Azure/azure-sdk-for-$lang &
done
wait

popd
