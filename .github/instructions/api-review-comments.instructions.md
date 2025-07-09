# API Review Comments: TypeSpec Implementation Guide

This document provides a quick guide for implementing API review comments in TypeSpec using the `client.tsp` file.

## IMPORTANT: Process Requirements
- **Follow these steps in EXACTLY the following order**
- **Do not skip any part of the process**
- **Explain each step clearly before taking action**
- **Confirm with user before making ANY changes**

## Step 1: Validate Input Format & Triggering Prompts

User can provide comments directly in chat with context:
- **Example**: "I got this feedback for Python '<review comment>' for the model Bar and attribute foo, can you help with that?"
- **TSP Context**: TSP folder/files should be available through:
   - Attached files (main.tsp, client.tsp, etc.)
   - Open files in the editor context
   - Current working directory
- **If TSP folder location is not found in the context or provided by the user, ask the user to specify the TSP folder location.**

**Validation checklist:**
- [ ] TSP folder location in context/provided OR TSP files attached/open
- [ ] Language specified (Python, C#, Java, JavaScript, etc.) - can be inferred from comment
- [ ] Review comments provided (either structured or in chat message)
- [ ] Target API elements identified (model, property, operation, etc.)

## Step 2: Analyze Each Comment

### Quick Reference: Mapping Language Naming to TypeSpec Elements

| Language  | Python Example (snake_case)         | TypeSpec Equivalent (camelCase)   | Notes                                      |
|-----------|-------------------------------------|-----------------------------------|---------------------------------------------|
| Property  | `parent_entity_name`                | `parentEntityName`                | Python: snake_case; TypeSpec: camelCase     |
| Method    | `get_foo_bar()`                     | `getFooBar()`                     | Python: snake_case; TypeSpec: camelCase     |
| Class     | `Relationship`                      | `Relationship`                    | Both: PascalCase                            |
| Rename    | "rename foo_bar to new_bar"        | Rename `fooBar` to `newBar`       | Map snake_case to camelCase for TypeSpec    |

> **Critical Note:**
> - **Never change TypeSpec operation or property names to snake_case, even if review feedback uses Python-style names.**
> - **TypeSpec must always follow conventions and best practices; i.e. use camelCase for operations and properties, and PascalCase for classes.**
> - **The Python generator will automatically convert camelCase to snake_case in the generated SDK.**
> - **If review feedback refers to Python API names in snake_case, map them to the correct TypeSpec camelCase name before making changes.**

**Enforcement:**
- Before making any code changes, always copy and fill out the comment analysis template below for each review comment.
- If a review comment requests a snake_case name, explicitly document the correct TypeSpec camelCase/PascalCase name in your analysis.
  - **client decorator target values must ALWAYS follow TypeSpec conventions: PascalCase for interfaces/classes, camelCase for operations/properties.**

**Extract and analyze using the same template:**

```
**Comment**: [exact quote from review feedback]
**Target Language**: [Python, C#, Java, JavaScript, etc.]
**TypeSpec Element**: [TypeSpec name to be changed, in camelCase or PascalCase]
**TypeSpec Element Type**: [model/property/operation/interface/enum]
**Action**: [client.tsp OR main.tsp]
**File**: [specific file to modify]
**Python Name in Feedback**: [snake_case name from review, if present]
**Mapped TypeSpec Name**: [camelCase or PascalCase name to use in TypeSpec]
```

**Note**: If a review comment uses a Python name (snake_case), always show the mapped TypeSpec name (camelCase) in your analysis. For comments requiring multiple actions, fill out the template for each action.

**Examples of chat-based comment extraction:**
- Input: "I got feedback for Python 'rename parent_entity_name to entity_name' for the model Relationship"
- Analysis: Comment = "rename parent_entity_name to entity_name", Target Language = Python, Target Element = property, Element Name = Relationship.parentEntityName

## Step 3: Determine Implementation Strategy

### Implementation Rules

**IMPORTANT**: Changes should **ONLY** be made to `client.tsp`. Do not modify other `.tsp` files unless explicitly listed in the exceptions section below.
**IMPORTANT**: Follow TypeSpec conventions and best practices for naming and structure.

**Critical Naming Convention Rule:**
When using `@@clientName`, the target name (second parameter) must follow TypeSpec conventions:
- **Interfaces/Classes**: PascalCase (e.g., "Entities", "Relationships", "HealthModels")
- **Operations/Methods**: camelCase (e.g., "getEntity", "listSignals")
- **Properties**: camelCase (e.g., "entityName", "signalData")
- The Python generator will automatically convert these to snake_case in the generated SDK

**Examples of CORRECT target naming:**
```tsp
// ✅ CORRECT - Interface renamed to PascalCase
@@clientName(Namespace.EntityOperations, "Entities", "python");

// ✅ CORRECT - Operation renamed to camelCase  
@@clientName(Namespace.SomeInterface.get_something, "getSomething", "python");

// ❌ WRONG - Using snake_case (target language convention) for TypeSpec target
@@clientName(Namespace.EntityOperations, "entities", "python");
```

### Scenario 1: Operations Directly on Client
**Trigger**: Comments about operations being directly on the client rather than in separate `*Operation` classes.
**Action**: Use `@client` decorator in `client.tsp` to define a root client interface with operation aliases
**Example**:
```tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AzureHealthInsights.Versions.v2024_08_01_preview)
namespace ClientCustomizations;

@client({
  name: "RadiologyInsightsClient",
  service: AzureHealthInsights,
})
interface RadiologyInsightsClient {
  // Only operations used here and models/enum/union used by those operations will be public - all others become internal
  inferRadiologyInsights is AzureHealthInsights.RadiologyInsights.createJob;
}
```
**Important Notes for @@client**:
- Only operations referenced in the `@client` interface -- and models/enum/union used by those operations -- will be public. All other operations/interfaces will be internal by default.

### Scenario 2: Renaming client
**Trigger**: Comments about changing `SomeClient` class name to `SomeOtherClient`
**Action**: First check how the client is currently defined, then apply appropriate changes:
1. **Check client.tsp for `@client` decorator**
2. **If `@client` exists**: Update the `name` property and attached interface - use the desired name WITH "Client" suffix
3. **If no `@client`**: Add `@@clientName` - use the desired name WITHOUT "Client" suffix

**Examples**: See complete `client.tsp` examples in "Complete `client.tsp` File Examples" section.

**Key points for @@clientName**:
- Use the augment decorator `@@clientName` (double @), not the regular decorator `@clientName`
- The client name should NOT include "Client" suffix (it's added automatically)

### Scenario 3: Renaming non-client TypeSpec elements
**Trigger**: Comments about renaming any TypeSpec elements (models, properties, operations, interfaces, enum members, parameters, etc.)
**Action**: Use `@@clientName` with appropriate path syntax

**Examples**:
```tsp
// In client.tsp

// Renaming model
@@clientName(Microsoft.Service.DatabaseChangeTierDefinition, "DatabaseChangeTierProperties"); // all languages
@@clientName(Microsoft.Service.Identity, "IdentityProperties", "csharp"); // csharp

// Renaming model property
@@clientName(Microsoft.Service.Relationship.parentEntityName, "fromEntity", "python");

// Renaming operation parameter
@@clientName(Microsoft.Service.SomeInterface.createOrUpdate::parameters.resource, "body");

// Renaming interface
@@clientName(Microsoft.Service.EndpointResources, "Endpoints", "python");

// Renaming enum/union member
@@clientName(Microsoft.Service.AdvertiseMode.BGP, "Bgp", "csharp");

// Renaming API version value
@@clientName(Microsoft.Service.Versions.`2025-04-01`, "V20250401", "javascript");
```

### Scenario 4: Access Control Changes
**Trigger**: Comments about making elements internal/private or changing visibility
**Actions**: Use `@@access` decorator in `client.tsp`

**Important Notes:**
- `@@access` can only be applied to: ModelProperty, Model, Operation, Enum, Union, or Namespace
- `@@access` **CANNOT** be applied to interfaces
- If the `@client` decorator is being used to define a custom client, all operations/interfaces that are not referenced will be private by default.

**Examples**:
```tsp
// Make model internal for python
@@access(Namespace.Model, Access.internal, "python");

// Make enum internal
@@access(Namespace.SomeEnum, Access.internal, "python");

// Language-specific access
@@access(Namespace.Model, Access.internal, "python");

// ❌ WRONG - Cannot apply to interfaces
// @@access(Namespace.SomeOperations, Access.internal, "python");

// ✅ CORRECT - Use @client decorator instead for interfaces
@client({
  name: "ServiceClient",
  service: Namespace,
})
interface ServiceClient {
  // Only operations referenced here will be public and directly on the client. All other operations will be private.
  getSomething is Namespace.SomeOperations.getSomething;
}
```

### Complete `client.tsp` File Examples

**Basic client name customization:**
```tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(Microsoft.CloudHealth.HealthModels.Data.Versions.v2025_06_18_preview)
namespace ClientCustomizations;

// Rename the main client (from namespace-based generation)
@@clientName(Microsoft.CloudHealth.HealthModels.Data, "HealthModels", "python");
```

**Using @client decorator for root client interface:**
```tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AzureHealthInsights.Versions.v2024_08_01_preview)
namespace ClientCustomizations;

@client({
  name: "RadiologyInsightsClient",
  service: AzureHealthInsights,
})
interface RadiologyInsightsClient {
  inferRadiologyInsights is AzureHealthInsights.RadiologyInsights.createJob;
}

// rename the operation only for Python
@@clientName(RadiologyInsightsClient.inferRadiologyInsights, "inferInsights", "python")
```

### Critical Rules
- **Client Priority**: `client.tsp` is always checked first for `@client` decorator. If present, it defines the client and overrides namespace-based client generation. If not present, the namespace defined in main.tsp is used for the client name.
- **@@clientName** = Specify name WITHOUT "Client" suffix (it's added automatically)
- **@client interface** = Interface name SHOULD end with "Client" (explicit naming)
- **Namespace naming** = Should NOT end with "Client" (auto-appended for namespace-based generation)
- **Main client name** = Last namespace segment + "Client" (when using namespace-based generation)
- **Operations classes** = Interface name + "Operations" 
- **NEVER** name interfaces ending with "Operations" (creates "OperationsOperations")

## Step 4: Implementation Process

1. **ANALYZE** using Step 2 Comment Analysis template:
   ```
   **Comment**: [exact quote]
   **Target Language**: [language]
   **Target Element**: [model/property/operation/etc.]
   **Element Name**: [TypeSpec element name]
   **Action**: [tspconfig.yaml OR client.tsp]
   **File**: [specific file]
   ```

2. **LIST** all planned changes as bullet points
3. **CONFIRM** with user before making ANY changes
4. **IMPLEMENT** changes in this order:
   - `client.tsp` (naming/access customizations)
   - Other `.tsp` files only if listed in exceptions section

## CRITICAL ENFORCEMENT CHECKPOINT
**BEFORE moving to validation, STOP and verify:**
- [ ] Did I actually call `create_file` or `replace_string_in_file` or `insert_edit_into_file`?
- [ ] Can I see my changes reflected in the file content?
- [ ] Are the exact planned changes present in the code?
- [ ] Do target names follow TypeSpec conventions (PascalCase for interfaces, camelCase for operations/properties)?

**If ANY answer is NO, implement immediately before continuing.**
   - `client.tsp` second (naming/access customizations)
   - Other `.tsp` files only if listed in exceptions section

## Step 5: Post-Implementation Validation

1. **Validate TypeSpec**: Run `tsp compile .` from project root
2. **Fix any compilation errors** before proceeding
3. **Generate SDK**: Run `npx tsp compile client.tsp --emit @azure-tools/typespec-<target language>` from project root
4. **Fix any generation errors**

<!-- References -->
[TypeSpec Language Basics Docs]: https://typespec.io/docs/language-basics/overview/
