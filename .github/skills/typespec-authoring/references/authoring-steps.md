# TypeSpec Authoring Detailed Steps

## New Project Setup

1. Collect org name, service name, and service type (ARM or data-plane)
2. Create project directory under the correct path:
   - ARM: `specification/<orgName>/resource-manager/<RPNamespace>/<ServiceName>/`
   - Data-plane: `specification/<orgName>/data-plane/<ServiceName>/`
3. Run `azsdk_init_typespec_project` to initialize the project

## Authoring Guidelines

- Ensure `@service` and `@server` definitions are correct in main.tsp
- Use the built-in `url` type for endpoint specification
- Define security with `@useAuth` (once, above `@server`)
- Use `@versioned` decorator with a versions enum
- All models, enums, unions, and operations under the main namespace
- Use `union` instead of `enum` for Azure enums
- Add documentation (`/** */`) over all definitions

## Swagger-to-TypeSpec Conversion

1. Run `npm ci` to install dependencies
2. Run `npx tsp-client convert --swagger-readme <path>`
3. Follow the Initial Migration Checklist (verify `@service`/`@server`, `@useAuth`, versioning, documentation, unions vs enums)

## Validation Error Patterns

- Missing `@useDependency` → add over each version enum entry
- Unknown identifier → add missing import/using statement
- camelCase warnings → fix property names only (not string values)

## Best Practices

- Avoid suppressing warnings
- Operation names in camelCase
- Client customizations in `client.tsp` only
- Do not modify package.json or package-lock.json at repo root
- Consult `documentation/ci-fix.md` for CI error fixes

## Documentation References

- Azure TypeSpec libraries: https://azure.github.io/typespec-azure/docs/llms.txt
- TypeSpec language basics: https://typespec.io/docs/llms.txt
