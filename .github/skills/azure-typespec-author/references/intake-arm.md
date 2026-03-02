# TypeSpec ARM Authoring - Intake and Clarification

This document covers **Step 1: Intake and Clarification** for TypeSpec ARM authoring workflows. Complete all sub-steps below to collect the required information before proceeding to implementation.

**Workflow overview:**

| Sub-step | Goal | Mandatory? |
|----------|------|------------|
| [1.1 Analyze Project](#step-11-analyze-the-typespec-project) | Gather project inputs | Yes |
| [1.2 Identify Case](#step-12-identify-supported-case) | Match request to a supported case | Yes |
| [1.3 Display Results](#step-13-display-analysis-results) | Show analysis summary to user | Yes |
| [1.4 Case-Specific Questions](#step-14-case-specific-intake-questions) | Collect additional inputs per case | Only if matched |
| [1.5 Confirm & Proceed](#step-15-summary-and-confirmation) | Confirm collected information | Yes |

---

## Step 1.1: Analyze the TypeSpec Project

> **Prerequisite**: Before asking any case-specific questions, ALWAYS complete this step first.

**Goal**: Understand the current TypeSpec project structure and gather all required inputs.

### Required Inputs Checklist

Ask if any of the following are missing:

| # | Input | Example |
|---|-------|---------|
| 1 | **Spec root / folder** | `/specification/widget/resource-manager/Microsoft.Widget/Widget` |
| 2 | **Path to tspconfig.yaml** | `<spec-root>/tspconfig.yaml` |
| 3 | **Service type** | management-plane / data-plane |
| 4 | **Existing API versions** | `2024-01-01 (stable)`, `2024-06-01-preview (preview)` |
| 5 | **Latest API version** | Most recent entry in the `Versions` enum |
| 6 | **Current working API version** | The version being added or modified this session |
| 7 | **Intent** | add / modify / fix |
| 8 | **Target resource/interface/operation** | Resource or operation name (if known) |
| 9 | **Constraints** | Breaking-change limits, naming rules, emitter targets, etc. |

If any input is missing, ask **up to 6 concise questions** and stop.

---

## Step 1.2: Identify Supported Case

**Goal**: Determine which authoring case the user needs.

Check whether the user's request falls into one of the supported cases:

| Case | Name | Category | Description |
|------|------|----------|-------------|
| 1 | [Add New Preview Version](#case-1-add-new-preview-version) | Versioning | Add a new preview API version to the `Versions` enum |
| 2 | [Add New Stable Version](#case-2-add-new-stable-version) | Versioning | Promote to a new stable API version |
| 3 | [Add New Resource Type](#case-3-add-new-resource-type) | ARM Template | Define a new ARM resource with operations |

> **Note**: Cases 1–2 are **end-to-end user stories** — adding a new version typically triggers follow-up feature requests (adding resources, operations, models, etc.). The agent should proactively ask the user what features to add after the version is created.

### Routing Logic

- **Matched a supported case** → Proceed to the corresponding case section in [Step 1.4](#step-14-case-specific-intake-questions) to gather additional inputs.
- **No match** → Skip case-specific questions. Proceed directly to **Step 2: Retrieve Solution** using information from Step 1.1 and the user's original request.

---

## Step 1.3: Display Analysis Results

> **MANDATORY**: You MUST always display this output before proceeding. Do NOT skip this step.

**Goal**: Output the analysis results from Step 1.1 and the selected case from Step 1.2.

```
📊 TypeSpec Project Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Spec Root / Folder: /path/to/project
Path to tspconfig.yaml: /path/to/project/tspconfig.yaml
Service Type: management-plane

Existing API Versions:
  ✓ 2024-01-01 (stable)
  ✓ 2024-06-01-preview (preview)

Latest API Version: 2024-06-01-preview (preview)
Current Working API Version: [To be determined based on user request]

Intent: [add/modify/fix]
Target Resource/Interface/Operation: [if known]
Constraints: [breaking-change limits, naming/versioning rules, emitter targets, etc.]

Selected Case: [Case Name or "No matching supported case identified"]
```

---

## Step 1.4: Case-Specific Intake Questions

> Only ask these questions if the user's request matched a supported case in Step 1.3.

Each case follows a consistent structure:

1. **Context** — Pre-filled from analysis
2. **Questions** — Additional inputs to collect
3. **Validation** — Rules to check before proceeding
4. **Collected Data** — JSON schema of all gathered information

---

### Case 1: Add New Preview Version

> This is an **end-to-end user story** — after the version is created, the agent should ask what features to add to it.

#### Example Prompts

- `add a new preview API version 2025-10-01-preview for service widget resource management`
- `add a new preview version 2025-03-01-preview`

#### Context

- Latest version: [version] ([preview/stable])
- Existing resources: [list from analysis]

#### Questions

```
1. What is the new preview version you want to add?
   Format: YYYY-MM-DD-preview
   Example: 2025-03-01-preview

2. What is the latest version type in your project?
   □ Preview (e.g., 2024-06-01-preview)
   □ Stable (e.g., 2024-06-01)
```

#### Version Replacement Logic

The behavior depends on the latest existing version type:

| Latest version type | Action |
|---------------------|--------|
| **Preview** | **Replace** the latest preview version with the new one in the `Versions` enum (rename, don't add alongside). Update all references including the `examples/` folder name. |
| **Stable** | **Add** the new preview version as a new entry in the `Versions` enum after the stable version. |

The new preview version entry MUST be decorated with `@previewVersion`. Example:

```typespec
/** 2025-10-01-preview version */
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@previewVersion
v2025_10_01_preview: "2025-10-01-preview",
```

#### Expected Agent Activity After Version Creation

After the version enum is updated, the agent should:

1. Update the `examples/` folder to match the new version
2. Handle types from the previous preview:
   - If a type from the latest preview is **not** in the new preview → simply remove it
   - If other types are removed → mark with `@removed` decorator referencing the new version
   - If types are added, renamed, or modified → mark with appropriate versioning decorators (`@added`, `@removed`, `@renamedFrom`, etc.)
3. **Proactively ask** what features to add to this version:
   ```
   What would you like to add to this preview version? For example:
   - Add new resources
   - Add new operations to an existing resource
   - Add/modify properties on an existing resource
   - Add new models, unions, or enums
   - Deprecate/remove resources, operations, or models
   ```

#### Validation

- Version format: `YYYY-MM-DD-preview`
- Date is not in the past
- Version doesn't already exist in versions enum

#### Collected Data

```json
{
  "case": "add-new-preview-version",
  "namespace": "[from analysis]",
  "projectPath": "[from analysis]",
  "currentLatestVersion": "[from analysis]",
  "currentLatestVersionType": "preview|stable",
  "newVersion": "[user input]",
  "versionAction": "replace|add"
}
```

---

### Case 2: Add New Stable Version

> This is an **end-to-end user story** — after the version is created, the agent should review preview features and ask what to carry forward.

#### Example Prompts

- `add a new stable API version 2025-10-01 for service widget resource management`
- `promote to stable version 2025-06-01`

#### Context

- Latest version: [version] ([preview/stable])
- Preview features to review: [list features introduced in preview versions]

#### Questions

```
1. What is the new stable version you want to add?
   Format: YYYY-MM-DD
   Example: 2025-06-01

2. Are there any preview features that should NOT be carried into stable?
   □ No, promote all preview changes to stable
   □ Yes (specify which features/properties to exclude)
```

#### Version Strategy

Add the new stable version as a new entry in the `Versions` enum. Do NOT use `@previewVersion`. Example:

```typespec
/** 2025-10-01 version */
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
v2025_10_01: "2025-10-01",
```

#### Expected Agent Activity After Version Creation

After the version enum is updated, the agent should:

1. **Review all preview-only features** — list resources, operations, models, unions, and enums that were introduced in preview versions
2. **Remove preview features not carried over** — resources, operations, models, unions, or enums that are not promoted to stable should be removed or marked with `@removed`
3. Update the `examples/` folder to match the new stable version
4. **Proactively ask** what features to add to this version:
   ```
   What would you like to add to this stable version? For example:
   - Add new resources
   - Add new operations to an existing resource
   - Add/modify properties on an existing resource
   - Add new models, unions, or enums
   - Remove resources, operations, or models
   ```

#### Validation

- Version format: `YYYY-MM-DD` (no `-preview` suffix)
- Date is not in the past
- Version doesn't already exist in versions enum
- A preview version should exist before promoting to stable

#### Collected Data

```json
{
  "case": "add-new-stable-version",
  "namespace": "[from analysis]",
  "projectPath": "[from analysis]",
  "currentLatestVersion": "[from analysis]",
  "newVersion": "[user input]",
  "excludeFromPromotion": [],
  "previewFeatures": "[list of features from preview versions]"
}
```

---

### Case 3: Add New Resource Type

#### Example Prompts

- `add a new ARM resource type named 'Asset' with CRUD operations`
- `add a nested resource 'Certificate' under Employee`

#### Context

- Latest version: [version] ([preview/stable])
- Existing resources: [list]

#### Questions

```
1. Which API version(s) should include this new resource?
   □ Latest version only ([version])
   □ Multiple versions (specify)

2. What is the resource type name?
   Format: PascalCase (e.g., Widget, VirtualMachine)

3. What is the resource base type?
   □ TrackedResource — Azure resource with location and tags (most common for top-level)
   □ ProxyResource — Azure resource without location and tags (common for nested/child)

4. Is this a top-level resource or nested under a parent?
   □ Top-level (e.g., /subscriptions/.../resourceGroups/.../providers/Microsoft.Service/resources/{name})
   □ Nested (e.g., /.../{parentName}/childResources/{name})

   If nested, what is the parent resource? [show existing resources]

5. What properties should this resource have?
   (Provide property name, type, required/optional, description)

6. Which CRUD operations should be included?
   □ get (ArmResourceRead)
   □ createOrUpdate (ArmResourceCreateOrReplaceAsync — LRO by default)
   □ update/patch (ArmResourcePatchAsync)
   □ delete (ArmResourceDeleteWithoutOkAsync — LRO by default)
   □ listByResourceGroup (ArmResourceListByParent)
   □ listBySubscription (ArmListBySubscription) — top-level only

7. Should any operations be long-running (LRO)?
   □ createOrUpdate → sync or async?
   □ delete → sync or async?
   □ Any custom actions that are LRO?
```

#### ARM Template Pattern

The generated resource MUST follow ARM TypeSpec patterns:

```typespec
// Resource model
model Asset is TrackedResource<AssetProperties> {
  ...ResourceNameParameter<Asset>;
}

// Operations interface with @armResourceOperations
@armResourceOperations
interface Assets {
  get is ArmResourceRead<Asset>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Asset>;
  update is ArmResourcePatchAsync<Asset, AssetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Asset>;
  listByResourceGroup is ArmResourceListByParent<Asset>;
  listBySubscription is ArmListBySubscription<Asset>;
}
```

For **child/nested resources**, use the `@parentResource` decorator:

```typespec
@parentResource(Employee)
model Certificate is ProxyResource<CertificateProperties> {
  ...ResourceNameParameter<Certificate>;
}
```

#### Validation

- Resource name is PascalCase
- Confirm top-level vs child resource
- If child resource, parent resource must be provided and must use `@parentResource`
- Top-level tracked resources MUST have `listByResourceGroup` and `listBySubscription`

#### Collected Data

```json
{
  "case": "add-new-resource-type",
  "namespace": "[from analysis]",
  "targetVersions": ["[version]"],
  "resourceName": "[user input]",
  "resourceBaseType": "TrackedResource|ProxyResource",
  "isNested": true/false,
  "parentResource": "[if nested]",
  "operations": {
    "get": true,
    "createOrUpdate": { "enabled": true, "isLRO": true },
    "patch": { "enabled": true, "isLRO": true },
    "delete": { "enabled": true, "isLRO": true },
    "listBySubscription": true,
    "listByResourceGroup": true
  },
  "properties": []
}
```

---

## Step 1.5: Summary and Confirmation

After collecting all information, display a comprehensive summary and wait for user confirmation before proceeding.

```
✅ Information Collection Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Case: [Case Name]

Project Information:
  Namespace: [namespace]
  Project Path: [path]
  Current Latest Version: [version] ([preview/stable])

Requested Changes:
  [Summary of user inputs]

Target Version(s): [versions]

Ready to Proceed: YES

Is this information correct? (yes/no)
```

Once confirmed, proceed to Step 2: Retrieve Solution.

```
✅ All required information collected.
Ready to proceed to Step 2: Retrieve Solution

Next actions:
1. Call azsdk_typespec_retrieve_solution with collected information
2. Apply recommended changes to TypeSpec files
3. Validate compilation results
```

---

## Appendix: Common Validation Rules

Quick reference for validation rules that apply across all cases.

### General

- Service namespace follows `Microsoft.ServiceName` pattern
- TypeSpec project path exists and contains `tspconfig.yaml` and `main.tsp`
- Target API version is valid format

### Version Formats

| Type | Format | Example |
|------|--------|---------|
| Preview | `YYYY-MM-DD-preview` | `2025-03-01-preview` |
| Stable | `YYYY-MM-DD` | `2025-03-01` |

- Date must not be in the past (current date is allowed)

### Naming Conventions

| Element | Casing | Example |
|---------|--------|---------|
| Resource types | PascalCase | `Widget`, `VirtualMachine` |
| Operations / Actions | camelCase | `start`, `listByResourceGroup` |
| Models / Enums / Unions | PascalCase | `WidgetProperties`, `ProvisioningState` |
| Properties | camelCase | `displayName`, `provisioningState` |

### Breaking Change Rules

| Version type | Breaking changes |
|--------------|-----------------|
| Preview | Allowed |
| Stable | Require careful consideration and clear justification |
