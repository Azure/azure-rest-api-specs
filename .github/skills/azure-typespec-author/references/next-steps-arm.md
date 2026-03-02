# TypeSpec ARM Authoring - Next Steps

This document covers **Step 6: Follow-up Actions** after TypeSpec ARM authoring is complete.

## Workflow Overview

| Sub-step | Applies To | Goal |
|----------|-----------|------|
| [6.1 Verify Examples](#step-61-verify-examples) | All cases | Ensure example files are up-to-date |
| [6.2 Case-Specific Follow-up](#step-62-case-specific-follow-up) | Cases 1 & 2 only | Present targeted next steps based on completed case |

> **Note**: Only **Case 1 (Add New Preview Version)** and **Case 2 (Add New Stable Version)** have case-specific follow-up actions. For all other cases (e.g., Case 3: Add New Resource Type), skip Step 6.2 — confirm completion and ask if the user has additional requests.

---

## Step 6.1: Verify Examples

**Goal**: Ensure example files are consistent with the current API version and operations.

**Actions**:

1. Check that all example files under the `examples/` folder are present and match the current API version and operations
2. If examples are missing, outdated, or incorrect → **repeat from Step 1** to retrieve a new authoring plan specifically for updating examples

---

## Step 6.2: Case-Specific Follow-up

**Routing Logic**:

| Completed Case | Action |
|----------------|--------|
| Case 1: Add New Preview Version | → [Case 1 Follow-up](#case-1-add-new-preview-version) |
| Case 2: Add New Stable Version | → [Case 2 Follow-up](#case-2-add-new-stable-version) |
| Any other case | → Display completion message and ask for additional requests |

**Output (no matching case)**:

```
✅ Changes have been applied and validated successfully.

Do you have any additional requests, or are you done?
```

---

### Case 1: Add New Preview Version

**Follow-up Prompt**:

```
✅ Preview version [version] has been added successfully.

What would you like to add to this preview version? For example:
- "Add Widget resource with CRUD operations"
- "Add restart action to Employee resource"
- "Add email property to EmployeeProperties"
- "Add EmployeeStatus enum"
- "Add nested Certificate resource under Employee"
- "Mark city property as removed"

Type your request, or "done" if no additional changes needed:
```

---

### Case 2: Add New Stable Version

**Step A — Breaking Change Check**:

Compare changes against the latest stable version. Flag any of the following:

| Breaking Change Category | Examples |
|--------------------------|----------|
| Removed/renamed properties | `displayName` → `name` |
| Changed property types | `string` → `int32` |
| Changed required/optional | Optional → required |
| Removed resources/operations | Deleted `Widget_Delete` |
| Changed response codes/schemas | `200` → `204` |
| Removed enum/union members | Removed `Running` from `Status` |

**Output (breaking changes found)**:

```
⚠️ Breaking Change Review (Stable Version)

The following potential breaking changes were detected:

1. [Description]
   - File: [file]
   - Impact: [what clients/SDKs may be affected]

⚠ Breaking changes in stable versions require careful consideration.
  Please review and confirm these are intentional.
```

**Output (no breaking changes)**:

```
✅ No breaking changes detected for stable version [version].
```

**Step B — Preview Feature Promotion**:

```
✅ Stable version [version] has been added successfully.

I'll review the latest preview version features for your confirmation.

Available preview features to promote:
- [List of features from latest preview version]

Would you like to carry forward ALL of these features to stable?
- Type "yes" to promote all features
- Or specify which features to EXCLUDE: "all except [feature]"
```

**Step C — Additional Changes**:

```
What would you like to add to this stable version? For example:
- "Add Widget resource with CRUD operations"
- "Add restart action to Employee resource"
- "Add email property to EmployeeProperties"
- "Add EmployeeStatus enum"

Type your request, or "done" if no additional changes needed:
```
