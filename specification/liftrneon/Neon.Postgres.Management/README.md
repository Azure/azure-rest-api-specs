# Neon Postgres service typespec project

## Getting started

- environment setup: https://microsoft.github.io/typespec/introduction/installation

## Generate Neon swagger

## NPM registry authentication

We have to use the Liftr Feed Service for NPM to fetch the typespec dependencies.
The `.npmrc` file configures the folder accordingly.

in development, you can tell npm to use the standard public registry by specifying it:

`npm install --registry https://registry.npmjs.org`

then:

`tsp compile .`

## Development

Always edit `tsp` files, and generate swagger, never edit the swagger directly.

For generating examples use the following command:

`oav generate-examples neon.json`
