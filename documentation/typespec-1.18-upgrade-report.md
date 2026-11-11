# TypeSpec 1.18 / TypeSpec Azure 0.74 upgrade assessment

Assessment date: November 11, 2026.

## Result

The upgrade uses published stable packages, preserves the existing API contracts,
and adds 37 declaration-level lint suppressions in 29 TypeSpec files. The only
tracked OpenAPI changes are four Foundry OpenAPI 3.2 files: JSON and YAML for `v1`
and `virtual-public-preview`. Their semantic changes match the emitter-related
changes on `typespec-next`.

No breaking wire-contract change was found in those generated files. Removing a
duplicate schema name remains a compatibility consideration for consumers that
generate SDKs from OpenAPI; this is not a claim that downstream SDKs were tested.
Two compiler failures already present before the upgrade remain documented below.

## Baselines and branch divergence

| Input | Pinned commit |
| --- | --- |
| Upstream `main`, used as the upgrade base | [`82fffb8698c39ec5e579417eadc09cfc0da146fb`](https://github.com/Azure/azure-rest-api-specs/commit/82fffb8698c39ec5e579417eadc09cfc0da146fb) |
| Upstream `typespec-next`, used only for comparison | [`ac2c1811908bc058fc0d648f94748dbcaec378d0`](https://github.com/Azure/azure-rest-api-specs/commit/ac2c1811908bc058fc0d648f94748dbcaec378d0) |
| Their merge base | [`25e6580ed12cabbca57863ab3c2b13b6657dfa0e`](https://github.com/Azure/azure-rest-api-specs/commit/25e6580ed12cabbca57863ab3c2b13b6657dfa0e) |

These branches have diverged: `main` contains 45 commits absent from `typespec-next`,
and `typespec-next` contains 14 commits absent from `main`. Whole generated files
are therefore **not** expected to match. For example, main-only
[Foundry OpenAI 1.35.0 regeneration](https://github.com/Azure/azure-rest-api-specs/commit/eeada48b5a)
must not be replaced by the older Foundry content on `typespec-next`.

The comparison used semantic JSON changes from `main -> upgrade` versus changes
from `merge-base -> typespec-next`. All four changed OpenAPI files have identical
change sets under that comparison, while their complete contents differ. No spec
or generated file was copied wholesale from `typespec-next`.

Every proposed suppression was independently reproduced by compiling the
main-based upgrade. All 37 observed targets also occur in the next-branch
suppression changes; no additional main-only suppression was required in this run.
This conclusion comes from the main-based compiler sweep, not an assumption that
the two branches contain the same specs.

## Dependency changes

Sources: [TypeSpec 1.18 release notes](https://typespec.io/release-notes/typespec-1-18-0/),
[TypeSpec Azure 0.74 release notes](https://tspwebsitepr.z22.web.core.windows.net/typespec-azure/prs/6051/docs/release-notes/release-2026-11-10/),
package changelogs, and each package's published npm `latest` version.

| Packages | Previous | Updated |
| --- | --- | --- |
| `@typespec/compiler`, `http`, `openapi`, `openapi3` | 1.17.0 | 1.18.0 |
| `@typespec/events`, `library-linter`, `rest`, `sse`, `streams`, `versioning`, `xml` | 0.87.0 | 0.88.0 |
| `@azure-tools/typespec-autorest` | 0.73.2 | 0.74.0 |
| `@azure-tools/typespec-azure-core`, `typespec-azure-portal-core`, `typespec-azure-resource-manager` | 0.73.0 | 0.74.0 |
| Published `@azure-tools/typespec-azure-rulesets`, through the existing `typespec-azure-rulesets-original` alias | 0.73.0 | 0.74.0 |
| `@azure-tools/typespec-client-generator-core` | 0.73.1 | 0.74.0 |
| `@azure-tools/typespec-azure-examples` | 0.2.2 | 0.3.0 |
| `@azure-tools/typespec-liftr-base` | 0.13.0 | 0.14.0 |
| `@azure-tools/typespec-metadata` | 0.4.1 | 0.4.2 |
| `@typespec/asset-emitter` override | 0.79.1 | 0.79.3 |

The [central pnpm catalog and override](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/pnpm-workspace.yaml)
and [generated lockfile](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/pnpm-lock.yaml)
contain the changes. The local ruleset wrapper and workspace references are
preserved. Packages already at their latest stable release, including
`@azure-tools/openai-typespec` 1.35.0, APIView, and the client-generator CLI, are
unchanged. No `next` or prerelease version was introduced.

The non-TypeSpec lockfile changes are release-transitive language-server package
updates and removal of dependencies no longer required by the upgraded packages.
There are no unrelated direct dependency upgrades.

## New lint suppressions

All additions use fully qualified `#suppress` directives on the affected operation
or property, with compatibility-specific reasons. No ruleset, warnings-as-errors
setting, or whole-project exclusion was weakened.

| Rule | Targets | Contract preserved and branch evidence |
| --- | --- | --- |
| `@azure-tools/typespec-azure-resource-manager/no-response-body` | 33 | Existing DELETE 200 payloads, plus the AKS POST 202 payload. Examples: [Application Insights](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/applicationinsights/resource-manager/Microsoft.Insights/ApplicationInsights/ComponentAPIs/routes.tsp), [AKS](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/containerservice/resource-manager/Microsoft.ContainerService/aks/AgentPool.tsp), [Search operations](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/search/resource-manager/Microsoft.Search/Search/PrivateEndpointConnection.tsp) and [client override](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/search/resource-manager/Microsoft.Search/Search/client.tsp). |
| `@azure-tools/typespec-azure-core/no-generic-numeric` | 3 | Existing decimal precision in a [Commerce record](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/commerce/resource-manager/Microsoft.Commerce/Commerce/models.tsp), [Consumption query parameter](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/consumption/resource-manager/Microsoft.Consumption/Consumption/routes.tsp), and [Cost Management array](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/cost-management/resource-manager/Microsoft.CostManagement/CostManagement/models.tsp). |
| `@azure-tools/typespec-azure-resource-manager/no-reserved-resource-property` | 1 | Existing [DataBoxEdge `properties.systemData`](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/databoxedge/resource-manager/Microsoft.DataBoxEdge/DataBoxEdge/models.tsp). Moving it into the envelope would change the published response. |

These correspond to the rule fixes described in
[Azure/typespec-azure#5866](https://github.com/Azure/typespec-azure/pull/5866),
[Azure/typespec-azure#5975](https://github.com/Azure/typespec-azure/pull/5975), and
[Azure/typespec-azure#5892](https://github.com/Azure/typespec-azure/pull/5892).
The suppressions require the repository's normal review and approval; successful
compilation does not constitute that approval.

## OpenAPI changes and significance

| Generated output in this branch | Pinned next-branch comparison |
| --- | --- |
| [`v1` JSON](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/openapi3/v1/microsoft-foundry-openapi3.json) / [YAML](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/openapi3/v1/microsoft-foundry-openapi3.yaml) | [`v1` JSON at `ac2c181190`](https://github.com/Azure/azure-rest-api-specs/blob/ac2c1811908bc058fc0d648f94748dbcaec378d0/specification/ai-foundry/data-plane/Foundry/openapi3/v1/microsoft-foundry-openapi3.json) |
| [`virtual-public-preview` JSON](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/openapi3/virtual-public-preview/microsoft-foundry-openapi3.json) / [YAML](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/openapi3/virtual-public-preview/microsoft-foundry-openapi3.yaml) | [Preview JSON at `ac2c181190`](https://github.com/Azure/azure-rest-api-specs/blob/ac2c1811908bc058fc0d648f94748dbcaec378d0/specification/ai-foundry/data-plane/Foundry/openapi3/virtual-public-preview/microsoft-foundry-openapi3.json) |

Each document has exactly six semantic changes:

1. Four documentation fields change: the repeated summaries and descriptions of
   `POST /openai/v1/videos/edits` and `POST /openai/v1/videos/extensions` are
   deduplicated. See [the emitted edit operation](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/openapi3/v1/microsoft-foundry-openapi3.json#L31288).
   This is documentation-only, not a request, response, or routing change.
2. The duplicate `OpenAI.ChatCompletionMessageToolCallsItem` component is removed.
   The `tool_calls` reference in `OpenAI.ChatCompletionResponseMessage` now targets
   [`OpenAI.ChatCompletionMessageToolCalls`](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/openapi3/v1/microsoft-foundry-openapi3.json#L52607);
   see [the updated reference](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/openapi3/v1/microsoft-foundry-openapi3.json#L53518).
   The replacement schema is structurally identical to the removed schema,
   including its `items.anyOf` alternatives and documentation. No array item or
   nullability contract changes.

The corresponding fixes are
[microsoft/typespec#12368](https://github.com/microsoft/typespec/pull/12368) and
[microsoft/typespec#12300](https://github.com/microsoft/typespec/pull/12300).

**Significance:** the wire shape is unchanged, and there are no other semantic
differences in these outputs. The component-name removal can still affect tools
that expose schema names as public SDK types or reference that component directly.
Consumers using OpenAPI-based generation should assess that naming impact before
merging. SDKs were not regenerated as part of this dependency update.

The former generated-file validation mismatch is resolved by retaining the
regenerated JSON and YAML. It was not suppressed. There are no changed tracked
Swagger 2 documents, so Swagger-2-only OAV/OAD checks are not used as a substitute
for validating these OpenAPI 3.2 documents.

## Validation and limitations

The baseline and upgraded compiler sweeps used the repository's project-discovery
helper and compiler options, warnings-as-errors, each checked-in emitter
configuration, isolated compiler processes, and read-only capture of generated
output. All 617 discovered folders were accounted for:

| Stage | Result |
| --- | --- |
| Baseline dependencies | 613 successful compilations, one configuration-only folder, one existing excluded project, two existing compiler failures |
| Upgraded dependencies, before suppression | 25 projects newly fail on 37 distinct lint targets; the same two baseline compiler failures remain |
| After the scoped suppressions | All 25 affected projects pass the repository TypeSpec validator in check-only mode |
| Regenerated Foundry output | Its repository TypeSpec validation passes; configured JSON/YAML output is current |

Other completed checks:

- `pnpm install --frozen-lockfile` succeeds with the regenerated lockfile.
- `pnpm build` succeeds, including the Foundry library and repository validation
  tooling against compiler 1.18.
- `pnpm exec tsp format` was run on all 29 edited TypeSpec files.
- `pnpm --filter @azure-tools/typespec-validation --filter @azure-tools/typespec-suppressions test:ci`
  passed all 36 suppression tests and 487 of 492 validation-tool tests; five CLI
  tests timed out while the compiler sweep was running. Retrying both affected
  files with
  `pnpm --filter @azure-tools/typespec-validation exec vitest run test/cli.test.ts test/compiler-cli.test.ts --maxWorkers=1 --testTimeout=120000 --hookTimeout=120000`
  passed all 82 tests in those files. All 492 validation-tool cases therefore pass
  across the initial run and isolated retry; there is no remaining test failure.
- The changed JSON documents pass the official
  [OpenAPI 3.2 document schema](https://spec.openapis.org/oas/3.2/schema/2025-09-17).
  Additionally, all 4,681 component schemas pass JSON Schema 2020-12 keyword-grammar
  validation. URI/email format assertions and OpenAPI-specific annotation semantics
  are not asserted by those schema checks.
- All 10,984 local references across the two JSON documents resolve; each YAML
  output is semantically identical to its corresponding JSON document.
- `git diff --check` passes.

For affected projects the repository check was
`node eng/tools/typespec-validation/cmd/tsv.js <project> '{"checkingAllSpecs":true}' --check`.
The full standard check can be reproduced with
`node eng/tools/typespec-validation/cmd/tsv.js --all --check`; the two existing
compiler failures below mean this report does not claim an entirely green
repository-wide validation run.

Existing failures, not hidden by this PR:

- [Compute](https://github.com/markcowl/azure-rest-api-specs/tree/markcowl-typespec-dependency-update/specification/compute/resource-manager/Microsoft.Compute/Compute):
  13 `@azure-tools/typespec-autorest/example-loading` errors for example directories
  absent from this checkout, already observed with the old dependencies.
- [Foundry fine-tuning Python entrypoint](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-dependency-update/specification/ai-foundry/data-plane/Foundry/src/sdk-python-azure-ai-finetuningsessions/tspconfig.yaml):
  `emitter-not-found` for `@azure-tools/typespec-python`, which is not an installed
  repository dependency; also observed before the upgrade.

The excluded internal Foundry contracts project retains its existing exclusion.
The DPS parent config has neither `main.tsp` nor `client.tsp`; its device and service
projects were discovered and checked separately. Neither case is counted as a
successful compilation.

`pnpm peers check` reports an existing `tslib` 1.14.1 versus 2.x requirement in
`@ts-common/iterator` and `@ts-common/string-map`. The relevant lockfile entries are
unchanged by this upgrade.

## Separate skill proposal

The proposed [TypeSpec dependency-update skill](https://github.com/markcowl/azure-rest-api-specs/blob/markcowl-typespec-update-skill/.github/skills/typespec-dependency-update/SKILL.md)
is on `markcowl-typespec-update-skill`, not this PR branch. It includes stable
release discovery, pnpm catalogs and aliases, baseline-versus-regression checks,
targeted suppressions, branch-divergence handling, semantic OpenAPI assessment, and
fork-based draft PR publication.
