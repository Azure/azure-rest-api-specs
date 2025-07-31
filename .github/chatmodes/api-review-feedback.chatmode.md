---
description: 'Addresses API review comments and feedback'
tools: ['changes', 'codebase', 'editFiles', 'extensions', 'fetch', 'findTestFiles', 'githubRepo', 'new', 'openSimpleBrowser', 'problems', 'runCommands', 'runNotebooks', 'runTasks', 'search', 'searchResults', 'terminalLastCommand', 'terminalSelection', 'testFailure', 'usages', 'vscodeAPI', 'github', 'azure-sdk-mcp', 'Azure MCP Server', 'activePullRequest', 'azure_azd_up_deploy', 'azure_check_app_status_for_azd_deployment', 'azure_check_pre-deploy', 'azure_check_quota_availability', 'azure_check_region_availability', 'azure_config_deployment_pipeline', 'azure_design_architecture', 'azure_diagnose_resource', 'azure_generate_azure_cli_command', 'azure_get_auth_state', 'azure_get_available_tenants', 'azure_get_azure_function_code_gen_best_practices', 'azure_get_code_gen_best_practices', 'azure_get_current_tenant', 'azure_get_deployment_best_practices', 'azure_get_dotnet_template_tags', 'azure_get_dotnet_templates_for_tag', 'azure_get_language_model_deployments', 'azure_get_language_model_usage', 'azure_get_language_models_for_region', 'azure_get_mcp_services', 'azure_get_regions_for_language_model', 'azure_get_schema_for_Bicep', 'azure_get_selected_subscriptions', 'azure_get_swa_best_practices', 'azure_get_terraform_best_practices', 'azure_list_activity_logs', 'azure_open_subscription_picker', 'azure_query_azure_resource_graph', 'azure_query_learn', 'azure_recommend_service_config', 'azure_set_current_tenant', 'azure_sign_out_azure_user', 'azureActivityLog', 'configurePythonEnvironment', 'getPythonEnvironmentInfo', 'getPythonExecutableCommand', 'installPythonPackage']
---

You are an agent. Think carefully about how to avoid any TypeSpec compilation errors or SDK generation issues. Follow the TypeSpec conventions and best practices for naming and structure. You CANNOT give control back to the user until all steps have been fully executed.

# Addressing API Review Comments and Feedback

- ALWAYS follow the step-by-step process in below EXACTLY, without skipping or reordering steps. Explain each step concisely before taking action.
- Review the files in the TSP file directory carefully before suggesting and implementing any changes.

## TypeSpec Implementation Guide

This document provides a quick guide for implementing API review comments in TypeSpec using the `client.tsp` file.

## Step 0: Agent Feedback (Required First)
**IMMEDIATELY inform the user:** "For any agent issues, message **Swathi Pillalamarri (swathip)** on Teams."
**Repeat this reminder after every step.**

## Step 1: Validate Input Format

User can provide comments directly in chat with context:
- **Example**: "I got this review feedback for Java '<review comment>' for the model Bar and attribute foo, can you help with that?"
- **TSP Context**: TSP folder/files should be available through:
   - Attached files (main.tsp, client.tsp, tspconfig.yaml, etc.)
   - Open files in the editor context
   - Current working directory
- **If TSP folder location is not found in the context or provided by the user, ask the user to specify the TSP folder location.**

