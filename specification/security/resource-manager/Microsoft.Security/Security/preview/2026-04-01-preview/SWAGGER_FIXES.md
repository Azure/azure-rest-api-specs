# Swagger LintDiff Fixes — 2026-04-01-preview

This document describes the swagger changes made to pass LintDiff validation and the corresponding controller code changes required.

## 1. InitiateScan — LRO Extension + Location Header

**Swagger fix:** Added `x-ms-long-running-operation: true`, `x-ms-long-running-operation-options` with `final-state-via: location`, and a `Location` response header to the 202 response of the `InitiateScan` POST operation.

**Controller change required:**
- The `InitiateScan` action must return a `Location` header in the 202 response pointing to the `GetScanOperationResult` endpoint URL.
- Example: `Location: /{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/scans/scanOperationResults/{operationId}`
- The controller should ensure the polling URL is correct so clients can track the LRO status.

**File:** `sqlVulnerabilityAssessmentsScanOperations.json`

---

## 2. GetScanOperationResult — Parameter Order

**Swagger fix:** Reordered parameters so `resourceId` comes before `operationId`, matching their order in the URL path.

**Controller change required:** None. This is a swagger metadata fix only — the actual HTTP request is unchanged.

**File:** `sqlVulnerabilityAssessmentsScanOperations.json`

---

## 3. ScanV2, SqlVulnerabilityAssessmentScanOperationResult — Extend Resource

**Swagger fix:** Changed these models to use `allOf` extending `./common/v1/types.json#/definitions/Resource` instead of defining `id`, `name`, `type` inline. This makes them proper ARM resources with `readOnly` id/name/type and `x-ms-azure-resource: true`.

**Controller change required:** None. The controller should already be returning `id`, `name`, and `type` in these models. The swagger now correctly marks them as read-only ARM resource properties.

**File:** `sqlVulnerabilityAssessmentsScanOperations.json`

---

## 4. SqlVulnerabilityAssessmentSettings — Extend Resource + PUT Body

**Swagger fix:**
- Changed `SqlVulnerabilityAssessmentSettings` to use `allOf` extending Resource (fixes `RequiredPropertiesMissingInResourceModel` and `XmsResourceInPutResponse`).
- Changed the PUT operation request body from `SqlVulnerabilityAssessmentSettingsInput` to `SqlVulnerabilityAssessmentSettings` (fixes `PutRequestResponseSchemeArm`).

**Controller change required:** Minimal. Since `id`, `name`, `type` are `readOnly`, they are ignored in the request body. The actual request payload shape remains `{ "properties": { "state": "Enabled" } }` — same as before. The controller's deserialization model should still work. Verify that:
- The controller accepts a `SqlVulnerabilityAssessmentSettings` model (or equivalent) for the PUT body
- ReadOnly fields (`id`, `name`, `type`, `creationTime`) are ignored in the input

**File:** `sqlVulnerabilityAssessmentsSettingsOperations.json`

---

## 5. BaselineRules PUT — Request/Response Schema Match

**Swagger fix:**
- Changed PUT request body from `RuleResultsInput` to `RuleResults` (which extends Resource).
- Added `latestScan` property to `RuleResultsProperties` so the PUT input can include it.
- Updated all PUT example files to wrap `latestScan` and `results` inside a `properties` envelope.

**Controller change required:** **This is a breaking change to the request body shape.**
- **Before:** `{ "latestScan": false, "results": [["value1", "value2"]] }`
- **After:**  `{ "properties": { "latestScan": false, "results": [["value1", "value2"]] } }`

The controller must:
1. Accept the new ARM resource envelope format with `properties` wrapper for the PUT body.
2. Deserialize `latestScan` and `results` from `body.properties` instead of directly from `body`.
3. Continue returning the full `RuleResults` resource envelope in the response (already does this).

**File:** `sqlVulnerabilityAssessmentsBaselineRuleOperations.json`

---

## 6. PathForResourceAction — InitiateScan (Suppressed)

**Issue:** The path `/{resourceId}/.../scans/initiateScan` doesn't follow ARM action naming conventions. ARM expects actions to be at the resource level, not nested under a child resource collection.

**Swagger fix:** Added suppression in `readme.md` — no path change made.

**Controller change (optional, for future):** Consider moving the action to `/{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/initiateScan` or using the ARM action convention `/{resourceId}/.../scans:initiateScan`. This would require updating the controller route attribute.

---

## 7. PathForNestedResource — GetScanOperationResult (Suppressed)

**Issue:** The path `/{resourceId}/.../scans/scanOperationResults/{operationId}` doesn't follow ARM nested resource naming conventions.

**Swagger fix:** Added suppression in `readme.md` — no path change made.

**Controller change (optional, for future):** Consider restructuring the path to follow ARM conventions, e.g., `/{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/scanOperationResults/{operationId}`.

---

## 8. ScansV2 — RequiredPropertiesMissingInResourceModel (Suppressed)

**Issue:** The `ScansV2` list wrapper model was flagged for missing `id`, `name`, `type`. This is a false positive — list wrapper models contain a `value` array of resource items (ScanV2), but the wrapper itself is not a resource.

**Swagger fix:** Added suppression in `readme.md`.

**Controller change required:** None.

---

## Summary of Controller Changes

| Priority | Change | File/Method | Breaking? |
|----------|--------|-------------|-----------|
| **Required** | Return `Location` header in InitiateScan 202 response | ScanController.InitiateScan | No |
| **Required** | Accept `{ properties: { latestScan, results } }` in BaselineRules PUT | BaselineRuleController.CreateOrUpdate | **Yes** |
| **Verify** | Settings PUT body accepts Resource envelope | SettingsController.CreateOrUpdate | No |
| Optional | Move InitiateScan to ARM-compliant action path | ScanController route | Yes |
| Optional | Restructure scanOperationResults path | ScanController route | Yes |
