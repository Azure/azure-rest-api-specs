# CRR LintDiff Suppressions — Ours vs Active-Stamp (#25 analysis)

Compares the readme LintDiff suppressions in the CRR (passive-stamp) project against the
sibling RecoveryServicesBackup (active-stamp), with each rule's severity.

## Ours — 23 suppressions (ALL error-level → all necessary)

| # | Rule | Severity | In active? |
|---|------|----------|-----------|
| 1 | ResourceNameRestriction | error | ✅ both |
| 2 | AvoidAdditionalProperties | error | ours-only |
| 3 | AllTrackedResourcesMustHaveDelete | error | ✅ both |
| 4 | TrackedResourcesMustHavePut | error | ours-only |
| 5 | TrackedResourcePatchOperation | error | ours-only |
| 6 | PathForTrackedResourceTypes | error | ours-only |
| 7 | TrackedResourceBeyondsThirdLevel | error | ✅ both |
| 8 | PutResponseCodes | error | ours-only |
| 9 | PostResponseCodes | error | ours-only |
| 10 | PatchResponseCodes | error | ours-only |
| 11 | PutGetPatchResponseSchema | error | ours-only |
| 12 | GetCollectionOnlyHasValueAndNextLink | error | ours-only |
| 13 | NoErrorCodeResponses | error | ours-only |
| 14 | LroLocationHeader | error | ours-only |
| 15 | OperationsAPIImplementation | error | ours-only |
| 16 | BodyTopLevelProperties | error | ours-only |
| 17 | XmsPageableForListCalls | error | ours-only |
| 18 | ParametersInPost | error | ours-only |
| 19 | RequiredPropertiesMissingInResourceModel | error | ours-only |
| 20 | ResourceHasXMsResourceEnabled | error | ours-only |
| 21 | EvenSegmentedPathForPutOperation | error | ours-only |
| 22 | PathForNestedResource | error | ours-only |
| 23 | UnSupportedPatchProperties | error | ours-only |

**Audit result: all 23 are ERROR-level.** Error-level rules BLOCK the CI gate, so each suppression is
genuinely required (a warning-level rule would not need suppressing). The list is lean — no unnecessary
(warning-level) suppressions to trim.

## Active-stamp — 7 unique suppressions

| Rule | Severity | In ours? | Note |
|------|----------|----------|------|
| ResourceNameRestriction | error | ✅ both | shared legacy trait |
| AllTrackedResourcesMustHaveDelete | error | ✅ both | shared legacy trait |
| TrackedResourceBeyondsThirdLevel | error | ✅ both | shared deep-path trait |
| ImplementPrivateEndpointAPIs | error | N/A | active has private endpoints; CRR does not |
| LroErrorContent | — | N/A | active LRO feature; not in CRR surface |
| ConsistentPatchProperties | — | N/A | triggered by active's patch changes; N/A to CRR |
| NestedResourcesMustHaveListOperation | error | N/A | active nested resources; CRR list ops differ |

## Overlap / difference

- **Both (3):** ResourceNameRestriction, AllTrackedResourcesMustHaveDelete, TrackedResourceBeyondsThirdLevel.
- **Ours-only (20):** the rest of our list.
- **Active-only (4):** ImplementPrivateEndpointAPIs, LroErrorContent, ConsistentPatchProperties,
  NestedResourcesMustHaveListOperation.

## WHY ours is bigger (23 vs 9) — the crux

1. **LintDiff is DIFF-ONLY.** The active-stamp is an EXISTING spec, so LintDiff only reports NEW/changed
   violations vs its previous version. All its pre-existing legacy traits are GRANDFATHERED — it only
   suppresses the handful its recent CHANGES tripped (9 entries / 7 rules).
2. **Our CRR is a NET-NEW spec** (new top-level folder, first version `2026-07-15`, no predecessor). LintDiff
   treats EVERYTHING as new, so it flags EVERY legacy-contract violation across the whole surface → we must
   suppress all 23.
3. The 4 active-only rules map to active-stamp features CRR does not have (private endpoints, that LRO error
   shape, patch-consistency changes, nested-resource list ops).

## Same syntax, same DeprecatedConfig warnings

