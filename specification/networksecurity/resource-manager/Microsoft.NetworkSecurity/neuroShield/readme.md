# Microsoft.NetworkSecurity NeuroShield

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.NetworkSecurity NeuroShield management service.

## TypeSpec

This project defines `2026-10-01-preview`. Edit the TypeSpec source and examples
under `examples/2026-10-01-preview`, then regenerate the OpenAPI and mirrored
examples from this directory:

```text
pnpm exec tsp compile . --warn-as-error
```

Commit the generated files under `preview/2026-10-01-preview` together with the
source changes. Do not edit the generated OpenAPI directly.

### Service-generated resource availability

The October contract includes optional, read-only `properties.provisioningState`
on findings, mitigations, and the computed summary. A successfully materialized
resource reports `Succeeded`. This state is independent of finding operational
status and mitigation execution or rollback status: a queued or failed mitigation
can still have provisioning state `Succeeded`. Each resource returned by a list
or action carries the field inside its own `properties`, not on the list wrapper.
Errors remain errors rather than successful resource responses.

This schema change requires the corresponding resource-provider response change
and matching private specification alignment before deployment. Those changes
are not completed or deployed by this public specification update. Runtime
verification through Azure Resource Manager and ARM/RPaaS reviewer confirmation
remain required. The June API contract is unchanged.

### Mitigation recommendation rank

The public October contract exposes read-only `properties.rank` instead of
`properties.score`. Rank is an integer starting at 1, without the former score limit of 100:
1 is the highest relative recommendation priority, followed by 2, 3, and so on
within the same finding. It is not a confidence measure or a guarantee of safety,
completeness, or successful execution.

The service computes consecutive ranks over all sibling mitigations before
pagination, filtering, or action eligibility is applied. Ties are broken by
ordinal mitigation resource name. GET, nested and aggregate lists, and
resource-returning actions report the same rank for unchanged sibling priorities
and membership; they do not renumber the returned subset. Ranks can change when
those priorities or membership change.

This is an intentional public-contract change from the private source, not a
claim of exact source equality. Runtime compatibility, paired private-specification
alignment, and deployment verification are separate rollout requirements. This
public change does not remove internal scores or alter mitigation execution order.

## Getting Started

### Shared NetworkSecurity SDK packages

The language options in the [provider-level SDK configuration](../tspconfig.yaml)
target these shared package identities:

| Language              | Package                                                                                    | Namespace                                   |
| --------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------- |
| .NET                  | `Azure.ResourceManager.NetworkSecurity`                                                    | `Azure.ResourceManager.NetworkSecurity`     |
| Python                | `azure-mgmt-networksecurity`                                                               | `azure.mgmt.networksecurity`                |
| Java                  | `com.azure.resourcemanager:azure-resourcemanager-networksecurity`                          | `com.azure.resourcemanager.networksecurity` |
| JavaScript/TypeScript | `@azure/arm-networksecurity`                                                               | Not applicable                              |
| Go                    | `github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/networksecurity/armnetworksecurity` | `armnetworksecurity`                        |

For SDK generation, select
`specification/networksecurity/resource-manager/Microsoft.NetworkSecurity/tspconfig.yaml`.
The [parent SDK entry point](../client.tsp) imports only `./neuroShield/main.tsp`
as its public service input and explicitly composes the shared
`NetworkSecurityManagementClient`. It retains all seven NeuroShield operation
groups and the C# operation-name disambiguation.

This child project's `main.tsp`, `tspconfig.yaml`, and `service.yaml` remain
responsible for REST/Swagger generation and version discovery. The child has no
SDK emitter options or `client.tsp` and does not import the parent SDK input.
The parent has no REST emitter or separate service manifest. This keeps one
canonical SDK generation input without an import cycle or duplicate package
writers. The SDK composition does not change routes, API versions, wire models,
operation IDs, paging parameters, or provisioning-state semantics.

The parent [validation exceptions](../suppressions.yaml) cover only the SDK-only
provider folder's layout and this REST-only child's absent SDK options, following
the Network convention. They do not suppress API-model lint rules.

Outputs are rooted at `sdk/networksecurity`, with a package-specific subdirectory
for each language. Go instead uses
`sdk/resourcemanager/networksecurity/armnetworksecurity`. Run the selected SDK
repository's standard generation, build, and validation workflow using this
configuration; the TypeSpec compile command above regenerates OpenAPI, not SDKs.

For SDK emitters that support `examples-dir`, the parent configuration points to
`{project-root}/neuroShield/examples`. The source examples remain in this child
project. Recheck each emitter's version-aware example discovery when another
public service joins; do not reuse this single-service path without validation.

### NeuroShield SDK surface

The shared package does not require identical client hierarchies in every
language. NeuroShield is distinguished by these generated surfaces:

