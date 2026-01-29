# TypeSpec ARM Authoring - Intake and Clarification

This document focuses on Step 1: Intake and Clarification for TypeSpec ARM authoring workflows. It collects all necessary information before moving forward with implementation.

## Universal Intake Requirement (All Cases)

**Before asking any case-specific questions, ALWAYS complete these steps:**

### Step 1.1: Analyze the Codebase

**Goal**: Understand the current TypeSpec project structure

**Actions**:

1. Locate the TypeSpec project files (main.tsp, tspconfig.yaml)
2. Read and parse the main.tsp file to identify:
   - Service namespace
   - Versions enum and all API versions
   - Existing resources and their operations
   - Existing models, enums, and unions
3. Determine the project structure and file organization

**Output**: Display analysis results:

```
📊 TypeSpec Project Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Namespace: Microsoft.ServiceName
Project Path: /path/to/tspconfig.yaml

API Versions:
  ✓ 2024-01-01 (stable)
  ✓ 2024-06-01-preview (preview)

Latest Version: 2024-06-01-preview (preview)

Existing Resources:
  • ResourceType1
  • ResourceType2

Existing Models: [count]
Existing Enums: [count]
```

---

### Step 1.2: Identify Latest Version Type

**Goal**: Determine if the latest version is preview or stable

**Actions**:

- Check if the latest version string contains "-preview"
- Verify with version enum decorators (@previewVersion)

**Output**:

```
🔍 Latest Version Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Version: 2024-06-01-preview
Type: PREVIEW

This means:
• Breaking changes are allowed
• Can add/modify features freely
• Target for new development
```

---

## Case-Specific Intake Questions

After completing Steps 1.1 and 1.2, proceed with case-specific questions based on the user's scenario.

---

### Case: Add New Preview Version

**Context from Analysis**: Latest version is [version] ([preview/stable])

**Additional Questions to Ask**:

```
1. What is the new preview version you want to add?
   Format: YYYY-MM-DD-preview
   Example: 2025-03-01-preview

```

**Validation**:

- Version format: YYYY-MM-DD-preview
- Date is not in the past
- Version doesn't already exist in versions enum

**Information Collected**:

```json
{
  "case": "add-new-preview-version",
  "namespace": "[from analysis]",
  "projectPath": "[from analysis]",
  "currentLatestVersion": "[from analysis]",
  "newVersion": "[user input]"
}
```

---

### Case: Add New Stable Version

**Context from Analysis**: Latest version is [version] ([preview/stable])

**Additional Questions to Ask**:

```
1. What is the new stable version you want to add?
   Format: YYYY-MM-DD
   Example: 2025-03-01

2. Is this promoting an existing preview version to stable?
   □ Yes - Which preview version? [show available preview versions]
   □ No - This is a new stable version

```

**Validation**:

- Version format: YYYY-MM-DD (no -preview suffix)
- Date is not in the past
- If promoting from preview, source version must exist

**Information Collected**:

```json
{
  "case": "add-new-stable-version",
  "namespace": "[from analysis]",
  "projectPath": "[from analysis]",
  "currentLatestVersion": "[from analysis]",
  "newVersion": "[user input]",
  "sourcePreviewVersion": "[if applicable]"
}
```

---

### Case: Add New Resource Type

**Context from Analysis**:

- Latest version: [version] ([preview/stable])
- Existing resources: [list]

**Additional Questions to Ask**:

```
1. Which API version(s) should include this new resource?
   □ Latest version only ([version])
   □ Multiple versions (specify)

2. What is the resource type name?
   Format: PascalCase (e.g., Widget, VirtualMachine)

3. Is this a top-level resource or nested under a parent?
   □ Top-level (e.g., /subscriptions/.../resourceGroups/.../providers/Microsoft.Service/resources/{name})
   □ Nested (e.g., /.../{parentName}/childResources/{name})

   If nested, what is the parent resource? [show existing resources]

4. What properties should this resource have?
   (Provide property name, type, required/optional, description)
```

**Validation**:

- Resource name is PascalCase
- If nested, parent resource exists

**Information Collected**:

```json
{
  "case": "add-new-resource-type",
  "namespace": "[from analysis]",
  "targetVersions": ["[version]"],
  "resourceName": "[user input]",
  "isNested": true/false,
  "parentResource": "[if nested]",
  "operations": {
    "get": true,
    "put": { "enabled": true, "isLRO": false },
    "patch": false,
    "delete": { "enabled": true, "isLRO": true },
    "listBySubscription": false,
    "listByResourceGroup": true
  },
  "properties": []
}
```

---

## Summary and Confirmation

After collecting all information, display a comprehensive summary:

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

Wait for user confirmation before proceeding to next steps.

---

## Next Steps

Once information is confirmed:

```
✅ All required information collected.
Ready to proceed to Step 2: Retrieve Solution

Next actions:
1. Call azsdk_typespec_retrieve_solution with collected information
2. Apply recommended changes to TypeSpec files
3. Validate compilation results
```

---

## Common Validation Rules

### For All Cases

- Service namespace follows Microsoft.ServiceName pattern
- TypeSpec project path exists and contains tspconfig.yaml and main.tsp
- Target API version is valid format

### Version Format Validation

- Preview: YYYY-MM-DD-preview (e.g., 2025-03-01-preview)
- Stable: YYYY-MM-DD (e.g., 2025-03-01)
- Date must not be in the past (allow current date)

### Naming Conventions

- Resource types: PascalCase (e.g., Widget, VirtualMachine)
- Operations/Actions: camelCase (e.g., start, listByResourceGroup)
- Models/Enums/Unions: PascalCase (e.g., WidgetProperties, ProvisioningState)
- Properties: camelCase (e.g., displayName, provisioningState)

### Breaking Change Rules

- Preview versions: Breaking changes allowed
- Stable versions: Breaking changes require careful consideration and clear justification
