# API Review Comments: TypeSpec Implementation Guide

## IMPORTANT: Process Requirements
- **Follow these steps in EXACTLY the following order**
- **Do not skip any part of the process**
- **Explain each step clearly before taking action**
- **Confirm with user before making ANY changes**

## Step 0: Prerequisites
1. **Review these instructions thoroughly**
2. **CONFIRM understanding** by concisely summarizing these instructions

## Step 1: Validate Input Format

**Required markdown format:**
```md
**TSP Folder Location**: specification/<yourservice>/<YourPackage>/
**TSP Git Branch**: <branch name>
**Generated Client API Language**: <language>
**Comments:**
- <API To Change>: <Review comment>
- <API To Change>: <Review comment>
```

**Validation checklist:**
- [ ] TSP folder location provided
- [ ] Git branch specified (must NOT be `main`)
- [ ] Language specified (Python, C#, Java, JavaScript, etc.)
- [ ] All comments listed

## Step 2: Setup Environment
1. **Verify correct Git branch** (must NOT be `main`)
2. **Navigate to TSP folder** using `cd <path-to-tsp-folder>`

## Step 3: Understand Python → TypeSpec Mapping

### Python Client Generation Rules
| TypeSpec Element | Python Output | Example |
|------------------|---------------|---------|
| `namespace Contoso.MyWidget` | `MyWidgetClient` | Last part + "Client" |
| `interface WidgetModels` | `WidgetModelsOperations` | Interface + "Operations" |
| Methods in camelCase | Converted to snake_case | `getWidget` → `get_widget` |

### Critical Rules
- **Main client name** = Last namespace segment + "Client"
- **Operations classes** = Interface name + "Operations" 
- **NEVER** name interfaces ending with "Operations" (creates "OperationsOperations")

## Step 4: Analyze Each Comment

**Use this template for EVERY comment:**
```
**Comment**: [exact quote]
**Python API**: [what Python element is referenced]
**TypeSpec Source**: [which TypeSpec element generates this]
**Action**: [update tspconfig.yaml OR client.tsp OR main.tsp]
**File**: [specific file to modify]
```

## Step 5: Determine Implementation Strategy

### Scenario A: Python Package/Namespace Changes
**Trigger**: Comments about `azure.mynamespace.something` structure
**Action**: Update `tspconfig.yaml`
**Example**: 
```yaml
"@azure-tools/typespec-python":
  package-dir: "azure-newname"
  namespace: "azure.newname"
```

### Scenario B: Python Client Name Changes  
**Trigger**: Comments about `SomeClient` class name
**Action**: Add to `client.tsp`
**Example**:
```tsp
@@clientName(MyNamespace.Data, "WidgetModels", "python");
```

### Scenario C: Python Operations Class Changes
**Trigger**: Comments about `SomeOperations` class name
**Action**: Add to `client.tsp` 
**Example**:
```tsp
@@clientName(MyNamespace.SomeInterface, "NewName", "python");
```

### Scenario D: Universal Changes (All Languages)
**Trigger**: Comments without language specificity
**Action**: Update `main.tsp`, `routes.tsp`, or `models.tsp`

## Step 6: Implementation Rules

### For `tspconfig.yaml` Updates
- **NEVER** remove existing options
- **ONLY** add or modify `@azure-tools/typespec-python` section
- **PRESERVE** all other language configurations

### For `client.tsp` Updates
**Required template:**
```tsp
import "@azure-tools/typespec-client-generator-core";
using Azure.ClientGenerator.Core;

// Your customizations here
@@clientName(Target, "NewName", "python");
@@clientNamespace(Namespace, "NewNamespace", "python");
```

**Rules:**
- **ONLY** use `@@clientName` and `@@clientNamespace` in `client.tsp`
- **NEVER** import client-generator-core in other files
- **ALWAYS** specify language parameter for language-specific changes

### For Other `.tsp` File Updates
- **ONLY** for universal (all-language) changes
- **NEVER** for language-specific customizations

## Step 7: Implementation Process

1. **ALWAYS** show complete analysis using Step 3 template
2. **LIST** all planned changes as bullet points
3. **CONFIRM** with user before making ANY changes
4. **IMPLEMENT** changes in this order:
   - `tspconfig.yaml` first
   - `client.tsp` second  
   - Other `.tsp` files last

## Step 8: Post-Implementation Validation

1. **Validate TypeSpec**: Run `/validate-typespec` and resolve any compilation errors
2. **Generate SDKs**: 
   - Run `npx tsp-client generate --languages <languages>`
   - Prompt user for comma-separated list of target languages (e.g., `python,javascript`)
3. **Verify results**: Confirm all changes work as expected

## Git Requirements
- **NEVER** use `main` branch
- **ALWAYS** work on feature branches
- **CONFIRM** correct branch before starting
