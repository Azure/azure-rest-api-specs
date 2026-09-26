# CRR TypeSpec Migration — Meeting Notes (PR #44457)

**PR:** https://github.com/Azure/azure-rest-api-specs/pull/44457

## Explanation to PR

### Facts

- **RP: `Microsoft.RecoveryServices`** (existing, not changing)
  - 2023-01-15: [bms.json](../../../../recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/stable/2023-01-15/bms.json)
  - 2026-07-15: [bms.json](stable/2026-07-15/bms.json)
- **ARM namespace: `Microsoft.RecoveryServices`** (existing, not changing)
  - 2023-01-15: [bms.json](../../../../recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/stable/2023-01-15/bms.json)
  - 2026-07-15: [main.tsp](main.tsp) (declared via `@armProviderNamespace`, L31/L35)
- All paths under `/providers/Microsoft.RecoveryServices/…`
- Active-stamp spec: already migrated to TypeSpec (mainline folder)
- This PR: passive-stamp (CRR) surface, own TypeSpec project, own folder, own SDK package
- Source swagger (2023-01-15): `specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/stable/2023-01-15/bms.json`
- New swagger (2026-07-15): `specification/recoveryservicesbackupcrr/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackupCrr/stable/2026-07-15/bms.json`

### Why a new folder

- The current `recoveryservicesbackup` folder contains **both** active- and passive-stamp spec.
- **Active** stamp: already migrated to TypeSpec.
- **Passive** stamp: not yet migrated.
- So we are creating a new folder for the passive-stamp spec: `D:\github\azure-rest-api-specs\specification\recoveryservicesbackupcrr`

## Questions

- **Q1** — Currently the 2023-01-15 API version is not using TypeSpec to generate swagger, so we are creating a new folder to generate swagger using TypeSpec.
- **Q2** — Having the same api-version in two folders — will it not cause any issues?
- **Q3** — As the RP is the same, would any additional approval be required?
- **Q4** — How to verify the model changes — manually, or is there a tool? Similarly, we have used Copilot to generate the TypeSpec files; is there any other way?
  - How the `.tsp` was actually generated here: bootstrapped by the **Swagger→TypeSpec converter** (`tsp-client convert` / MCP tool `azsdk_convert_swagger_to_typespec`, which runs AutoRest's `@autorest/openapi-to-typespec` plugin) from the frozen `stable/2023-01-15/bms.json`, then hand-refined commit-by-commit to be byte-faithful.
  - Converter = ~80% mechanical translation; remaining fidelity cleanup (tags, discriminators, nextLink, `x-ms-*`, ordering) done manually.
