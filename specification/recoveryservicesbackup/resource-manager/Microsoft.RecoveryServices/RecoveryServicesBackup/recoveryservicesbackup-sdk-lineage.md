# Recovery Services Backup SDK Lineage

This document explains how Active Stamp and Passive Stamp/CRR were generated and consumed before the
TypeSpec migration, what changed during the Python SDK package split, and why Azure CLI cannot move
directly from `azure-mgmt-recoveryservicesbackup` 9.2.0 to 11.0.0 without code and dependency changes.

## Executive summary

The historical Python SDK behavior came from an AutoRest **multi-API batch configuration**, not from
a TypeSpec service group.

Before the package split:

```text
One PyPI distribution:
azure-mgmt-recoveryservicesbackup

Python modules inside that distribution:
azure.mgmt.recoveryservicesbackup.activestamp
azure.mgmt.recoveryservicesbackup.passivestamp
```

After the package split:

```text
Distribution 1:
azure-mgmt-recoveryservicesbackup
└── azure.mgmt.recoveryservicesbackup
    └── RecoveryServicesBackupClient

Distribution 2:
azure-mgmt-recoveryservicesbackup-passivestamp
└── azure.mgmt.recoveryservicesbackup.passivestamp
    └── RecoveryServicesBackupPassiveClient
```

The Passive Stamp import namespace was preserved, but it moved into a separately installed Python
distribution. The Active Stamp client moved from `.activestamp` to the package root.