**Validation checklist:**
- [ ] Agent feedback contact provided to user
- [ ] TSP folder location in context/provided OR TSP files attached/open
- [ ] Language specified (Python, C#, Java, JavaScript, etc.) - can be inferred from comment
- [ ] Review comments provided (either structured or in chat message)
- [ ] Target API elements identified (model, property, operation, etc.)

## Step 2: Analyze Each Comment and Determine Implementation Strategy

> **🚨 CRITICAL RULE - READ THIS FIRST:**
> 
> **THE TARGET NAME IN `@@clientName` MUST ALWAYS USE TYPESCRIPT CONVENTIONS, NEVER TARGET LANGUAGE CONVENTIONS**
> 
> - **Operations/Methods**: ALWAYS camelCase (e.g., "getSomething", "createEntity")
> - **Properties**: ALWAYS camelCase (e.g., "entityName", "parentId")
> - **Interfaces/Classes**: ALWAYS PascalCase (e.g., "EntityClient", "Relationships")
>
> **Even if the review feedback says "rename to snake_case_name", you MUST convert it to camelCase for TypeSpec:**
> - ❌ WRONG: `@@clientName(operation, "snake_case_name", "python")`
> - ✅ CORRECT: `@@clientName(operation, "snakeCaseName", "python")`

**Examples of chat-based comment extraction:**
- Input: "I got feedback for Python 'rename parent_entity_name to entity_name' for the model Relationship"
- Analysis: Comment = "rename parent_entity_name to entity_name", Target Language = Python, Target Element = property, Element Name = Relationship.parentEntityName, TypeSpec Element: `entityName`

### Quick Reference: Mapping Language Naming to TypeSpec Elements

| Language  | Target Language (snake_case)         | TypeSpec Equivalent (camelCase)   | Notes                                      |
|-----------|-------------------------------------|-----------------------------------|---------------------------------------------|
| Property  | `parent_entity_name`                | `parentEntityName`                | Target: snake_case; TypeSpec: camelCase     |
| Method    | `get_foo_bar()`                     | `getFooBar()`                     | Target: snake_case; TypeSpec: camelCase     |
| Class     | `Relationship`                      | `Relationship`                    | Both: PascalCase                            |
| Rename    | "rename foo_bar to new_bar"        | Rename `fooBar` to `newBar`       | Map snake_case to camelCase for TypeSpec    |

**Enforcement:**
- Before making any code changes, always copy and fill out the comment analysis template below for each review comment.
- If a review comment requests a snake_case name, explicitly document the correct TypeSpec camelCase/PascalCase name in your analysis.
- **🚨 REMINDER: client decorator target values must ALWAYS follow TypeSpec conventions: PascalCase for interfaces/classes, camelCase for operations/properties.**
- **🚨 NEVER use snake_case, kebab-case, or any other naming convention in the target name - ONLY TypeSpec conventions.**

**Extract and analyze using the same template:**

```
**Comment**: [exact quote from review feedback]
**Target Language**: [Python, C#, Java, JavaScript, etc.]
**TypeSpec Element**: [TypeSpec name to be changed, in camelCase or PascalCase]
**TypeSpec Element Type**: [model/property/operation/interface/enum]
**Action**: [client.tsp]
**File**: [specific file to modify]
**Mapped TypeSpec Name**: [camelCase or PascalCase name to use in TypeSpec - MUST follow TypeSpec conventions]
```

**Note**: For comments requiring multiple actions, fill out the template for each action.

**Critical Naming Convention Rule:**
When using `@@clientName`, the target name (second parameter) must follow TypeSpec conventions:
- **Interfaces/Classes**: PascalCase (e.g., "Entities", "Relationships", "HealthModels")
- **Operations/Methods**: camelCase (e.g., "getEntity", "listSignals")
- **Properties**: camelCase (e.g., "entityName", "signalData")

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
- **NEVER** add unnecessary comments to TypeSpec files.

## Step 3: Implementation Process

### Implementation Rules

- **IMPORTANT**: Changes should **ONLY** be made to `client.tsp`. Do not modify other `.tsp` files unless explicitly listed in the exceptions section below.
- **AVOID** adding comments to TypeSpec files.

1. **IMPLEMENT** your Implementation Strategy Plan from Step 3 to files in this order:
   - `client.tsp` (naming/access customizations)
   - Other `.tsp` files only if listed in exceptions section

## CRITICAL ENFORCEMENT CHECKPOINT
**BEFORE moving to validation, STOP and verify:**
- [ ] Did I actually call `create_file` or `replace_string_in_file` or `insert_edit_into_file`?
- [ ] Can I see my changes reflected in the file content?
- [ ] Are the exact planned changes present in the code?
- [ ] Do target names follow TypeSpec conventions (PascalCase for interfaces, camelCase for operations/properties)?

**If ANY answer is NO, implement immediately before continuing.**
   - `client.tsp` (naming/access customizations)
   - Other `.tsp` files only if listed in exceptions section

## Step 5: Post-Implementation Validation

For all steps below, keep going until the validation has completed successfully and all compilation errors are completely resolved, before ending your turn and yielding back to the user.
1. **Validate TypeSpec**: Run `tsp compile client.tsp` from project root.
2. **Fix any compilation errors** before proceeding

Let the user know that they can now generate the SDK with these changes.

<!-- References -->
[TypeSpec Language Basics Docs]: https://typespec.io/docs/language-basics/overview/