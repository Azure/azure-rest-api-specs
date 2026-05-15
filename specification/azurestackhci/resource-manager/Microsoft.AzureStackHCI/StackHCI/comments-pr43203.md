# PR #43203 Review Comments — Azure Local, SFF public preview May 2026

Reviewer: **ravimeda** (ARM API reviewer agent)

---

## 1. :red_circle: Blocking — TYPESPEC-VERSIONING / Uniform-Versioning
**File:** `main.tsp`

`v2026_04_01_preview` has been removed from the `Versions` enum, but the swagger directory `preview/2026-04-01-preview/hci.json` and the `package-preview-2026-04-01-preview` tag block in `readme.md` (lines 357-365) still exist. Published API versions must remain regenerable from TypeSpec source.

**Suggested fix:**
- **(a)** Keep `v2026_04_01_preview` in the enum and append `v2026_05_01_preview`. Restore original `@added(v2026_04_01_preview)` decorators in Cluster.tsp, Update.tsp, UpdateSummaries.tsp. Use `@removed(v2026_04_30)` / `@added(v2026_05_01_preview)` for reinstated resources. **OR**
- **(b)** If 04-01-preview is formally retracted, delete the `preview/2026-04-01-preview` directory and the `package-preview-2026-04-01-preview` tag in `readme.md`.

---

## 2. :red_circle: Blocking — TSP-CONFIG-VERSION-REF
**File:** `main.tsp` (affects `tspconfig.yaml`)

`tspconfig.yaml` line 26 has `api-version: "2026-04-01-preview"` which no longer exists in the `Versions` enum after this PR. The C# management SDK emitter will fail.

**Suggested fix:** Update line 26 to:
```yaml
api-version: "2026-05-01-preview"
```
or:
```yaml
api-version: "2026-04-30"
```

---

## 3. :red_circle: Blocking — EX-OPERATION-MISSING (orphan example)
**File:** `examples/2026-05-01-preview/DevicePools_AddDevices_MaximumSet_Gen.json`

Declares `"operationId": "DevicePools_AddDevices"` but no such operation exists in the swagger. Only `DevicePools_ClaimDevices` and `DevicePools_ReleaseDevices` are defined.

**Suggested fix:**
- **(a)** Delete this file if `claimDevices`/`releaseDevices` are the intended operations. **OR**
- **(b)** Add `addDevices`/`removeDevices` operations in `DevicePool.tsp` and regenerate swagger.

---

## 4. :red_circle: Blocking — EX-OPERATION-MISSING (orphan example)
**File:** `examples/2026-05-01-preview/DevicePools_AddDevices_MinimumSet_Gen.json`

Same as #3 — orphan example for non-existent `DevicePools_AddDevices` operation.

---

## 5. :red_circle: Blocking — EX-OPERATION-MISSING (orphan example)
**File:** `examples/2026-05-01-preview/DevicePools_RemoveDevices_MaximumSet_Gen.json`

Declares `"operationId": "DevicePools_RemoveDevices"` but no such operation exists in the swagger.

**Suggested fix:** Same as #3.

---

## 6. :red_circle: Blocking — EX-OPERATION-MISSING (orphan example)
**File:** `examples/2026-05-01-preview/DevicePools_RemoveDevices_MinimumSet_Gen.json`

Same as #5 — orphan example for non-existent `DevicePools_RemoveDevices` operation.

---

## 7. :red_circle: Blocking (existing, carried forward) — EX-PLACEHOLDER-VALUES
**File:** `examples/2026-05-01-preview/DevicePools_CreateOrUpdate.json`

Contains random placeholder gibberish that ships into SDK samples:
- `"resourceUri": "idfnepvcbsqus"` (also extraneous parameter)
- `"type": "bwcgsqpmknwznzsscflmtyccoli"`
- `"createdBy": "rxhpfyokywvjgo"`
- `"location": "dqvhowxljfyykwlraq"`
- `"name": "agdmnmivfouprbqqfmllnvmglaqr"`
- Missing `"tags"` field on tracked resource responses.

**Suggested fix:** Replace with realistic values:
- Remove `resourceUri` (not in operation signature)
- `"type": "Microsoft.AzureStackHCI/devicePools"`
- `"name": "pool-1"`
- `"location": "eastus"`
- `"createdBy": "user1"`, `"lastModifiedBy": "user2"`
- Add `"tags": {}` to 200 and 201 response bodies.

---

## 8. :yellow_circle: Warning — SUPPRESSION-EMPTY-REASON
**File:** `EdgeMachineJobs.tsp`

`#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""` has an empty justification string.

**Suggested fix:**
- **(a)** Add `provisioningState` to `EdgeMachineJobProperties` and remove the suppression. **OR**
- **(b)** Fill in a reason:
```typespec
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "EdgeMachineJob is a job/operation resource — its lifecycle is intentionally tracked via the polymorphic JobStatus + JobReportedProperties shared with ClusterJob, not via a top-level provisioningState."
```

---

## 9. :yellow_circle: Warning — no-enum / OAPI-NO-FREEFORM-STRING-WHEN-ENUM-DOCUMENTED
**File:** `models.tsp`

`HciAddServerJobProperties.witnessType` is typed as plain `string` but docs say only `"Cloud"` or `"FileShare"` allowed. Should be a union (extensible enum).

**Suggested fix:**
```typespec
/** Witness type for an Azure Stack HCI cluster. */
union WitnessType {
  string,
  /** Cloud witness backed by an Azure Storage account. */
  Cloud: "Cloud",
  /** File-share witness on a local SMB share. */
  FileShare: "FileShare",
}
```
Then change `witnessType?: WitnessType;` (also consider applying to `DeploymentCluster.witnessType` at line 3094).

---

## 10. :bulb: Suggestion — SECRET-NAMING-VERIFICATION
**File:** `readme.md`

The `XMSSecretInResponse` suppression for `gpgPubKey` is justified. Optional improvement to tighten the reason text.

**Status:** ✅ Addressed — updated suppression reason to explicitly state the field holds only the GPG public key block for package signature verification.
