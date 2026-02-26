# TypeSpec Migration Checklist

Key items to verify when converting swagger to TypeSpec or creating a new TypeSpec project.

## Service Definition

- [ ] `@service` and `@server` definitions are correct in main.tsp
- [ ] Use built-in `url` type for endpoint specification in `@server`
- [ ] `@useAuth` decorator defined ONCE above `@server` with correct security scheme

## Versioning

- [ ] Versions enum declared under the main namespace in main.tsp
- [ ] `@versioned` decorator specified over the namespace, passing the versions enum
- [ ] If using versioning decorators (`@added`, `@removed`, `@changedType`), import `@typespec/versioning` and add `using TypeSpec.Versioning`

## Namespace and Organization

- [ ] Avoid adding new namespaces
- [ ] All models, enums, unions, and operations under the main namespace
- [ ] No types declared outside of a namespace

## Enums and Unions

- [ ] Use `union` instead of `enum` for Azure enums
- [ ] All enum/union members have documentation comments
- [ ] Properly documented with `/** */` format

## Documentation

- [ ] All models, properties, operations, parameters, enums, unions, and aliases have `/** */` doc comments
- [ ] Use doc comment format `/** <docs> */` (not `//` or `/* */`)

## Visibility

- [ ] Visibility decorators use appropriate values from the Lifecycle class

## Naming

- [ ] Operation names are camelCase
- [ ] String values in TypeSpec files left untouched (camelCase fixes apply to property names only)

## Client Customizations

- [ ] Client customizations in `client.tsp` only
- [ ] `@azure-tools/typespec-client-generator-core` imported only in client.tsp

## Warnings and Errors

- [ ] Run `tsp compile .` and address all warnings (one attempt)
- [ ] Avoid suppressing warnings
- [ ] Address FIXME/TODO comments where possible

## Repository Rules

- [ ] Do not modify root package.json or package-lock.json
- [ ] Do not add custom package.json files in project directory
- [ ] Only one tspconfig.yaml per service specification
