# TypeSpec ARM Authoring - Next Steps

This skill focuses on Step 6: Follow-up Actions that occur after TypeSpec ARM authoring tasks are complete. It determines next steps and provides guidance through related changes.

**After completing any TypeSpec authoring case, ALWAYS perform these checks:**

### Step 6.1: Verify Compilation Status

**Goal**: Ensure the changes compile successfully

**Actions**:

1. Check validation results from Step 4
2. Identify any remaining errors or warnings
3. Determine if errors are blocking or informational

**Output**:

```
🔍 Compilation Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ No blocking errors
⚠ [X] warnings (informational only)

Ready for next steps: YES
```

---

### Step 6.2: Identify Related Actions

**Goal**: Determine what additional changes might be needed

**Actions**:

- Analyze what was just completed
- Check for common follow-up scenarios
- Prompt user with relevant next step options

**Output**: Present relevant follow-up options based on case type

---

## Case-Specific Follow-up Actions

Based on the completed case, present targeted follow-up questions.

---

### Case: Add New Preview Version

**Completed**: Added version [version] to Versions enum

**Follow-up Question**:

```
✅ Preview version [version] has been added successfully.

What would you like to add to this preview version? For example:
- "Add Widget resource with CRUD operations"
- "Add restart action to Employee resource"
- "Add email property to EmployeeProperties"
- "Add EmployeeStatus enum"
- "Add nested Certificate resource under Employee"
- "Update Employee to support soft delete"
- "Mark city property as removed"

Type your request, or "done" if no additional changes needed:
```

---

### Case: Add New Stable Version

**Completed**: Added stable version [version] to Versions enum

**Follow-up Question**:

```
✅ Stable version [version] has been added successfully.

⚠️ Important: Stable versions do NOT allow breaking changes.
All additions must maintain backward compatibility.

What would you like to add to this stable version? For example:
- "Add optional email property to Employee" (backward-compatible)
- "Add new exportData action to Employee" (non-breaking)
- "Add EmploymentType enum"
- "Promote all preview features to stable"
- "List preview features that can be promoted"

Type your request, or "done" if no additional changes needed:
```

---
