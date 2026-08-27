# DevCompute API Signatures

Version labels:

- **All**: Supported in both `2026-08-01-preview` and `2026-09-01`.
- **Preview only**: Supported only in `2026-08-01-preview`.
- **Stable+**: Supported starting with `2026-09-01`.
- **LRO**: Long-running operation.

There are currently **94 operation declarations**. After applying version conditions:

- `2026-08-01-preview`: 90 available APIs.
- `2026-09-01`: 84 available APIs.

## Sandboxes CRUD

| Operation | Method | Path                     | Version |
| --------- | ------ | ------------------------ | ------- |
| `list`    | GET    | `{scope}/sandboxes`      | All     |
| `create`  | PUT    | `{scope}/sandboxes`      | All     |
| `get`     | GET    | `{scope}/sandboxes/{id}` | All     |
| `delete`  | DELETE | `{scope}/sandboxes/{id}` | All     |

Additional path parameters: `id: string`.

## Sandbox Lifecycle

| Operation                           | Method | Path                                          | Version      |
| ----------------------------------- | ------ | --------------------------------------------- | ------------ |
| `getSandboxesCount`                 | GET    | `{scope}/sandboxes/count`                     | All          |
| `getSandboxesStats`                 | GET    | `{scope}/sandboxes/{id}/stats`                | All          |
| `postSandboxesDisable`              | POST   | `{scope}/sandboxes/{id}/disable`              | All          |
| `postSandboxesEnable`               | POST   | `{scope}/sandboxes/{id}/enable`               | All          |
| `postSandboxesExecuteCommand`       | POST   | `{scope}/sandboxes/{id}/executeCommand`       | All          |
| `postSandboxesExecuteShellCommand`  | POST   | `{scope}/sandboxes/{id}/executeShellCommand`  | All          |
| `postSandboxesGenerateSandboxToken` | POST   | `{scope}/sandboxes/{id}/generateSandboxToken` | Preview only |
| `postSandboxesLifecycle`            | POST   | `{scope}/sandboxes/{id}/lifecycle`            | All          |
| `postSandboxesResume`               | POST   | `{scope}/sandboxes/{id}/resume`               | All          |
| `postSandboxesStop`                 | POST   | `{scope}/sandboxes/{id}/stop`                 | All          |
| `postSandboxesStopAsync`            | POST   | `{scope}/sandboxes/{id}/stop/async`           | All          |
| `putSandboxesBatch`                 | PUT    | `{scope}/sandboxes/batch`                     | Preview only |

Additional path parameters: `id: string` where present.

## Sandbox Storage

| Operation                             | Method | Path                                            | Version      |
| ------------------------------------- | ------ | ----------------------------------------------- | ------------ |
| `postSandboxesCommit`                 | POST   | `{scope}/sandboxes/{id}/commit`                 | All          |
| `postSandboxesDownloadContentPackage` | POST   | `{scope}/sandboxes/{id}/downloadContentPackage` | All          |
| `postSandboxesPodVolumesAdd`          | POST   | `{scope}/sandboxes/{id}/pod-volumes/add`        | Preview only |
| `postSandboxesPodVolumesAdd2`         | POST   | `{scope}/sandboxes/{id}/podVolumes/add`         | Stable+      |
| `postSandboxesSnapshot`               | POST   | `{scope}/sandboxes/{id}/snapshot`               | All          |
| `postSandboxesVolumesAdd`             | POST   | `{scope}/sandboxes/{id}/volumes/add`            | All          |

Additional path parameters: `id: string`.

## Sandbox Networking

| Operation                      | Method | Path                                      | Version      |
| ------------------------------ | ------ | ----------------------------------------- | ------------ |
| `getSandboxesEgressDecisions`  | GET    | `{scope}/sandboxes/{id}/egress-decisions` | Preview only |
| `getSandboxesEgressDecisions2` | GET    | `{scope}/sandboxes/{id}/egressDecisions`  | Stable+      |
| `getSandboxesPorts`            | GET    | `{scope}/sandboxes/{id}/ports`            | All          |
| `patchSandboxesPorts`          | PATCH  | `{scope}/sandboxes/{id}/ports`            | All          |
| `postSandboxesConnectionsAdd`  | POST   | `{scope}/sandboxes/{id}/connections/add`  | All          |
| `postSandboxesEgresspolicy`    | POST   | `{scope}/sandboxes/{id}/egresspolicy`     | All          |
| `postSandboxesPortsAdd`        | POST   | `{scope}/sandboxes/{id}/ports/add`        | All          |
| `postSandboxesPortsRemove`     | POST   | `{scope}/sandboxes/{id}/ports/remove`     | All          |
| `putSandboxesPorts`            | PUT    | `{scope}/sandboxes/{id}/ports`            | All          |