The package split was explicitly configured by
[azure-rest-api-specs PR #37845](https://github.com/Azure/azure-rest-api-specs/pull/37845).
It was not an automatic result of
[the TypeSpec migration PR #35709](https://github.com/Azure/azure-rest-api-specs/pull/35709).

## Source map

| Subject | Source |
|---|---|
| Active Backup TypeSpec migration | [azure-rest-api-specs PR #35709](https://github.com/Azure/azure-rest-api-specs/pull/35709) |
| Python generation package split | [azure-rest-api-specs PR #37845](https://github.com/Azure/azure-rest-api-specs/pull/37845) |
| Passive package initial release | [azure-sdk-for-python PR #43412](https://github.com/Azure/azure-sdk-for-python/pull/43412) |
| Active SDK 10.0.0 generation | [azure-sdk-for-python PR #43460](https://github.com/Azure/azure-sdk-for-python/pull/43460) |
| First 11.x TypeSpec generation | [azure-sdk-for-python PR #45080](https://github.com/Azure/azure-sdk-for-python/pull/45080) |
| Stable active SDK 11.0.0 generation | [azure-sdk-for-python PR #48574](https://github.com/Azure/azure-sdk-for-python/pull/48574) |
| Vault SDK PR, not Backup SDK | [azure-sdk-for-python PR #48569](https://github.com/Azure/azure-sdk-for-python/pull/48569) |
| Azure CLI CRR work | [azure-cli PR #33809](https://github.com/Azure/azure-cli/pull/33809) |
| Active SDK changelog | [`azure-mgmt-recoveryservicesbackup/CHANGELOG.md`](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup/CHANGELOG.md) |
| Passive SDK changelog | [`azure-mgmt-recoveryservicesbackup-passivestamp/CHANGELOG.md`](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup-passivestamp/CHANGELOG.md) |

## Timeline

### Before 4.0.0: one flat namespace

Before SDK 4.0.0, Recovery Services Backup used the flat namespace:

```python
azure.mgmt.recoveryservicesbackup
```

The [4.0.0 changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup/CHANGELOG.md)
records the breaking change on 2021-12-21:

> namespace splitted from `azure.mgmt.recoveryservicesbackup` to
> `azure.mgmt.recoveryservicesbackup.activestamp` and
> `azure.mgmt.recoveryservicesbackup.passivestamp`

**Confidence: HIGH.** This is stated directly in the released SDK changelog.

### 4.0.0 through 9.2.0: one distribution containing two generated clients

The old `readme.python.md` used an AutoRest batch:

```yaml
clear-output-folder: true
batch:
  - tag: package-passivestamp-2021-11-15
  - tag: package-2025-02-01
```

Each batch entry wrote into a different subdirectory of the same SDK package:

```yaml
$(tag) == 'package-passivestamp-2021-11-15':
  namespace: azure.mgmt.recoveryservicesbackup.passivestamp
  output-folder: .../azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup/passivestamp

$(tag) == 'package-2025-02-01':
  namespace: azure.mgmt.recoveryservicesbackup.activestamp
  output-folder: .../azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup/activestamp
```

Historical source:

[`readme.python.md` immediately before PR #37845](https://github.com/Azure/azure-rest-api-specs/blob/ca9d05ed67fe556197b01fe795e80e4e2dc41e86/specification/recoveryservicesbackup/resource-manager/readme.python.md)

The 9.2.0 SDK repository tree confirms that the one distribution contained both directories:

```text
azure/mgmt/recoveryservicesbackup/
├── activestamp/
├── passivestamp/
├── __init__.py
└── _version.py
```

Historical source:

[`azure-mgmt-recoveryservicesbackup` 9.2.0 namespace tree](https://github.com/Azure/azure-sdk-for-python/tree/azure-mgmt-recoveryservicesbackup_9.2.0/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup)

Its root `__init__.py` re-exported both clients:

```python
from .activestamp import RecoveryServicesBackupClient
from .passivestamp import RecoveryServicesBackupPassiveClient
```

Historical source:

[`__init__.py` in SDK 9.2.0](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-recoveryservicesbackup_9.2.0/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup/__init__.py)

The distribution's `setup.py` used `find_packages()`, so both subpackages were included in the
`azure-mgmt-recoveryservicesbackup` wheel.

Historical source:

[`setup.py` in SDK 9.2.0](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-recoveryservicesbackup_9.2.0/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup/setup.py)

**Conclusion:** Azure CLI could install one dependency and import both clients because both generated
module trees were physically shipped in one wheel.

**Confidence: HIGH.** The AutoRest configuration, tagged SDK tree, root exports, and package setup all
show the same behavior.

### September 2025: the active specification was migrated to TypeSpec

[PR #35709](https://github.com/Azure/azure-rest-api-specs/pull/35709), merged on 2025-09-23,
introduced the Active Stamp TypeSpec project for API version `2025-02-01`.

It added:

- `main.tsp`;
- active resource TypeSpec files;
- `client.tsp`;
- `tspconfig.yaml`;
- active examples and generated Swagger.

It did **not** migrate the Passive Stamp/CRR surface into TypeSpec. Passive versions remained
represented by Swagger tags such as:

```text
package-passivestamp-2021-11-15
package-passivestamp-2023-01-15
```

Current tag source:

[`RecoveryServicesBackup/readme.md`](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/readme.md)

**Important distinction:** this PR created the active TypeSpec source, but the first Python release
after it was not yet generated by the TypeSpec Python emitter.

**Confidence: HIGH.** The PR file list contains active TypeSpec resources but no CRR TypeSpec project.

### October 2025: Python packaging was intentionally split

[PR #37845](https://github.com/Azure/azure-rest-api-specs/pull/37845), merged on 2025-10-14,
explicitly changed the Python generation configuration.

The PR description records the decision to:

- split `passivestamp` from `azure-mgmt-recoveryservicesbackup`;
- make it an independent package;
- remove the Active Stamp `.activestamp` namespace.

The configuration change removed the batch:

```yaml
batch:
  - tag: package-passivestamp-2021-11-15
  - tag: package-2025-02-01
```

It changed Active Stamp to:

```yaml
package-name: azure-mgmt-recoveryservicesbackup
namespace: azure.mgmt.recoveryservicesbackup
output-folder: .../azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup
```

It changed Passive Stamp to:

```yaml
package-name: azure-mgmt-recoveryservicesbackup-passivestamp
namespace: azure.mgmt.recoveryservicesbackup.passivestamp
output-folder: .../azure-mgmt-recoveryservicesbackup-passivestamp/azure/mgmt/recoveryservicesbackup/passivestamp
```

Exact change:

[`readme.python.md` change in commit 1328af4](https://github.com/Azure/azure-rest-api-specs/commit/1328af424628b6828feac43ddfa210a9d6035f9a)

**Conclusion:** the two-distribution design was a deliberate SDK packaging decision. TypeSpec did not
force Python to split the package automatically.

**Confidence: HIGH.** The PR description and configuration diff state this directly.

### October 2025: Passive and Active packages were released separately

#### Passive package

[azure-sdk-for-python PR #43412](https://github.com/Azure/azure-sdk-for-python/pull/43412)
created:

```text
azure-mgmt-recoveryservicesbackup-passivestamp 1.0.0b1
```

Its generated namespace remained:

```python
azure.mgmt.recoveryservicesbackup.passivestamp
```

Its `_metadata.json` shows that it was generated by AutoRest from:

```text
specification/recoveryservicesbackup/resource-manager/readme.md
tag: package-passivestamp-2021-11-15
```

Source:

[`passivestamp/_metadata.json`](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup-passivestamp/_metadata.json)

The separate package includes the required CRR groups, including:

- `aad_properties`;
- `backup_crr_jobs`;
- `backup_crr_job_details`;
- `backup_protected_items_crr`;
- `cross_region_restore`;
- `crr_operation_results`;
- `crr_operation_status`;
- `recovery_points_crr`.

Source:

[Files added by PR #43412](https://github.com/Azure/azure-sdk-for-python/pull/43412/files)

#### Active package 10.0.0

[azure-sdk-for-python PR #43460](https://github.com/Azure/azure-sdk-for-python/pull/43460)
generated `azure-mgmt-recoveryservicesbackup` 10.0.0.

Its generation metadata says:

```text
AutoRest configuration:
specification/recoveryservicesbackup/resource-manager/readme.md

API version:
2025-02-01
```

Therefore, SDK 10.0.0 was still generated through AutoRest from the emitted/readme-selected Swagger,
not directly through `tspconfig.yaml`.

The 10.0.0 changelog gives the consumer migration:

```text
Split module "passivestamp" into independent package
azure-mgmt-recoveryservicesbackup-passivestamp.
Just add it as a dependency then no other code changes required.

Removed sub-namespace "activestamp".
Update:
from azure.mgmt.recoveryservicesbackup.activestamp import XXX

to:
from azure.mgmt.recoveryservicesbackup import XXX
```

Source:

[`azure-mgmt-recoveryservicesbackup/CHANGELOG.md`](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup/CHANGELOG.md)

**Confidence: HIGH.** The active PR metadata and released changelog both state the behavior.

### 2026: the active Python SDK began direct TypeSpec generation

[PR #45080](https://github.com/Azure/azure-sdk-for-python/pull/45080) is the first located 11.x
generation PR that identifies this TypeSpec configuration:

```text
specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup/tspconfig.yaml
```

Subsequent 11.x generations continued to use this active TypeSpec project. The stable 11.0.0 release
was generated in [PR #48574](https://github.com/Azure/azure-sdk-for-python/pull/48574) for API version
`2026-07-01`.

The stable package metadata records:

```json
{
  "apiVersion": "2026-07-01",
  "typespec_src": "specification/recoveryservicesbackup/resource-manager/Microsoft.RecoveryServices/RecoveryServicesBackup"
}
```

Source:

[`azure-mgmt-recoveryservicesbackup/_metadata.json`](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup/_metadata.json)

Because that TypeSpec project contains only the Active Stamp surface, SDK 11 contains only Active
Stamp operations.

**Confidence: HIGH.** The generation PR and metadata point to the active-only TypeSpec root.

### PR #48569 is not the Backup SDK

[azure-sdk-for-python PR #48569](https://github.com/Azure/azure-sdk-for-python/pull/48569)
generated:

```text
sdk/recoveryservices/azure-mgmt-recoveryservices
```

That package manages Recovery Services vault resources. It is not:

```text
sdk/recoveryservices/azure-mgmt-recoveryservicesbackup
```

The matching stable Backup SDK PR is
[PR #48574](https://github.com/Azure/azure-sdk-for-python/pull/48574).

**Confidence: HIGH.** The two PR file lists and generation configurations identify different
packages.

## Why Azure CLI currently works with 9.2.0

Azure CLI `dev` currently pins:

```python
azure-mgmt-recoveryservicesbackup~=9.2.0
```

Source:

[`src/azure-cli/setup.py`](https://github.com/Azure/azure-cli/blob/dev/src/azure-cli/setup.py)

Its Backup client factories import:

```python
from azure.mgmt.recoveryservicesbackup.activestamp import RecoveryServicesBackupClient
from azure.mgmt.recoveryservicesbackup.passivestamp import RecoveryServicesBackupPassiveClient
```

Source:

[`backup/_client_factory.py`](https://github.com/Azure/azure-cli/blob/dev/src/azure-cli/azure/cli/command_modules/backup/_client_factory.py)

Those imports match the 9.2.0 wheel exactly.

[Azure CLI PR #33809](https://github.com/Azure/azure-cli/pull/33809) adds AFS CRR functionality using
the existing Passive Stamp model namespace:

```python
from azure.mgmt.recoveryservicesbackup.passivestamp.models import CrossRegionRestoreRequest
```

It also retains the old Active Stamp import:

```python
from azure.mgmt.recoveryservicesbackup.activestamp import RecoveryServicesBackupClient
```

This works with 9.2.0 because one installed distribution provides both subpackages.

**Confidence: HIGH.** The dependency pin, current client factories, and PR patch all agree.

## Why installing SDK 11 alone breaks Azure CLI

SDK 11 provides:

```python
from azure.mgmt.recoveryservicesbackup import RecoveryServicesBackupClient
```

It does not provide:

```python
azure.mgmt.recoveryservicesbackup.activestamp
azure.mgmt.recoveryservicesbackup.passivestamp
```

The Passive Stamp namespace is supplied only when this additional distribution is installed:

```text
azure-mgmt-recoveryservicesbackup-passivestamp
```

Therefore adopting current packages requires at least:

```python
# Active import changes
from azure.mgmt.recoveryservicesbackup import RecoveryServicesBackupClient

# Passive import remains the same
from azure.mgmt.recoveryservicesbackup.passivestamp import RecoveryServicesBackupPassiveClient
```

and both dependencies:

```text
azure-mgmt-recoveryservicesbackup
azure-mgmt-recoveryservicesbackup-passivestamp
```

Active SDK 11 also has generated behavioral changes such as LRO poller methods and keyword-only
parameters, so Azure CLI needs more than import replacement.

**Confidence: HIGH** for package/import requirements. **Confidence: MEDIUM** for the full size of the
active CLI migration until every operation used by the Backup command module is mapped and tested.

## What this means for the CRR TypeSpec migration

### Fact: the published Python contract is currently two distributions

The current supported package design is:

| Surface | Distribution | Python namespace |
|---|---|---|
| Active Stamp | `azure-mgmt-recoveryservicesbackup` | `azure.mgmt.recoveryservicesbackup` |
| Passive Stamp/CRR | `azure-mgmt-recoveryservicesbackup-passivestamp` | `azure.mgmt.recoveryservicesbackup.passivestamp` |

The lowest-risk CRR migration preserves this contract:

1. Keep Active and CRR as independently compilable TypeSpec services.
2. Keep the active emitter output unchanged.
3. Configure the CRR TypeSpec Python emitter to generate:

   ```yaml
   emitter-output-dir: "{output-dir}/sdk/recoveryservices/azure-mgmt-recoveryservicesbackup-passivestamp"
   namespace: "azure.mgmt.recoveryservicesbackup.passivestamp"
   ```

4. Regenerate the existing Passive Stamp distribution from TypeSpec instead of Swagger.
5. Update Azure CLI to use Active SDK 11 plus the Passive Stamp dependency.

This preserves the Passive Stamp imports already used by Azure CLI PR #33809.

### Inference: a Network-style outer client is not required to preserve the current package contract

The Network outer `client.tsp` combines multiple TypeSpec services into one generated SDK surface.
That is useful when the desired contract is one package/client assembled from multiple independently
modeled services.

Recovery Services Backup already has a different published contract: two distributions sharing part
of a Python namespace.

An outer `client.tsp` with `autoMergeService` could potentially place Active and CRR operation groups
in one generated package, but it would not, by itself, reproduce:

```python
azure.mgmt.recoveryservicesbackup.activestamp
azure.mgmt.recoveryservicesbackup.passivestamp
```

The old subpackage layout came from two separate AutoRest generation outputs. It was not created by a
merged client decorator.

**Confidence: MEDIUM-HIGH.** This follows from the historical batch configuration and the Network
client pattern. A proof-of-concept generation would still be required to establish every emitter
behavior.

## Available design choices

### Option 1: preserve the current two-package design

```text
Active TypeSpec project
→ azure-mgmt-recoveryservicesbackup
→ azure.mgmt.recoveryservicesbackup

CRR TypeSpec project
→ azure-mgmt-recoveryservicesbackup-passivestamp
→ azure.mgmt.recoveryservicesbackup.passivestamp
```

Advantages:

- matches the published 10.x/11.x package contract;
- preserves Passive Stamp import paths;
- allows Active and CRR to version independently;
- avoids merging incompatible API-version timelines;
- requires no Network-style outer SDK aggregator.

Cost:

- Azure CLI must add the Passive Stamp dependency;
- Azure CLI must migrate Active Stamp imports and changed SDK 11 operations.

### Option 2: recreate the old one-wheel, two-subpackage design

This would try to reproduce the 9.2.0 layout:

```text
azure-mgmt-recoveryservicesbackup wheel
├── azure.mgmt.recoveryservicesbackup.activestamp
└── azure.mgmt.recoveryservicesbackup.passivestamp
```

This is not the current SDK contract. It would reverse the explicit decision in PR #37845 and the
10.0.0 changelog. It would likely require multiple generation outputs, packaging customization, or
emitter support beyond a normal `autoMergeService` client.

### Option 3: combine Active and CRR into one flattened client package

A Network-style aggregation could target:

```python
azure.mgmt.recoveryservicesbackup.RecoveryServicesBackupClient
```

with both Active and CRR operation groups.

Advantages:

- one dependency;
- all operations generated from TypeSpec.

Costs and risks:

- breaks both old Active and Passive client import patterns;
- may merge two independently versioned surfaces into one SDK release contract;
- requires collision review for models and operation groups;
- requires broader Azure CLI migration;
- differs from the package split already approved and released.

## Recommended direction

Unless the Python SDK owners explicitly want to reverse the 2025 package split, implement CRR as a
separate TypeSpec service that generates the existing:

```text
azure-mgmt-recoveryservicesbackup-passivestamp
```

distribution and:

```python
azure.mgmt.recoveryservicesbackup.passivestamp
```

namespace.

Then update Azure CLI to:

1. depend on both Active and Passive distributions;
2. move Active imports to the root namespace;
3. retain Passive imports;
4. adapt Active SDK 11 operation calls;
5. test all existing Backup commands plus PR #33809 CRR scenarios.

This keeps the CRR TypeSpec migration focused on replacing the passive Swagger generation without
also redesigning an SDK package contract that was intentionally split in 2025.

## Open questions

1. Should the migrated CRR SDK target `2023-01-15` first for compatibility, or introduce
   `2026-07-15` directly?
2. Does the Python SDK team want the Passive Stamp package to remain beta after TypeSpec migration?
3. Should CRR TypeSpec preserve the existing `RecoveryServicesBackupPassiveClient` class name?
4. Which other language SDKs historically combined or separated Active and Passive surfaces?
5. Are there model-name collisions that prevent future aggregation even if Python owners request one
   package?

These questions require SDK owner decisions or generation proof-of-concepts; they are not answered by
the existing repository history.
