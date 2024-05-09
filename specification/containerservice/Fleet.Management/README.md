# Fleet service cadl project

## Getting started

- environment setup: https://microsoft.github.io/typespec/introduction/installation

## Generate fleet swagger

## NPM registry authentication

We have to use the Central Feed Service for NPM to fetch the typespec dependencies.
The `.npmrc` file configures the folder accordingly for CI.

in development, you can tell npm to use the standard public registry by specifying it:

`npm install --registry https://registry.npmjs.org`

then:

`tsp compile .`

## Development

Always edit `tsp` files, and generate swagger, never edit the swagger directly.
