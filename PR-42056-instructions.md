# PR #42056 - Remaining Changes Instructions

## Overview

PR: https://github.com/Azure/azure-rest-api-specs/pull/42056
Branch: `detailLevelParameterNew` (EugenioPena fork)
Base branch: `Azure:release-microsoft-network-2025-07-01` (commit `3120c351f1`)
Repo: `c:\rest-api-specs` (azure-rest-api-specs)

This PR adds a `detailLevel` query parameter to the Load Balancer GET operation in the Network TypeSpec project. ARM reviewer **@ravimeda** requested changes with 3 blocking issues and 2 warnings. Some changes were partially applied but the models.tsp edit failed due to tooling issues. All changes below must be applied to the TSP source files, then TSP must be recompiled to regenerate the swagger output.

## Current Git State

- Branch `detailLevelParameterNew` has 8 commits ahead of origin
- Last pushed commit on origin: `b6efcdc7c4` ("Fix readme.md: remove duplicate tag section and correct suppression placement")  
- Local HEAD: `ab69225c02` ("Add MULTIPLE_API_VERSION suppression for pre-existing vmssNetwork.json in default tag")
- Working tree may have partially applied changes from previous session — **check `git status` and `git diff` first**

## Files That Need Changes (5 changes across 4 files)

### 1. `specification/network/resource-manager/Microsoft.Network/Network/readme.md`