Both readmes use the identical ` ```yaml $(directive) ` + `directive:` + `- suppress:` block (217 repo
readmes use it). Both emit the 23×/9× `DeprecatedConfig` autorest-core warnings. There is NO adopted modern
replacement for readme LintDiff rule suppression (`suppressions.yaml` is for `tool:`-level suppressions like
TypeSpecRequirement, not individual rules). → leave as-is; matches the active-stamp and repo norm.

## Optional deeper audit (not yet done)

All 23 are error-level (necessary IF they fire). To confirm each one ACTUALLY fires (a suppression for a
non-firing rule is harmless but removable), temporarily remove the `directive` block, re-run
`autorest --spectral ... readme.md`, and check which of the 23 appear as errors. Any that don't fire could
be pruned. Low priority — extra suppressions are harmless.

## PRUNE-CHECK RESULTS (2026-07-16) — DO NOT PRUNE

Ran the check: stripped the `directive` block into a temp copy and re-ran
`autorest --spectral --openapi-subtype=arm --use=@microsoft.azure/openapi-validator readme-nosuppress.md`.

**16 of 23 FIRED as errors → confirmed NEEDED:**
ResourceNameRestriction (x15), AvoidAdditionalProperties (x17), PathForTrackedResourceTypes (x2),
PutResponseCodes, PostResponseCodes (x2), PatchResponseCodes, PutGetPatchResponseSchema,
GetCollectionOnlyHasValueAndNextLink (x3), NoErrorCodeResponses, LroLocationHeader (x2),
XmsPageableForListCalls, ParametersInPost (x2), ResourceHasXMsResourceEnabled,
EvenSegmentedPathForPutOperation, PathForNestedResource, UnSupportedPatchProperties.

**7 did NOT fire — but they are NOT prunable (false negatives):**
AllTrackedResourcesMustHaveDelete, TrackedResourcesMustHavePut, TrackedResourcePatchOperation,
TrackedResourceBeyondsThirdLevel, OperationsAPIImplementation, BodyTopLevelProperties,
RequiredPropertiesMissingInResourceModel.

**CRITICAL FINDING:** all 7 non-firing rules are defined ONLY in the **native** ruleset
(`openapi-validator-rulesets/dist/native/rulesets/arm.js`), and EVERY rule that fired is from the
**spectral** ruleset (`az-arm.js` / `az-common.js`). Verified 1:1. This proves that
`autorest --spectral` executes ONLY the spectral ruleset, NOT the native ruleset — so those 7 rules were
never evaluated by this run. Their "did not fire" is a testing gap, not evidence they're unneeded. The full
CI LintDiff (via the `lint-diff` tool) DOES run the native ruleset, so those 7 are presumed still required.

**No missing suppressions:** every spectral error that fired is already covered by our list (0 unsuppressed).

**RECOMMENDATION: keep all 23.** 16 are proven needed; the 7 native-ruleset ones can't be validated by the
local `--spectral` method and were presumably added because CI flagged them — pruning them would risk CI
failures. Extra suppressions are harmless. To truly test the 7, run the full `lint-diff` tool (before/after
harness) which exercises the native ruleset — deferred (needs a main-branch checkout as "before").


---

# Curated Reasons — Why Each of the 23 Suppressions Exists (2026-07-22 review)

This section is the write-up of our suppression-by-suppression review. Each entry states: the
operation/resource it affects, what the rule normally demands, and why the frozen 2023-01-15 CRR
contract forces us to suppress it. These reasons are mirrored (verbatim-equivalent) in the live
`readme.md` `directive:` block. **Core principle for all 23: the CRR `2026-07-15` surface is a
byte-faithful migration of the frozen `stable/2023-01-15/bms.json`; "fixing" any of these would change
an existing wire contract.**

## Group A — Tracked-resource false positives (the `location` mis-classification)

LintDiff's `getTrackedResources()` helper classifies a resource as a *tracked resource* using a single
criterion: **does its response body have a `location` property?** `BackupResourceConfigResource` and
`RecoveryPointResource` carry a legacy `location` from the 2023-01-15 envelope, so they are wrongly
treated as tracked resources — tripping five tracked-resource rules. None are genuine tracked resources
(they are read-mostly passive-stamp resources), so all five are false positives.

| Rule | Affects | Rule wants | Why suppressed |
|------|---------|-----------|----------------|
| `AllTrackedResourcesMustHaveDelete` | BackupResourceConfigResource, RecoveryPointResource | every tracked resource has DELETE | frozen contract exposes no DELETE; mis-classified via `location` |
| `TrackedResourcesMustHavePut` | RecoveryPointResource | tracked resource has PUT | recovery points are read-only (GET only) in 2023-01-15 |
| `TrackedResourcePatchOperation` | RecoveryPointResource | tracked resource has a tags PATCH | recovery points are read-only; no PATCH in frozen contract |
| `PathForTrackedResourceTypes` | both resources | standard tracked-resource path shape | paths mirror the frozen 2023-01-15 URLs exactly |
| `TrackedResourceBeyondsThirdLevel` | RecoveryPointResource | tracked resource not nested beyond 3rd level | deep path (vaults/backupFabrics/protectionContainers/protectedItems/recoveryPoints) is part of the 2023-01-15 contract |

## Group B — Response-code sets & response schemas

The frozen contract uses response-code sets LintDiff no longer permits for ARM.

| Rule | Affects | Rule wants | Why suppressed |
|------|---------|-----------|----------------|
| `PutResponseCodes` | BackupResourceStorageConfigs_Update (PUT vaultstorageconfig) | exactly [200, 201, default] | frozen contract returns [200, default]; never returned 201 |
| `PostResponseCodes` | CrossRegionRestore_Trigger; RecoveryPoints_GetAccessToken | sync POST [200,default]/[204,default] | (1) restore is a header-less-202 LRO whose 200 has no schema; (2) access-token POST returns a 400 — neither fits the rule |
| `PatchResponseCodes` | BackupResourceStorageConfigs_patch (PATCH vaultstorageconfig) | [200, default] (or +202) | frozen contract returns [204, default] (No Content) |
| `PutGetPatchResponseSchema` | vaultstorageconfig (BackupResourceConfigResource) | PUT/GET/PATCH share one schema | PATCH returns 204 (no body) while GET/PUT return the resource — schemas differ by design |
| `NoErrorCodeResponses` | RecoveryPoints_GetAccessToken | errors only via `default` | explicit 400 (x-ms-error-response:true) is in the frozen contract; clients depend on it |

## Group C — Singleton / legacy path shape

`BackupResourceConfigResource` is an `@singleton` whose path ends in the fixed name `vaultstorageconfig`
(not a parameterized `{resourceName}`), and the legacy `vaultName` has no name pattern.

| Rule | Affects | Rule wants | Why suppressed |
|------|---------|-----------|----------------|
| `ResourceNameRestriction` | vaultName (from parent VaultResource) | resource name has a pattern | vaultName inherits NamePattern="" for backward compatibility; adding a pattern changes the contract |
| `EvenSegmentedPathForPutOperation` | PUT vaultstorageconfig | PUT path ends in {resourceType}/{resourceName} | singleton path ends in fixed `vaultstorageconfig` per frozen contract |
| `PathForNestedResource` | vaultstorageconfig path | nested-resource {type}/{name-param} pattern | singleton nested path; rule docs allow singleton/fully-qualified paths as a valid suppression case |

## Group D — List / pagination / collection modeling

| Rule | Affects | Rule wants | Why suppressed |
|------|---------|-----------|----------------|
| `GetCollectionOnlyHasValueAndNextLink` | AadProperties_Get; BackupUsageSummariesCRR; RecoveryPointsCrr list | collection 200 has exactly `value` + `nextLink` as direct props | AadProperties returns a single-resource envelope; BackupManagementUsageList has `value` only (unpaged legacy list); RecoveryPointResourceList gets `nextLink` via its shared base — all match the frozen contract |
| `XmsPageableForListCalls` | AadProperties_Get | any collection-path GET is a paged LIST → needs x-ms-pageable | AadProperties is a singleton GET returning one AADPropertiesResource; the genuine lists (BackupCrrJobs_List, RecoveryPointsCrr_List, BackupProtectedItemsCrr_List, BackupUsageSummariesCRR) already declare x-ms-pageable |
| `ParametersInPost` | BackupCrrJobs_List (modeled as POST) | POST carries no query params but api-version | frozen contract queries the CRR job feed via POST with $filter/$skipToken query params |

## Group E — Envelope / model shape

| Rule | Affects | Rule wants | Why suppressed |
|------|---------|-----------|----------------|
| `AvoidAdditionalProperties` | legacy CRR models | no open `additionalProperties` maps | 2023-01-15 models use open maps; preserved |
| `BodyTopLevelProperties` | OperationStatus | non-ARM fields live under `properties` | status/startTime/endTime/error are top-level in the frozen async-status model |
| `RequiredPropertiesMissingInResourceModel` | legacy Resource envelope | id/name/type marked `required` | frozen Resource marks them read-only but not required (no `required` list) |
| `ResourceHasXMsResourceEnabled` | legacy Resource envelope | model emits x-ms-azure-resource | the only TypeSpec way (`@extension("x-ms-azure-resource", true)`) emits inconsistently across compiler 1.13 vs 1.14 and breaks the TypeSpec-Validation drift check; the missing marker is a benign read-only extension |
| `UnSupportedPatchProperties` | PATCH vaultstorageconfig | `location` not in a PATCH body (readOnly/immutable) | frozen PATCH uses the shared BackupResourceConfigResource whose body includes top-level `location` |

## Group F — LRO & Operations API

| Rule | Affects | Rule wants | Why suppressed |
|------|---------|-----------|----------------|
| `LroLocationHeader` | CrossRegionRestore_Trigger; CrrOperationResults_Get | 202 includes a `Location` header | frozen contract returns a header-less 202; adding the header changes it |
| `OperationsAPIImplementation` | provider surface | RP exposes `.../providers/Microsoft.RecoveryServices/operations` | CRR passive-stamp has no Operations list; the shared RP's operations endpoint is served by the sibling RecoveryServices/RecoveryServicesBackup specs |

## Prune status (carried from the 2026-07-16 check)

16 of 23 are proven to fire against the emitted swagger; the other 7 are native-ruleset rules the local
`--spectral` harness does not exercise (testing gap, not evidence they are unneeded). **Keep all 23.**


---

# TypeSpec-linter Suppressions — `tspconfig.yaml` `linter.disable` (11 rules)

A separate layer from the readme LintDiff suppressions above. These turn off **TypeSpec compile-time
linter rules** (`@azure-tools/typespec-azure-*`) while `tsp compile` runs — they lint the `.tsp` **source**,
whereas the 23 above lint the **emitted** `bms.json`. Same core justification: faithful migration of the
frozen 2023-01-15 CRR contract. Some rules appear at **both** layers because one legacy trait trips both
linters (noted in the "LintDiff pair" column).

| Rule (short) | What it normally requires | Why disabled for CRR | LintDiff pair |
|--------------|---------------------------|----------------------|---------------|
| `azure-core/casing-style` | PascalCase/camelCase names; uppercased acronyms | Legacy names (`objectType`, `AAD`, `SQL`, `Crr`, …) are part of the wire contract; renaming breaks compatibility | — |
| `azure-core/no-string-discriminator` | discriminators be enums, not raw strings | Legacy types discriminate on **string** `objectType`/`jobType` (2023-01-15) | — |
| `azure-core/no-multiple-discriminator` | one discriminator level per hierarchy | `ProtectedItem`, `Job` etc. carry **multi-level** discriminated inheritance from 2023-01-15 | — |
| `azure-resource-manager/missing-x-ms-identifiers` | arrays declare `x-ms-identifiers` (key fields) | Legacy arrays don't; adding them changes the emitted swagger (byte-faithfulness) | — |
| `azure-core/documentation-required` | every model/op/property has a doc | Some legacy properties/operations have no description; adding one diverges from the frozen source | — |
| `azure-resource-manager/lro-location-header` | LRO returns a `Location`/`Azure-AsyncOperation` header | Original CRR LRO (CrossRegionRestore_Trigger, CrrOperationResults_Get) returns a **header-less 202** | `LroLocationHeader` |
| `azure-resource-manager/no-empty-model` | no bare `type: object` models | Legacy models use empty `type:object` (e.g. `AccessTokenBadRequestResponse`, the 400 body) | — |
| `azure-resource-manager/arm-post-operation-response-codes` | POST returns only 200/201/202/default | `RecoveryPoints_GetAccessToken` also documents a **400** | `PostResponseCodes`, `NoErrorCodeResponses` |
| `azure-resource-manager/missing-operations-endpoint` | RP exposes `…/providers/Microsoft.RecoveryServices/operations` | CRR passive-stamp exposes **no** Operations list; the shared RP's endpoint lives in the sibling specs | `OperationsAPIImplementation` |
| `azure-resource-manager/no-resource-delete-operation` | every resource has a DELETE | `vaultstorageconfig` singleton has **no** delete in the frozen contract | `AllTrackedResourcesMustHaveDelete` |
| `azure-resource-manager/no-response-body` | 200 responses carry a body | CRR operation-result reads return an **empty 200** body per the frozen contract | — |

**Layer summary:** 23 readme LintDiff suppressions (emitted swagger) + 11 tspconfig linter.disable
(TypeSpec source) = two independent guardrails, both scoped to exactly the legacy traits of
`stable/2023-01-15/bms.json`. 4 rules overlap conceptually across the two layers (LRO location header,
POST response codes / error codes, operations endpoint, resource delete).


---

# Deep-Dive: Plain-English Reasoning for EVERY Suppression (with evidence)

> Written 2026-07-28 for the "I forgot again" case. Each entry is self-contained: **what the rule
> wants**, **what our spec actually has** (with concrete evidence from the emitted
> `stable/2026-07-15/bms.json`), **why we can't/shouldn't comply**, and a one-line **verdict**.
> Golden rule behind all 23: our `2026-07-15` surface is a *byte-faithful* migration of the frozen
> `stable/2023-01-15/bms.json`. "Fixing" a lint finding = changing an existing wire contract = breaking
> backward compatibility. So we suppress instead.

## First, two mental models you need

**(1) Tracked vs Proxy resource.** ARM has two resource kinds:
- **Tracked** = a real, standalone Azure resource you deploy into a region. Has `location` + `tags`,
  shows up in `az resource list`, and has a FULL lifecycle: **PUT** (create) + **GET** (read) +
  **PATCH** (update tags) + **DELETE**. Example: a VM, a storage account.
- **Proxy** = a read-only or child sub-object. No independent lifecycle. Example: a recovery point.

**(2) How LintDiff decides "tracked".** It does ONE dumb check:
`getTrackedResources() = every resource whose response body has a "location" property`.
That's it. If your model has a `location` field, LintDiff assumes it's tracked and demands the full
PUT/PATCH/DELETE lifecycle — even if the resource is genuinely read-only. Several of our models carry a
legacy `location` from the 2023-01-15 envelope, so they get mis-classified. **This one quirk is the root
cause of 5 of our 23 suppressions.**

---

## bms.json line-number index (emitted `stable/2026-07-15/bms.json`)

Every operation and model referenced below, with its exact line. (Lines shift if the file is
regenerated; regenerate this table with the extraction script if needed.)

**Operations (by operationId line):**

| Operation | Verb + path (tail) | Line |
|---|---|---|
| AadProperties_Get | GET .../backupAadProperties | 79 |
| CrossRegionRestore_Trigger | POST .../backupCrossRegionRestore | 131 |
| BackupCrrJobs_List | POST .../backupCrrJobs | 242 |
| CrrOperationResults_Get | GET .../backupCrrOperationResults/{id} | 312 |
| CrrOperationStatus_Get | GET .../backupCrrOperationsStatus/{id} | 360 |
| RecoveryPointsCrr_List | GET .../recoveryPoints | 408 |
| RecoveryPointsCrr_Get | GET .../recoveryPoints/{id} | 486 |
| RecoveryPoints_GetAccessToken | POST .../recoveryPoints/{id}/accessToken | 560 |
| BackupProtectedItemsCrr_List | GET .../backupProtectedItems | 647 |
| BackupUsageSummariesCRR_List | GET .../backupUsageSummaries | 711 |
| BackupResourceStorageConfigs_Get | GET .../vaultstorageconfig | 778 |
| BackupResourceStorageConfigs_Update | PUT .../vaultstorageconfig | 822 |
| BackupResourceStorageConfigs_patch | PATCH .../vaultstorageconfig | 875 |

**Models (by definition line):**

| Model | Line |
|---|---|
| AADPropertiesResource | 947 |
| AccessTokenBadRequestResponse | 961 |
| BackupManagementUsageList | 2199 |
| BackupResourceConfigResource | 2234 |
| CrrAccessTokenResource | 2502 |
| Job | 3310 |
| JobResourceList | 3468 |
| OperationStatus | 3960 |
| ProtectedItem | 4182 |
| RecoveryPointResource | 4581 |
| RecoveryPointResourceList | 4615 |
| Resource | 4720 |
| ResourceList | 4828 |

**Parameters / discriminators:**

| Item | Line(s) |
|---|---|
| `vaultName` path param (inline, no `pattern` key) — first occurrence | 424 (also 502, 576, 663, 727, 794, 838, 891) |
| discriminator `objectType` | 2497, 4019, 4517, 4949 |
| discriminator `jobType` | 3349 |
| discriminator `protectedItemType` | 4252 |

---

## GROUP A — The 5 "tracked-resource" false positives (all caused by legacy `location`)

Two models carry a legacy `location` and get mis-flagged as tracked:
- **`RecoveryPointResource`** (bms.json line ~4581) — `location` at ~line 4597, `allOf: ProxyResource` at
  ~line 4611. Operations: **GET (single)** `RecoveryPointsCrr_Get` + **GET (list)** `RecoveryPointsCrr_List`.
  **No PUT/PATCH/DELETE** — recovery points are created *by the backup system*, you can only read them.
- **`BackupResourceConfigResource`** (line ~2234) — has `location`, `allOf: ProxyResource`. It's the vault
  storage config singleton. Operations: **GET + PUT + PATCH** (no DELETE).

### A1. `TrackedResourcesMustHavePut` — affects RecoveryPointResource *(def L4581; GET-single L486, GET-list L408; no PUT anywhere)*
- **Rule wants:** a tracked resource must have a PUT (create) operation.
- **We have:** RecoveryPointResource has only GET (single) + GET (list). No PUT.
- **Why suppress:** recovery points are read-only in the frozen contract; you never "create" one via API.
  The rule only fires because `location` mis-classified it as tracked. Adding PUT = inventing new API.
- **Verdict:** false positive. Suppress.

### A2. `TrackedResourcePatchOperation` — affects RecoveryPointResource *(def L4581; only GET L486/L408, no PATCH)*
- **Rule wants:** a tracked resource must have a PATCH (to update tags).
- **We have:** no PATCH on recovery points.
- **Why suppress:** read-only resource; same `location` mis-classification. Adding PATCH = new API.
- **Verdict:** false positive. Suppress.

### A3. `AllTrackedResourcesMustHaveDelete` — affects RecoveryPointResource *(def L4581)* + BackupResourceConfigResource *(def L2234)* *(neither has a DELETE op)*
- **Rule wants:** every tracked resource must have DELETE.
- **We have:** neither resource has DELETE (recovery points are read-only; vault storage config is a
  singleton you configure, never delete).
- **Why suppress:** frozen contract never exposed DELETE for these; `location` mis-classification again.
- **Verdict:** false positive. Suppress.

### A4. `PathForTrackedResourceTypes` — affects both *(RecoveryPointResource path L484; vaultstorageconfig path L776)*
- **Rule wants:** tracked resources to sit at the standard ARM path shape.
- **We have:** the exact legacy 2023-01-15 URLs.
- **Why suppress:** they aren't genuinely tracked; their legacy paths must be preserved byte-for-byte.
- **Verdict:** false positive. Suppress.

### A5. `TrackedResourceBeyondsThirdLevel` — affects RecoveryPointResource *(5-level path L484; def L4581)*
- **Rule wants:** a tracked resource must not be nested more than 3 levels deep.
- **We have:** recoveryPoints is 5 levels deep:
  `vaults/{}/backupFabrics/{}/protectionContainers/{}/protectedItems/{}/recoveryPoints/{}`.
- **Why suppress:** deep nesting is part of the frozen contract; it's a read-only child, not a tracked
  resource, so the depth limit doesn't truly apply.
- **Verdict:** false positive. Suppress.

---

## GROUP B — Response-code sets & response schemas (frozen contract uses shapes LintDiff dislikes)

### B1. `PutResponseCodes` — affects BackupResourceStorageConfigs_Update (PUT vaultstorageconfig) *(op L822)*
- **Rule wants:** PUT must return exactly **[200, 201, default]** (201 = "created").
- **We have (evidence):** PUT returns **[200, default]** → `BackupResourceConfigResource`. No 201.
- **Why suppress:** the frozen 2023-01-15 contract never returned 201 here (config update is treat-as-
  upsert but only ever signalled 200). Adding 201 changes the response contract clients rely on.
- **Verdict:** intentional legacy shape. Suppress.

### B2. `PostResponseCodes` — affects CrossRegionRestore_Trigger *(op L131)* AND RecoveryPoints_GetAccessToken *(op L560)*
- **Rule wants:** a synchronous POST returns **[200, default]** or **[204, default]**.
- **We have (evidence):**
  - `CrossRegionRestore_Trigger`: POST **[200 (no schema), 202 (no schema), default]**, `x-ms-long-running=true`
    → a long-running POST whose 200/202 have no body (the legacy "header-less 202" restore pattern).
  - `RecoveryPoints_GetAccessToken`: POST **[200 → CrrAccessTokenResource, 400 (no schema), default]** — the
    extra **400** is not allowed by the sync-POST rule.
- **Why suppress:** both shapes are frozen-contract behavior (an LRO restore + a documented 400). Changing
  either breaks compatibility.
- **Verdict:** two legacy POST shapes. Suppress.

### B3. `PatchResponseCodes` — affects BackupResourceStorageConfigs_patch (PATCH vaultstorageconfig) *(op L875)*
- **Rule wants:** PATCH returns **[200, default]** (or +202 for long-running).
- **We have (evidence):** PATCH returns **[204 (No Content, no schema), default]**.
- **Why suppress:** frozen contract returns 204 (the update succeeds but echoes no body). Switching to a
  200-with-body changes the response contract.
- **Verdict:** intentional 204. Suppress.

### B4. `PutGetPatchResponseSchema` — affects vaultstorageconfig (BackupResourceConfigResource def L2234) *(GET L778, PUT L822, PATCH L875)*
- **Rule wants:** the PUT, GET and PATCH on one resource all return the *same* schema.
- **We have (evidence):** GET → BackupResourceConfigResource (200), PUT → BackupResourceConfigResource (200),
  but **PATCH → 204 with no body**. So the three schemas are not identical.
- **Why suppress:** it's the *same* resource, but the frozen contract deliberately models PATCH as a
  204-No-Content operation. Aligning schemas would mean giving PATCH a 200 body = contract change.
- **Verdict:** consequence of the legacy 204 PATCH. Suppress.

### B5. `NoErrorCodeResponses` — affects RecoveryPoints_GetAccessToken *(op L560; explicit 400 in its responses)*
- **Rule wants:** no explicit error status codes; model all errors via the `default` response.
- **We have (evidence):** an explicit **400** (BadRequest, `x-ms-error-response: true`) on the access-token POST.
- **Why suppress:** the 400 is part of the frozen 2023-01-15 contract and clients branch on it. Removing it
  (folding into `default`) changes observable behavior.
- **Verdict:** documented legacy 400. Suppress.

---

## GROUP C — Singleton & legacy path shape

The vault storage config is an **`@singleton`** — its URL ends in a fixed literal `vaultstorageconfig`
instead of a `{parameterName}`. Rules that assume `.../{resourceType}/{resourceName}` therefore trip.

### C1. `ResourceNameRestriction` — affects vaultName *(inline path param, first at L424; no `pattern` key on any of L424/502/576/663/727/794/838/891)*
- **Rule wants:** every resource-name path parameter should declare a validation pattern.
- **We have:** `vaultName` inherits from the legacy parent with an empty NamePattern ("" = no pattern).
- **Why suppress:** the frozen 2023-01-15 paths never constrained vaultName; adding a regex could reject
  names the old contract accepted = behavior change.
- **Verdict:** legacy unconstrained name. Suppress.

### C2. `EvenSegmentedPathForPutOperation` — affects PUT vaultstorageconfig *(path L776, PUT op L822)*
- **Rule wants:** a PUT path to end in an even `{resourceType}/{resourceName}` pair.
- **We have:** path ends in the fixed singleton literal `.../backupstorageconfig/vaultstorageconfig` (the
  last segment is a constant name, not a parameter).
- **Why suppress:** it's a singleton; the frozen contract models exactly this path. Parameterizing it =
  contract change.
- **Verdict:** singleton path. Suppress.

### C3. `PathForNestedResource` — affects the vaultstorageconfig path *(path key L776)*
- **Rule wants:** nested resources to follow `{resourceType}/{resourceName-parameter}` segments.
- **We have:** `vaults/{vaultName}/backupstorageconfig/vaultstorageconfig` — a singleton nested resource.
- **Why suppress:** the rule's own docs note singleton / fully-qualified paths are a valid suppression case;
  frozen contract models it this way.
- **Verdict:** singleton path (rule-sanctioned). Suppress.

---

## GROUP D — List / pagination / collection modeling

### D1. `GetCollectionOnlyHasValueAndNextLink` — affects 3 responses *(AadProperties_Get L79→AADPropertiesResource L947; BackupUsageSummariesCRR_List L711→BackupManagementUsageList L2199; RecoveryPointsCrr_List L408→RecoveryPointResourceList L4615 / ResourceList L4828)*
- **Rule wants:** a collection GET's 200 body has EXACTLY the two direct properties `value` and `nextLink`.
- **We have (evidence):**
  - `AadProperties_Get` → **AADPropertiesResource** (direct props: `properties` only) — it's a *single*
    resource envelope, not a list at all.
  - `BackupUsageSummariesCRR_List` → **BackupManagementUsageList** (direct props: `value` only, **no
    nextLink**) — a legacy *unpaged* list.
  - `RecoveryPointsCrr_List` → **RecoveryPointResourceList** (direct prop `value`; its `nextLink` comes via
    the shared `ResourceList` base, so only `value` is "direct").
- **Why suppress:** all three match the frozen contract's modeling. Restructuring them (adding nextLink,
  flattening the base) changes the wire shape.
- **Verdict:** three legacy list/envelope shapes. Suppress.

### D2. `XmsPageableForListCalls` — affects AadProperties_Get *(op L79→AADPropertiesResource L947, single-envelope, not paged)*
- **Rule wants:** any GET on a collection-style path (no `{name}` segment) is a LIST → must have
  `x-ms-pageable`.
- **We have (evidence):** `/backupAadProperties` GET returns a **single** AADPropertiesResource,
  `pageable=false`. It's a singleton "get properties", not a list.
- **Why suppress:** it isn't paginated in the frozen contract. (For contrast, the *genuine* lists —
  `BackupCrrJobs_List`, `RecoveryPointsCrr_List`, `BackupProtectedItemsCrr_List`,
  `BackupUsageSummariesCRR_List` — ALL already have `x-ms-pageable=true`, verified.)
- **Verdict:** false positive (singleton get on a list-shaped path). Suppress.

### D3. `ParametersInPost` — affects BackupCrrJobs_List *(POST op L242, path L240; $filter/$skipToken as query params)*
- **Rule wants:** a POST carries no query parameters other than `api-version`.
- **We have (evidence):** `BackupCrrJobs_List` is modeled as **POST** and carries **`$filter` + `$skipToken`**
  query params (the cross-region job feed is queried via POST).
- **Why suppress:** frozen contract puts these in the query string. Moving them into the request body =
  contract change.
- **Verdict:** legacy POST-with-query. Suppress.

---

## GROUP E — Envelope / model shape

### E1. `AvoidAdditionalProperties` — affects many legacy models
- **Rule wants:** no open `additionalProperties` maps (prefer typed properties).
- **We have (evidence):** legacy open maps like `kpisHealths`, `propertyBag`, `internalPropertyBag`,
  `recoveryPointMoveReadinessInfo` across ~a dozen models (AzureIaaSVMJobExtendedInfo, AzureVmWorkload...,
  etc.).
- **Why suppress:** these open dictionaries are part of the 2023-01-15 contract; typing them would change
  the schema.
- **Verdict:** legacy open maps. Suppress.

### E2. `BodyTopLevelProperties` — affects OperationStatus *(def L3960)*
- **Rule wants:** in an ARM body, only the allowed envelope keys (name/type/id/location/properties/tags/…)
  live at the top level; everything else nests under `properties`.
- **We have (evidence):** `OperationStatus` (line ~3960) has direct props
  `id, name, status, startTime, endTime, error, properties` — so `status/startTime/endTime/error` sit at the
  **top level**, not under `properties`.
- **Why suppress:** the frozen async-status model is shaped this way; moving those four fields under
  `properties` changes the wire contract.
- **Verdict:** legacy async-status shape. Suppress.

### E3. `RequiredPropertiesMissingInResourceModel` — affects the Resource envelope *(def L4720; no `required` block)*
- **Rule wants:** an ARM resource marks `id`, `name`, `type` as **required**.
- **We have (evidence):** `Resource` (line ~4720) has props `id, name, type, location, tags, eTag` but
  **no `required` list at all** (they're read-only, not required).
- **Why suppress:** frozen 2023-01-15 `Resource` has no `required` block; adding one changes the contract.
- **Verdict:** legacy envelope. Suppress.

### E4. `ResourceHasXMsResourceEnabled` — affects the Resource envelope *(def L4720; no `x-ms-azure-resource`)*
- **Rule wants:** the base resource model emits the `x-ms-azure-resource: true` marker.
- **We have (evidence):** `Resource` has **no `x-ms-azure-resource`** (confirmed absent). The original
  2023-01-15 Resource *did* set it.
- **Why suppress (the nuanced one):** the ONLY way to emit it on this hand-written model in TypeSpec is
  `@extension("x-ms-azure-resource", true)` — but that decorator **emits inconsistently across TypeSpec
  compiler versions (1.13 vs the CI's 1.14-dev)**, which breaks the TypeSpec-Validation drift check
  (CI compiles with one compiler, we compile with another, outputs differ → gate fails). Rather than ship a
  compiler-version-fragile decorator, we suppress. The missing marker is a **benign, read-only ARM
  extension** (it hints tooling that the model is an ARM resource; nothing functional depends on it here).
- **Verdict:** benign gap, avoided a fragile fix. Suppress. *(This is the one suppression that documents a
  tiny real deviation from the original, not a false positive — see history: we tried the @extension, it
  broke drift, we reverted.)*

### E5. `UnSupportedPatchProperties` — affects PATCH vaultstorageconfig *(PATCH op L875; BackupResourceConfigResource def L2234, `location` in body)*
- **Rule wants:** `location` must not be patchable (it should be readOnly/immutable or absent from a PATCH body).
- **We have (evidence):** the PATCH uses the shared `BackupResourceConfigResource`, whose body includes the
  top-level `location` envelope property.
- **Why suppress:** the frozen PATCH uses this same model with `location` present; restructuring the PATCH
  payload changes the wire contract.
- **Verdict:** shared legacy model. Suppress.

---

## GROUP F — LRO & Operations API

### F1. `LroLocationHeader` — affects CrossRegionRestore_Trigger *(op L131)* + CrrOperationResults_Get *(op L312)*
- **Rule wants:** a 202 (Accepted / long-running) response includes a `Location` response header so clients
  know where to poll.
- **We have (evidence):** both return a **header-less 202** (202 present, no Location header):
  - `CrossRegionRestore_Trigger`: POST [200, **202**, default], `x-ms-long-running=true`.
  - `CrrOperationResults_Get`: GET [200, **202**, default].
- **Why suppress:** the frozen 2023-01-15 CRR restore/operation-result flow returns a header-less 202 (the
  poll URL is conveyed differently). Adding a Location header changes the contract.
- **Verdict:** legacy header-less 202. Suppress.

### F2. `OperationsAPIImplementation` — affects the provider surface
- **Rule wants:** the RP exposes a provider operations list at
  `.../providers/Microsoft.RecoveryServices/operations`.
- **We have:** the CRR passive-stamp surface has **no** operations endpoint.
- **Why suppress:** `Microsoft.RecoveryServices` is a *shared* RP; its operations list is served by the
  sibling `RecoveryServices` / `RecoveryServicesBackup` specs. Adding one here would duplicate a path that
  isn't part of the frozen CRR surface (and would collide with the sibling).
- **Verdict:** served elsewhere for the shared RP. Suppress.

---

## One-glance summary

| # | Suppression | Root cause | Kind |
|---|-------------|-----------|------|
| A1 | TrackedResourcesMustHavePut | legacy `location` → mis-flagged tracked | false positive |
| A2 | TrackedResourcePatchOperation | legacy `location` | false positive |
| A3 | AllTrackedResourcesMustHaveDelete | legacy `location` | false positive |
| A4 | PathForTrackedResourceTypes | legacy `location` | false positive |
| A5 | TrackedResourceBeyondsThirdLevel | legacy `location` | false positive |
| B1 | PutResponseCodes | PUT returns [200,default], no 201 | legacy shape |
| B2 | PostResponseCodes | LRO restore + access-token 400 | legacy shape |
| B3 | PatchResponseCodes | PATCH returns 204 | legacy shape |
| B4 | PutGetPatchResponseSchema | PATCH is 204 (no body) | legacy shape |
| B5 | NoErrorCodeResponses | documented 400 | legacy shape |
| C1 | ResourceNameRestriction | vaultName has no pattern | legacy path |
| C2 | EvenSegmentedPathForPutOperation | singleton path | legacy path |
| C3 | PathForNestedResource | singleton path | legacy path |
| D1 | GetCollectionOnlyHasValueAndNextLink | single-envelope / unpaged / based list | legacy shape |
| D2 | XmsPageableForListCalls | singleton get on list-shaped path | false positive |
| D3 | ParametersInPost | POST list with $filter/$skipToken | legacy shape |
| E1 | AvoidAdditionalProperties | legacy open maps | legacy shape |
| E2 | BodyTopLevelProperties | OperationStatus top-level fields | legacy shape |
| E3 | RequiredPropertiesMissingInResourceModel | no `required` on Resource | legacy shape |
| E4 | ResourceHasXMsResourceEnabled | compiler-fragile @extension | benign real gap |
| E5 | UnSupportedPatchProperties | `location` in PATCH body | legacy shape |
| F1 | LroLocationHeader | header-less 202 | legacy shape |
| F2 | OperationsAPIImplementation | ops list on sibling shared RP | legacy structure |

**Takeaway:** 6 are outright false positives (5 from the `location` quirk + XmsPageable), 16 are faithful
legacy contract shapes we must preserve, and 1 (ResourceHasXMsResourceEnabled) is a tiny benign gap we
accept to avoid a compiler-fragile fix. None represent a genuine API-design defect we could fix without
breaking the frozen 2023-01-15 contract.


---

# Deep-Dive #2: the 11 TypeSpec-linter Suppressions (`tspconfig.yaml` → `linter.disable`)

> These are a DIFFERENT layer from the 23 above. The 23 run on the **emitted swagger** (LintDiff/Spectral,
> post-compile). These 11 run **inside the TypeSpec compiler** on our **source `.tsp`** (before any swagger
> exists). Same golden rule: faithful migration of the frozen 2023-01-15 contract, so we disable the rule
> rather than change legacy names/shapes. 4 of them are the source-side twins of readme rules (noted).

### T1. `@azure-tools/typespec-azure-core/casing-style`
- **Rule wants:** Azure-standard casing (camelCase props, PascalCase models, acronyms like `Url`/`Id`/`Vm`
  not `URL`/`ID`/`VM`).
- **We have (evidence):** legacy names baked into the 2023-01-15 wire contract — model/property/acronym
  spellings such as `objectType`, `VM`/`IaaSVM`, `KEK`, `BEK`, `AAD`, etc.
- **Why suppress:** these strings ARE the contract (property names ship on the wire). Renaming them for
  "nicer casing" is a breaking change for every existing client.
- **Verdict:** frozen wire names. Disable.

### T2. `@azure-tools/typespec-azure-core/no-string-discriminator` *(objectType L2497/4019/4517/4949, jobType L3349, protectedItemType L4252)*
- **Rule wants:** discriminated unions to use an `enum`-typed discriminator, not a bare `string`.
- **We have (evidence):** 3 legacy string discriminators —
  `objectType` (4 base types: CrrAccessToken, OperationStatusExtendedInfo, RecoveryPoint, RestoreRequest),
  `jobType` (base: Job), `protectedItemType` (base: ProtectedItem).
- **Why suppress:** the frozen contract types these as open strings so new subtypes can appear without a
  contract bump. Converting to a closed enum changes the schema and rejects unknown values.
- **Verdict:** legacy open-string discriminators. Disable.

### T3. `@azure-tools/typespec-azure-core/no-multiple-discriminator` *(ProtectedItem def L4182, Job def L3310)*
- **Rule wants:** a single discriminator level per inheritance hierarchy.
- **We have (evidence):** deep legacy hierarchies (e.g. `ProtectedItem` → workload-specific subtypes, and
  `Job` → job-specific subtypes) that carry discriminator info at more than one inheritance level.
- **Why suppress:** the multi-level shape is exactly how 2023-01-15 modeled these polymorphic trees;
  collapsing levels would restructure the emitted schemas.
- **Verdict:** legacy multi-level polymorphism. Disable.

### T4. `@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers`
- **Rule wants:** every object-array declares `x-ms-identifiers` (which field(s) uniquely key each element).
- **We have (evidence):** many legacy arrays with no `x-ms-identifiers`, e.g. `restoreFileSpecs`,
  `AzureIaaSVMJob.errorDetails`, `AzureIaaSVMJobExtendedInfo.tasksList`, `healthDetails`, `actionsInfo`.
- **Why suppress:** adding `x-ms-identifiers` changes the emitted swagger bytes (breaks the faithful-diff)
  and the original 2023-01-15 never declared them.
- **Verdict:** legacy arrays. Disable (keeps swagger byte-faithful).

### T5. `@azure-tools/typespec-azure-core/documentation-required`
- **Rule wants:** every model/property/operation has a `@doc` description.
- **We have (evidence):** ~15 of 468 inline properties (plus a few operations) in the frozen contract have
  no description.
- **Why suppress:** inventing descriptions is fine textually, but the frozen source simply doesn't have them
  and we're mirroring it faithfully; forcing docs would diverge from the 2023-01-15 baseline.
- **Verdict:** faithful migration gap. Disable.

### T6. `@azure-tools/typespec-azure-resource-manager/lro-location-header`  *(twin of readme F1 `LroLocationHeader`; CrossRegionRestore_Trigger L131, CrrOperationResults_Get L312)*
- **Rule wants:** an LRO's 202 emits a `Location` header.
- **We have (evidence):** `CrossRegionRestore_Trigger` (POST, `x-ms-long-running=true`) and
  `CrrOperationResults_Get` return a **header-less 202** (see F1 above for the emitted evidence).
- **Why suppress:** frozen header-less 202 pattern; adding the header changes the contract. Suppressed on
  BOTH layers (source rule here + emitted rule F1) so neither the compiler nor LintDiff blocks.
- **Verdict:** legacy header-less 202. Disable.

### T7. `@azure-tools/typespec-azure-resource-manager/no-empty-model` *(AccessTokenBadRequestResponse def L961; empty 400 on RecoveryPoints_GetAccessToken L560)*
- **Rule wants:** no model with zero properties.
- **We have (evidence):** `AccessTokenBadRequestResponse` = `{ "type": "object" }` (empty). It exists solely
  to model the **empty-body 400** on `RecoveryPoints_GetAccessToken` (`{"description":"BadRequest",
  "x-ms-error-response":true}`) — the frozen contract's 400 has no schema.
- **Why suppress:** the empty model is the faithful representation of a bodyless documented 400; giving it
  properties would invent a response body that clients don't receive.
- **Verdict:** intentional empty-body model. Disable.

### T8. `@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes`  *(twin of readme B2 `PostResponseCodes`; RecoveryPoints_GetAccessToken L560, CrossRegionRestore_Trigger L131)*
- **Rule wants:** a POST returns the ARM-standard code set.
- **We have (evidence):** `RecoveryPoints_GetAccessToken` returns a documented **400**, and
  `CrossRegionRestore_Trigger` is an LRO POST with 200/202 no-body (see B2).
- **Why suppress:** both are frozen POST shapes. Suppressed on both layers (source here + emitted B2).
- **Verdict:** legacy POST shapes. Disable.

### T9. `@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint`  *(twin of readme F2 `OperationsAPIImplementation`)*
- **Rule wants:** the RP defines an `Operations` list operation.
- **We have:** none — the shared `Microsoft.RecoveryServices` operations list lives in the sibling
  RecoveryServices/RecoveryServicesBackup specs, not in this CRR passive-stamp surface.
- **Why suppress:** adding one here duplicates/collides with the sibling and adds a path not in the frozen
  CRR contract. Suppressed on both layers (source here + emitted F2).
- **Verdict:** served by the shared RP elsewhere. Disable.

### T10. `@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation`  *(twin of readme A3 `AllTrackedResourcesMustHaveDelete`; BackupResourceConfigResource L2234, RecoveryPointResource L4581)*
- **Rule wants:** a resource exposes a DELETE.
- **We have (evidence):** the vault storage config singleton (`BackupResourceConfigResource`, GET/PUT/PATCH)
  and read-only `RecoveryPointResource` have **no DELETE** in the frozen contract.
- **Why suppress:** these are configure-once / read-only resources; the 2023-01-15 contract never exposed
  DELETE. Suppressed on both layers (source here + emitted A3).
- **Verdict:** no legacy DELETE. Disable.

### T11. `@azure-tools/typespec-azure-resource-manager/no-response-body` *(CrrOperationResults_Get L312, CrossRegionRestore_Trigger L131)*
- **Rule wants:** a successful read/operation returns a body.
- **We have (evidence):** the CRR operation-result read `CrrOperationResults_Get` returns an **empty 200**
  (no schema), and `CrossRegionRestore_Trigger`'s 200/202 are body-less — the frozen "poll returns empty
  200 until done" pattern.
- **Why suppress:** the empty 200 IS the contract; adding a body invents data clients don't get.
- **Verdict:** legacy empty-body 200. Disable.

## Cross-layer map (which of the 11 pair with a readme rule)

| tspconfig rule (source) | Pairs with readme rule (emitted) |
|---|---|
| T6 lro-location-header | F1 LroLocationHeader |
| T8 arm-post-operation-response-codes | B2 PostResponseCodes |
| T9 missing-operations-endpoint | F2 OperationsAPIImplementation |
| T10 no-resource-delete-operation | A3 AllTrackedResourcesMustHaveDelete |
| T1 casing-style | (source-only) |
| T2 no-string-discriminator | (source-only) |
| T3 no-multiple-discriminator | (source-only) |
| T4 missing-x-ms-identifiers | (source-only) |
| T5 documentation-required | (source-only) |
| T7 no-empty-model | (source-only) |
| T11 no-response-body | (source-only) |

**Why some rules need suppressing on BOTH layers:** the same legacy trait (e.g. a header-less 202) violates
a TypeSpec *source* rule AND an emitted-swagger *LintDiff* rule. The compiler check would block the build;
the LintDiff check would block the PR. So we disable it in both places.

---

## FINAL COVERAGE CHECKLIST (verified 2026-07-28)

- ✅ **23 / 23** readme LintDiff `directive:` suppressions documented with evidence (entries A1–F2).
- ✅ **11 / 11** tspconfig `linter.disable` rules documented with evidence (entries T1–T11).
- ✅ Cross-layer twins mapped (4 rules suppressed on both layers).
- ✅ Every entry states: what the rule wants / what we actually have (with bms.json evidence) / why we
  can't fix it / verdict.
- ✅ Root-cause buckets: 6 false positives, 16 faithful legacy shapes, 1 benign accepted gap
  (ResourceHasXMsResourceEnabled), plus the 11 source-side rules all rooted in the frozen 2023-01-15 contract.

**Nothing left undocumented.** Every suppression and every disabled lint rule in both config files now has a
plain-English, evidence-backed explanation in this file.