Additional path parameters: `id: string`.

## Sandbox Files

| Operation                 | Method | Path                                 | Version |
| ------------------------- | ------ | ------------------------------------ | ------- |
| `deleteSandboxesFiles`    | DELETE | `{scope}/sandboxes/{id}/files`       | All     |
| `getSandboxesFiles`       | GET    | `{scope}/sandboxes/{id}/files`       | All     |
| `getSandboxesFilesList`   | GET    | `{scope}/sandboxes/{id}/files/list`  | All     |
| `getSandboxesFilesStat`   | GET    | `{scope}/sandboxes/{id}/files/stat`  | All     |
| `postSandboxesFilesMkdir` | POST   | `{scope}/sandboxes/{id}/files/mkdir` | All     |
| `putSandboxesFiles`       | PUT    | `{scope}/sandboxes/{id}/files`       | All     |

Additional path parameters: `id: string`.

## Sandbox WebSocket Streams

| Operation                     | Method | Path                                      | Version |
| ----------------------------- | ------ | ----------------------------------------- | ------- |
| `getSandboxesExecStream`      | GET    | `{scope}/sandboxes/{id}/exec/stream`      | All     |
| `getSandboxesLogstream`       | GET    | `{scope}/sandboxes/{id}/logstream`        | All     |
| `getSandboxesProcessesStream` | GET    | `{scope}/sandboxes/{id}/processes/stream` | All     |

Additional path parameters: `id: string`.

## Connections

| Operation                    | Method | Path                                   | Version |
| ---------------------------- | ------ | -------------------------------------- | ------- |
| `deleteConnections`          | DELETE | `{scope}/connections/{id}`             | All     |
| `listConnections`            | GET    | `{scope}/connections`                  | All     |
| `getConnections`             | GET    | `{scope}/connections/{id}`             | All     |
| `postConnections`            | POST   | `{scope}/connections`                  | All     |
| `postConnectionsAuthorize`   | POST   | `{scope}/connections/{id}/authorize`   | All     |
| `postConnectionsConsentLink` | POST   | `{scope}/connections/{id}/consentLink` | All     |
| `postConnectionsRefresh`     | POST   | `{scope}/connections/{id}/refresh`     | All     |
| `putConnectionsPolicyRules`  | PUT    | `{scope}/connections/{id}/policyRules` | All     |

Additional path parameters: `id: string` where present.

## Credentials

| Operation           | Method | Path                                   | Version |
| ------------------- | ------ | -------------------------------------- | ------- |
| `deleteCredentials` | DELETE | `{scope}/credentials/{credentialName}` | All     |
| `listCredentials`   | GET    | `{scope}/credentials`                  | All     |
| `getCredentials`    | GET    | `{scope}/credentials/{credentialName}` | All     |
| `putCredentials`    | PUT    | `{scope}/credentials/{credentialName}` | All     |

Additional path parameters: `credentialName: string`.

## Secrets

| Operation         | Method | Path                              | Version |
| ----------------- | ------ | --------------------------------- | ------- |
| `deleteSecrets`   | DELETE | `{scope}/secrets/{secretId}`      | All     |
| `getSecrets`      | GET    | `{scope}/secrets`                 | All     |
| `getSecretsKeys`  | GET    | `{scope}/secrets/{secretId}/keys` | All     |
| `postSecretsPeek` | POST   | `{scope}/secrets/{secretId}/peek` | All     |
| `putSecrets`      | PUT    | `{scope}/secrets/{secretId}`      | All     |

Additional path parameters: `secretId: string`.

## Egress Policies

| Operation              | Method | Path                                | Version |
| ---------------------- | ------ | ----------------------------------- | ------- |
| `deleteEgressPolicies` | DELETE | `{scope}/egressPolicies/{policyId}` | All     |
| `listEgressPolicies`   | GET    | `{scope}/egressPolicies`            | All     |
| `getEgressPolicies`    | GET    | `{scope}/egressPolicies/{policyId}` | All     |
| `putEgressPolicies`    | PUT    | `{scope}/egressPolicies/{policyId}` | All     |