**Change: Fix suppression reason and add `where` clause (Blocking issues #1 and #2)**

The `ParametersInPointGet` suppression in the `package-2025-07-01` tag section needs to be updated. Find this block in the suppressions list (inside the ` ```yaml $(tag) == 'package-2025-07-01' ` code block):

**Current (wrong):**
```yaml
  - code: ParametersInPointGet
    from: loadBalancer.json
    reason: Want to add extra parameter for GET Load Balancer operation. This parameter "detailLevel" is extremely important so customers can query big resources, without having a huge performance impact on our RP infrastructure.
```

**Replace with:**
```yaml
  - code: ParametersInPointGet
    from: loadBalancer.json
    where:
      - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}'].get.parameters[?(@.name=='detailLevel')]
    reason: The "detailLevel" query parameter is critical for reducing expensive GET operations on large Load Balancer resources. The corresponding RP-side change is already implemented. Approved in ARM Office Hours by Gary Li on 2/13/2025.
```

**NOTE:** This change may have already been applied in the previous session. Check file contents first.

Also verify the global yaml config block (around lines 26-34) has the `MULTIPLE_API_VERSION` directive suppression — this was added in commit `ab69225c02`:
```yaml
directive:
  - suppress: MULTIPLE_API_VERSION
    reason: The vmssNetwork.json (2018-10-01) is required in the default tag alongside 2025-07-01 swaggers for backward compatibility.
```

### 2. `specification/network/resource-manager/Microsoft.Network/Network/Network/models.tsp`

**Change: Enum value casing from `reduced` to `Reduced` (Blocking issue #3)**

Find the `LoadBalancerDetailLevel` union. There should be exactly ONE occurrence (around line 2014, but line numbers may shift). Search for `union LoadBalancerDetailLevel`.

**Current (wrong):**
```tsp
/**
 * Controls verbosity of the returned load balancer resource.
 */
union LoadBalancerDetailLevel {
  string,

  /** When set to 'reduced', read-only reference collections may be omitted. */
  reduced: "reduced",
}
```

**Replace with:**
```tsp
/**
 * Controls verbosity of the returned load balancer resource.
 */
union LoadBalancerDetailLevel {
  string,

  /** When set to 'Reduced', read-only back-reference collections (e.g., rules referencing frontendIPConfigurations) are omitted from the response. */
  Reduced: "Reduced",
}
```

**IMPORTANT:** In earlier sessions, there were duplicate `LoadBalancerDetailLevel` unions in this file (one around line 2090 and another around line 2696). These should have been cleaned up, but **verify there is only ONE** occurrence. If there are two, keep only the first one (which comes after `ExpressRoutePeeringState` union block) and delete the second. The duplicate exists because earlier the user undid edits that had removed it.

**NOTE:** This edit failed in the previous session due to the replace tool not finding the text. The file is 26,000 lines and may have encoding or whitespace issues. If `replace_string_in_file` fails, try reading the exact bytes around the union and matching precisely, or use a terminal sed/powershell command.

### 3. `specification/network/resource-manager/Microsoft.Network/Network/Network/LoadBalancer.tsp`

**Change: Update description wording (Warning #4)**

Find the `detailLevel` parameter definition (around line 57-62):

**Current (wrong):**
```tsp
      /**
       * Controls verbosity of the returned load balancer resource. When set to 'reduced', read-only reference collections may be omitted.
       */
      @added(Versions.v2025_07_01)
      @query("detailLevel")
      detailLevel?: LoadBalancerDetailLevel;
```

**Replace with:**
```tsp
      /**
       * Controls verbosity of the returned load balancer resource. When set to 'Reduced', read-only back-reference collections (e.g., rules referencing frontendIPConfigurations) are omitted from the response.
       */
      @added(Versions.v2025_07_01)
      @query("detailLevel")
      detailLevel?: LoadBalancerDetailLevel;
```

**NOTE:** This change may have already been applied in the previous session. Check file contents first.

### 4. `specification/network/resource-manager/Microsoft.Network/Network/Network/examples/2025-07-01/LoadBalancerGetReduced.json`

**Changes: Fix field ordering + update detailLevel value (Warning #5 + part of #3)**

**Current (wrong):**
```json
{
  "parameters": {
    "subscriptionId": "00000000-0000-0000-0000-000000000000",
    "resourceGroupName": "rg-name",
    "loadBalancerName": "lb-name",
    "api-version": "2025-07-01",
    "detailLevel": "reduced"
  },
  "responses": {
    ...
  },
  "operationId": "LoadBalancers_Get",
  "title": "Get load balancer reduced"
}
```

**Replace with (move title/operationId to top, change "reduced" to "Reduced"):**
```json
{
  "title": "Get load balancer reduced",
  "operationId": "LoadBalancers_Get",
  "parameters": {
    "subscriptionId": "00000000-0000-0000-0000-000000000000",
    "resourceGroupName": "rg-name",
    "loadBalancerName": "lb-name",
    "api-version": "2025-07-01",
    "detailLevel": "Reduced"
  },
  "responses": {
    "200": {
      "body": {
        "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-name/providers/Microsoft.Network/loadBalancers/lb-name",
        "name": "lb-name",
        "type": "Microsoft.Network/loadBalancers",
        "location": "eastus",
        "properties": {
          "provisioningState": "Succeeded",
          "resourceGuid": "00000000-0000-0000-0000-000000000000",
          "frontendIPConfigurations": [
            {
              "name": "frontendConfig1",
              "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-name/providers/Microsoft.Network/loadBalancers/lb-name/frontendIPConfigurations/frontendConfig1",
              "properties": {
                "privateIPAllocationMethod": "Dynamic",
                "provisioningState": "Succeeded"
              }
            }
          ]
        },
        "sku": {
          "name": "Standard",
          "tier": "Regional"
        }
      }
    }
  }
}
```

**NOTE:** This change may have already been applied in the previous session. Check file contents first.

## After All Source Changes: Recompile TSP

Once all 4 source files are updated, recompile the TypeSpec to regenerate the swagger output:

```powershell
cd c:\rest-api-specs
npm ci   # Only if node_modules is missing or stale; uses TypeSpec compiler v1.10.0
cd specification/network/resource-manager/Microsoft.Network/Network/Network
npx tsp compile .
```

This regenerates files under `specification/network/resource-manager/Microsoft.Network/Network/stable/2025-07-01/`:
- `loadBalancer.json` — should now have `"Reduced"` instead of `"reduced"` in the enum and parameter description
- `examples/LoadBalancerGetReduced.json` — should mirror the source example with `"Reduced"` and reordered fields
- `examples/LoadBalancerGet.json` and `examples/LoadBalancerCreate.json` — should remain unchanged (SKU already says "Standard")

## Verification After Compile

1. Check the compiled `loadBalancer.json` for:
   - `"enum": ["Reduced"]` (PascalCase)
   - Updated description text matching the TSP source
   - `LoadBalancerGetReduced.json` x-ms-examples reference

2. Diff against base: `git diff 3120c351f1 --stat` — should show ~10 files changed

3. Check for no other unexpected changes: `git status`

## Commit and Push

**Do NOT amend existing commits.** Create a new commit:

```powershell
git add -A
git commit -m "Address ARM review feedback: fix enum casing, suppression scope, and descriptions"
git push origin detailLevelParameterNew
```

The push should be a regular push (not force push) since we're adding a new commit on top.

## Known Pre-existing Issues (NOT caused by this PR)

1. **AVOCADO `MULTIPLE_API_VERSION`**: The `package-2025-07-01` tag includes `stable/2018-10-01/vmssNetwork.json` alongside 2025-07-01 files. This is from the base branch. We added a `directive` suppression for this in the global yaml config.

2. **.NET SDK `DuplicateSchema` errors**: AutoRest modelerfour fails when merging vmssNetwork.json (2018-10-01) schemas with 2025-07-01 schemas. Pre-existing on the base branch. Not fixable by this PR.

3. **lint-diff `Vmss/stable/2025-05-01/openapi.json` missing file**: Pre-existing on the base branch.

4. **Breaking change labels (Go SDK, JavaScript SDK)**: These are expected for new API version changes in the TypeSpec migration. Pre-existing.

## Context for Enum Casing Decision

The RP code uses case-insensitive comparison:
```csharp
lb.ReducedForm = !string.IsNullOrEmpty(this.Uri?.DecodedUri) 
    && NrpUri.GetValueOfQueryParam(this.Uri.DecodedUri, "detailLevel").EqualsIgnoreCase("reduced");
```
So changing from `"reduced"` to `"Reduced"` in the spec is safe — the RP accepts both.
