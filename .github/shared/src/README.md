# .github/shared/src

## Overview

Helper functions intended for use by any JavaScript, TypeScript, or other code (using a wrapper
that shells to nodejs) in this repo.

## Calling from TypeScript

Shared modules are TypeScript, executed directly by Node.js 24 using native type stripping.
Import their package subpaths; use `import type` for interfaces and type aliases:

```typescript
import { execFile } from "@azure-tools/specs-shared/exec";
import type { ExecOptions } from "@azure-tools/specs-shared/exec";
```

No JavaScript build output is generated. Relative source imports use `.ts` extensions.
Consumers using relative `.ts` imports must enable `allowImportingTsExtensions` with `noEmit`
in their TypeScript configuration.

Use only erasable TypeScript syntax: no enums, parameter properties, or namespaces.
Keep comments for API documentation, not type declarations.
