# CodeTransparency contract regressions

From the repository root, after the normal `npm ci`, run the existing Vitest runner and configuration:

```powershell
npx vitest run --config eng\tools\typespec-validation\vitest.config.js --dir specification\confidentialledger\Microsoft.CodeTransparency\test
```

The tests compile the real project, check both HTTP version projections against pre-consolidation snapshots, compare emitted OpenAPI with the checked-in files, and inspect C#, Java, Python, and JavaScript client-generator metadata. They do not generate SDK packages or introduce a new test framework.

The snapshots were captured before consolidating the duplicate operations, using the repository's TypeSpec 1.16.0 and Azure libraries 0.72.0. Only the operation names were normalized to their stable names. They preserve each version's routes, methods, parameters, response codes, binary bodies, media types, headers, model properties, JWK encoded names, and requiredness. Descriptions and deprecation metadata are excluded from the wire snapshots and tested separately where relevant.

The shared `getOperation` declaration carries a version-qualified deprecation message. TypeSpec's `#deprecated` directive is not versioned, so both projections expose the annotation even though the message explicitly dates deprecation to `2026-03-26`. The endpoint remains available in both versions.

AutoRest omits unreachable schemas so the version-selection unions are not emitted as unsupported OpenAPI 2 payload definitions. This also prunes previously unused envelope definitions; all referenced JSON payload definitions and binary HTTP contracts are preserved.

These service-local tests are explicitly invoked with the command above; no workflow or global test-discovery configuration is changed. Snapshot updates require reviewing both API-version wire contracts, not merely accepting output from `--update`.
