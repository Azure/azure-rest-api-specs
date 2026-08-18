# CRR TypeSpec migration differences

This document tracks the `tsmv` comparison between the original `2023-01-15`
CRR Swagger and the Swagger generated from the converted TypeSpec.

## Current status

- TypeSpec compilation succeeds.
- The first comparison reported eight changed paths.
- All eight path differences are now resolved.
- No path differences remain in the current `tsmv` output.
- Other operation and model differences remain and are documented below.

## Compared inputs

Original Swagger:

```text
D:\github\azure-rest-api-specs\specification\recoveryservicesbackup\resource-manager\Microsoft.RecoveryServices\RecoveryServicesBackup\stable\2023-01-15\bms.json
```

TypeSpec-generated Swagger:

```text
D:\github\azure-rest-api-specs\specification\recoveryservicesbackup\resource-manager\Microsoft.RecoveryServices\RecoveryServicesBackupCrr\stable\2023-01-15\bms.json
```

## Complete comparison artifacts

```text
C:\Users\bharatpurwar\.copilot\session-state\c4642ed0-362a-4745-b7dc-a7bb0e6cdb3d\files\crr-tsmv-migration3-parent-routes\API_CHANGES.md
C:\Users\bharatpurwar\.copilot\session-state\c4642ed0-362a-4745-b7dc-a7bb0e6cdb3d\files\crr-tsmv-migration3-parent-routes\oldNormalizedSwagger.json
C:\Users\bharatpurwar\.copilot\session-state\c4642ed0-362a-4745-b7dc-a7bb0e6cdb3d\files\crr-tsmv-migration3-parent-routes\newNormalizedSwagger.json
C:\Users\bharatpurwar\.copilot\session-state\c4642ed0-362a-4745-b7dc-a7bb0e6cdb3d\files\crr-tsmv-migration3-parent-routes\diff.json
```

## Review in VS Code

Open the normalized Swagger files directly in the VS Code diff editor:

```powershell
code --diff `
  "C:\Users\bharatpurwar\.copilot\session-state\c4642ed0-362a-4745-b7dc-a7bb0e6cdb3d\files\crr-tsmv-migration3-parent-routes\oldNormalizedSwagger.json" `
  "C:\Users\bharatpurwar\.copilot\session-state\c4642ed0-362a-4745-b7dc-a7bb0e6cdb3d\files\crr-tsmv-migration3-parent-routes\newNormalizedSwagger.json"
```

Alternatively, open the comparison folder:

```powershell
code "C:\Users\bharatpurwar\.copilot\session-state\c4642ed0-362a-4745-b7dc-a7bb0e6cdb3d\files\crr-tsmv-migration3-parent-routes"
```

In VS Code:

1. Select `oldNormalizedSwagger.json`.
2. Ctrl-select `newNormalizedSwagger.json`.
3. Right-click and select **Compare Selected**.

## Resolved path differences

The first comparison found eight changed paths.

### Incorrectly added generated paths

The converted TypeSpec omitted the original parent-resource hierarchy and
generated these shortened paths:

```text
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/backupstorageconfig/vaultstorageconfig
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/recoveryPoints
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/recoveryPoints/{recoveryPointId}
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/recoveryPoints/{recoveryPointId}/accessToken
```

### Original paths missing from generated Swagger

```text
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/accessToken
```

### Resolution

The converted models did not describe the historical ARM parent-resource
hierarchy, so the ARM operation templates treated storage configuration and
recovery points as direct resource-group children.

`VirtualResource.tsp` now defines the routing-only hierarchy:

```text
VaultResource
  -> BackupFabricResource
    -> ProtectionContainerResource
      -> ProtectedItemVirtualResource
```

The resources are attached to the correct parents:

```tsp
@parentResource(VaultResource)
model BackupResourceConfigResource ...

@parentResource(ProtectedItemVirtualResource)
model RecoveryPointResource ...
```

The standard ARM operation templates now generate the full parent hierarchy.

ARM auto-routing removes a trailing slash, while the existing
`RecoveryPointsCrr_List` contract ends with `/recoveryPoints/`. That operation
therefore uses one explicit static route to preserve the exact historical URL.

The latest comparison reports no added, deleted, or changed paths.

The four-level recovery-point hierarchy produces the visible
`beyond-nesting-levels` warning. No new suppression was added.

## Operation differences

### Routes and parameters

- The resource hierarchy, path parameters, and list trailing slash are now
  preserved.
- Some request-body parameter names changed from `parameters` to `body`.

### Tags and descriptions

- Several provider-level operations lost their original tags.
- Resource operations use generated interface tags instead of their historical
  tags.
- `RecoveryPoints_GetAccessToken` lost its original summary.

### Paging

Paging metadata is missing from:

```text
BackupUsageSummariesCRR_List
BackupCrrJobs_List
RecoveryPointsCrr_List
BackupProtectedItemsCrr_List
```

### Responses

- Default responses use ARM common-types `ErrorResponse` instead of the local
  `NewErrorResponse`.
- `CrossRegionRestore_Trigger` changed from `200`, `202`, and `default` to
  `202`, `204`, and `default`.
- `RecoveryPoints_GetAccessToken` lost its `400` response.

## Model differences

- `BackupResourceConfigResource` and `RecoveryPointResource` gained
  `systemData`.
- Their base `Resource` reference changed from the local model to ARM common
  types.
- Some discriminator properties became required.
- Some discriminator base definitions and legacy models changed or disappeared.
- The generated service title changed from `RecoveryServicesBackupClient` to
  `Recovery Services Backup Passive Client`.

## Current conclusion

The converter output compiles and now preserves all original paths. It is not
yet fully equivalent because tag, paging, response, discriminator, resource
envelope, and service-title differences remain.