| Language              | Client organization                                                                                                                                  | Models                                                                                                 |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| .NET                  | `NeuroShieldResource`, `NeuroShieldProtectedResource`, and the other NeuroShield resources/collections under `Azure.ResourceManager.NetworkSecurity` | Resource data in the package namespace; other models in `Azure.ResourceManager.NetworkSecurity.Models` |
| Python                | `azure.mgmt.networksecurity.NetworkSecurityManagementClient`, with the asynchronous client in `azure.mgmt.networksecurity.aio`                       | `azure.mgmt.networksecurity.models`; operation groups in `azure.mgmt.networksecurity.operations`       |
| Java                  | `com.azure.resourcemanager.networksecurity.NetworkSecurityManager`, with `NetworkSecurityManagementClient` under `.fluent`                           | NeuroShield models and fluent operation groups under `.models`                                         |
| JavaScript/TypeScript | `NetworkSecurityManagementClient` exported from `@azure/arm-networksecurity`, with NeuroShield operation-group properties                            | NeuroShield models exported from the package root                                                      |
| Go                    | `armnetworksecurity.ClientFactory` creates the six NeuroShield operation clients and `OperationsClient`; each client also has its normal constructor | NeuroShield-prefixed types in `armnetworksecurity`                                                     |

The seven operation groups are `Operations`, `NeuroShieldOperationStatuses`,
`NeuroShields`, `NeuroShieldSummaries`, `NeuroShieldProtectedResources`,
`NeuroShieldFindings`, and `NeuroShieldMitigations`. SDK naming stays in
the parent `client.tsp`; Java's human-readable `service-name` option also controls its
manager name. Do not rename REST declarations to change these SDK names.

The Network Security SDK owners coordinate package versions and releases across
services. Shared package identity does not imply that different service inputs
can be generated independently into the same output directory.

### Adding another public NetworkSecurity service

Two-service generation is not implemented here. Agent Fabric must not be added
until its definitions are authorized for the public generation input. The
[Network SDK client entry point](../../../../network/resource-manager/Microsoft.Network/Network/client.tsp)
imports multiple public services and explicitly combines them with a TypeSpec
client generator core `@client` declaration using a service array and
`autoMergeService`. IPAM is an operation group within the Network package, not a
separate installable package.
That is composition prior art, not evidence that NeuroShield and Agent Fabric
have already been generated together.

Onboard Agent Fabric as a coordinated change with the shared SDK owners:

1. Publish only the authorized Agent Fabric REST input through its own API review.
   Keep NeuroShield's REST entry point and contract unchanged. Do not copy private
   definitions or introduce placeholder service definitions here.
2. Extend the provider-level `../client.tsp` to import the approved public Agent
   Fabric entry point and include its service in the explicit client composition.
   Retain `../tspconfig.yaml` as the single shared-package SDK configuration. Keep
   each child service's REST generation configuration and version manifest separate.
3. Define and validate the client composition explicitly with the supported SDK
   tools. Preserve the existing NeuroShield exports within the shared package.
   Python and TypeScript retain `NetworkSecurityManagementClient` with distinct
   service operation groups; Java exposes the groups through the shared manager.
   Preserve .NET's resource/collection pattern and Go's shared factory with distinct
   operation clients. Verify each emitter's behavior with both services; imports
   alone are insufficient, and service versions and dependencies must be compatible.
4. Resolve collisions before emitting into a shared directory: client names,
   operation groups, model/enum names, generated file names, and exported symbols.
   Review duplicate provider `Operations` APIs explicitly; share one SDK group only
   when the REST operation and version semantics match. Use scoped SDK naming or
   composition customizations, not REST renames, to distinguish service-owned types.
5. Point each SDK repository's `tsp-location.yaml` at the provider-level
   `specification/networksecurity/resource-manager/Microsoft.NetworkSecurity`
   project and an approved spec commit containing both services. Generate once per
   language/package into the output paths above. Never run independent NeuroShield
   and Agent Fabric generation sequentially into the same output directory: the
   second run can overwrite the first service's clients, models, and exports.
6. Validate both services' operation inventories, model exports/imports, API-version
   selection, and dependency compatibility; then build and test all five packages.
   Compare the regenerated REST artifacts and the existing NeuroShield SDK surface
   for unintended changes. Coordinate package versions, releases, and ownership.

Obtain SDK architect approval for package and client names before release.
Package-name reservation is not approval. Combined generation remains unverified
until the authorized Agent Fabric input is included and all language checks pass.

### PowerShell and Azure CLI

Swagger-based PowerShell and Azure CLI tooling can select the AutoRest input and
version tag below. The SDK-only `client.tsp` names do not define PowerShell module
or cmdlet names, or Azure CLI extensions or command groups. Those require their
own approved design and generation configuration in the respective tooling
repositories. PowerShell/CLI generation and tests are not implemented by this
SDK packaging configuration. Do not change REST routes, operation IDs, models,
or `$top`/`$skipToken` solely to choose those names.

### AutoRest input

For tooling that consumes OpenAPI rather than TypeSpec, install AutoRest via
`npm` and use this README's input configuration:

> `autorest readme.md`

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-10-01-preview
```

### Tag: package-2026-10-01-preview

These settings apply when `--tag=package-2026-10-01-preview` is specified.

```yaml $(tag) == 'package-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/neuroShield.json
```