Additional path parameters: `policyId: string`.

## Content Packages

| Operation                   | Method | Path                             | Version |
| --------------------------- | ------ | -------------------------------- | ------- |
| `deleteContentpackages`     | DELETE | `{scope}/contentpackages/{id}`   | All     |
| `listContentpackages`       | GET    | `{scope}/contentpackages`        | All     |
| `getContentpackages`        | GET    | `{scope}/contentpackages/{id}`   | All     |
| `postContentpackagesUpload` | POST   | `{scope}/contentpackages/upload` | All     |

Additional path parameters: `id: string` where present.

## Disk Images

| Operation                       | Method | Path                                          | Version           |
| ------------------------------- | ------ | --------------------------------------------- | ----------------- |
| `deleteDiskimages`              | DELETE | `{scope}/diskimages/{id}`                     | All               |
| `listDiskimages`                | GET    | `{scope}/diskimages`                          | All               |
| `getDiskimagesOperations`       | GET    | `{scope}/diskimages/operations/{operationId}` | All               |
| `listDiskimagesPublic`          | GET    | `{scope}/diskimages/public`                   | All               |
| `getDiskimagesPublic`           | GET    | `{scope}/diskimages/public/{name}`            | All               |
| `getDiskimages`                 | GET    | `{scope}/diskimages/{id}`                     | All               |
| `postDiskimagesDockerfile`      | POST   | `{scope}/diskimages/dockerfile`               | Preview only      |
| `postDiskimagesDockerfileAsync` | POST   | `{scope}/diskimages/dockerfile/async`         | Preview only, LRO |
| `putDiskimagesPreview`          | PUT    | `{scope}/diskimages`                          | Preview only      |
| `putDiskimages`                 | PUT    | `{scope}/diskimages`                          | Stable+           |
| `putDiskimagesAsyncPreview`     | PUT    | `{scope}/diskimages/async`                    | Preview only, LRO |
| `putDiskimagesAsync`            | PUT    | `{scope}/diskimages/async`                    | Stable+, LRO      |
| `putDiskimagesV2`               | PUT    | `{scope}/diskimages/v2`                       | Preview only      |
| `putDiskimagesV2Async`          | PUT    | `{scope}/diskimages/v2/async`                 | Preview only, LRO |

## Snapshots


| Operation           | Method | Path                      | Version |
| ------------------- | ------ | ------------------------- | ------- |
| `deleteSnapshots`   | DELETE | `{scope}/snapshots/{id}`  | All     |
| `listSnapshots`     | GET    | `{scope}/snapshots`       | All     |
| `getSnapshotsCount` | GET    | `{scope}/snapshots/count` | All     |
| `getSnapshots`      | GET    | `{scope}/snapshots/{id}`  | All     |

Additional path parameters: `id: string`.

## Volumes

| Operation                 | Method | Path                                          | Version |
| ------------------------- | ------ | --------------------------------------------- | ------- |
| `deleteVolumes`           | DELETE | `{scope}/volumes/{volumeName}`                | All     |
| `deleteVolumesFiles`      | DELETE | `{scope}/volumes/{volumeName}/files`          | All     |
| `listVolumes`             | GET    | `{scope}/volumes`                             | All     |
| `getVolumesCount`         | GET    | `{scope}/volumes/count`                       | All     |
| `getVolumes`              | GET    | `{scope}/volumes/{volumeName}`                | All     |
| `getVolumesFiles`         | GET    | `{scope}/volumes/{volumeName}/files`          | All     |
| `getVolumesFilesDownload` | GET    | `{scope}/volumes/{volumeName}/files/download` | All     |
| `postVolumesFilesMkdir`   | POST   | `{scope}/volumes/{volumeName}/files/mkdir`    | All     |
| `postVolumesFork`         | POST   | `{scope}/volumes/{volumeName}/fork`           | All     |
| `putVolumes`              | PUT    | `{scope}/volumes/{volumeName}`                | All     |
| `putVolumesFilesUpload`   | PUT    | `{scope}/volumes/{volumeName}/files/upload`   | All     |

