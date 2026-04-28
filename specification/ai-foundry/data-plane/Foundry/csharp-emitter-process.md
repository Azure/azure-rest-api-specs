# C# Service Emitter Process for Foundry (Agents + Agent Session Files)

## Summary
This document captures the exact process used to successfully emit C# service code for:

- Agents APIs
- Agent Session Files APIs

in the Foundry TypeSpec project.

## Root Cause of Initial Failure
Running the emitter from the full project entrypoint failed:

- Command attempted:
  - npx tsp compile . --config tspconfig.yaml --emit @azure-tools/typespec-csharp
- Error observed:
  - import-not-found for @azure-tools/typespec-csharp (package not installed in repo dependencies)

After temporarily installing the emitter, running from main entrypoint still failed due generator crash related to wildcard content types in other routes (not the target agents/session-files surface).

## What Was Needed to Make It Compile
1. Temporarily install the C# emitter package locally (without committing dependency changes).
2. Compile from client.tsp (not from . or main.tsp) so the compile surface includes agents + agents-session-files, while avoiding the crashing path.
3. Restore dependencies with npm ci to return node_modules to lockfile state.

## Exact Commands
Run from repo root:

```powershell
cd c:\azure-rest-api-specs
npm install --no-save --no-package-lock --legacy-peer-deps @azure-tools/typespec-csharp
```

Run compile from Foundry project:

```powershell
cd c:\azure-rest-api-specs\specification\ai-foundry\data-plane\Foundry
npx tsp compile client.tsp --config tspconfig.yaml --emit @azure-tools/typespec-csharp
```

Restore dependency tree:

```powershell
cd c:\azure-rest-api-specs
npm ci
```

## Why client.tsp Was Used
- main.tsp includes additional routes (for example invocation protocol paths) that currently trigger C# generator crash in this environment.
- client.tsp includes both:
  - src/agents/routes.tsp
  - src/agents-session-files/routes.tsp

This gave successful code generation for the requested API surfaces.

## Expected Output Location
Generated C# output is written under:

- tsp-output/sdk/ai/Azure.AI.Agents.Contracts.V2/src/Generated

Examples to verify:

- Agents client:
  - tsp-output/sdk/ai/Azure.AI.Agents.Contracts.V2/src/Generated/Agents.cs
- Session file operations:
  - tsp-output/sdk/ai/Azure.AI.Agents.Contracts.V2/src/Generated/BetaAgents.cs
- Session file models:
  - tsp-output/sdk/ai/Azure.AI.Agents.Contracts.V2/src/Generated/Models/SessionFileWriteResponse.cs
  - tsp-output/sdk/ai/Azure.AI.Agents.Contracts.V2/src/Generated/Models/SessionDirectoryListResponse.cs

## Notes
- The compile may emit warnings (for example unsupported PATCH convenience methods). Those warnings did not block generation.
- No repository source files needed to be edited to get this working; only generation commands were required.
