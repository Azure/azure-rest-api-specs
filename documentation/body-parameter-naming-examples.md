# Body Parameter Naming: Before and After Examples

This document shows concrete before/after examples of implementing the body parameter naming convention.

## Example 1: Simple Widget Service

### Before (Without clientName decorators)

**File: specification/widgets/Widget.Management/Widget.tsp**
```typespec
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Widget.Management;

model Widget is TrackedResource<WidgetProperties> {
  @key("widgetName")
  @segment("widgets")
  @path
  name: string;
}

model WidgetProperties {
  status?: string;
  configuration?: string;
}

model WidgetUpdate {
  tags?: Record<string>;
  properties?: WidgetProperties;
}

@armResourceOperations
interface Widgets {
  get is ArmResourceRead<Widget>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Widget>;
  update is ArmResourcePatchSync<Widget, WidgetUpdate>;
  delete is ArmResourceDeleteSync<Widget>;
  listByResourceGroup is ArmResourceListByParent<Widget>;
  listBySubscription is ArmListBySubscription<Widget>;
  
  @post
  activate(...ResourceInstanceParameters<Widget>, @body body: ActivateRequest): ArmResponse<ActivationResult>;
}

model ActivateRequest {
  mode: string;
}

model ActivationResult {
  status: string;
}
```

**Generated C# SDK (Before):**
```csharp
// The body parameter has a generated name based on the type
public virtual Response<Widget> Update(
    string resourceGroupName,
    string widgetName,
    WidgetUpdate widgetUpdate,  // ❌ Parameter name is "widgetUpdate"
    CancellationToken cancellationToken = default)
{
    // Implementation
}

public virtual Response<ActivationResult> Activate(
    string resourceGroupName,
    string widgetName,
    ActivateRequest activateRequest,  // ❌ Parameter name is "activateRequest"
    CancellationToken cancellationToken = default)
{
    // Implementation
}
```

### After (With clientName decorators)

**File: specification/widgets/Widget.Management/client.tsp** (NEW FILE)
```typespec
import "./Widget.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Widget.Management {
  // PATCH operation - rename body parameter to "patch"
  @@clientName(Widgets.update::parameters.properties, "patch", "csharp");
  
  // POST operation - rename body parameter to "content"
  @@clientName(Widgets.activate::parameters.body, "content", "csharp");
}
```

**Generated C# SDK (After):**
```csharp
// The body parameters now have clear, consistent names
public virtual Response<Widget> Update(
    string resourceGroupName,
    string widgetName,
    WidgetUpdate patch,  // ✅ Parameter name is now "patch"
    CancellationToken cancellationToken = default)
{
    // Implementation
}

public virtual Response<ActivationResult> Activate(
    string resourceGroupName,
    string widgetName,
    ActivateRequest content,  // ✅ Parameter name is now "content"
    CancellationToken cancellationToken = default)
{
    // Implementation
}
```

## Example 2: Multiple Operations

### Before

**TypeSpec:**
```typespec
@armResourceOperations
interface StorageAccounts {
  get is ArmResourceRead<StorageAccount>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageAccount>;
  update is ArmResourcePatchSync<StorageAccount, StorageAccountUpdate>;
  delete is ArmResourceDeleteSync<StorageAccount>;
  
  @post
  regenerateKey(...ResourceInstanceParameters<StorageAccount>, @body body: RegenerateKeyRequest): ArmResponse<StorageAccountKeys>;
  
  @post
  revokeUserDelegationKeys(...ResourceInstanceParameters<StorageAccount>, @body body: RevokeDelegationKeysRequest): ArmResponse<void>;
}
```

**Generated C# (Before):**
```csharp
public virtual Response<StorageAccount> Update(
    string resourceGroupName,
    string accountName,
    StorageAccountUpdate storageAccountUpdate,  // ❌ Inconsistent
    CancellationToken cancellationToken = default);

public virtual Response<StorageAccountKeys> RegenerateKey(
    string resourceGroupName,
    string accountName,
    RegenerateKeyRequest regenerateKeyRequest,  // ❌ Long name
    CancellationToken cancellationToken = default);

public virtual Response RevokeUserDelegationKeys(
    string resourceGroupName,
    string accountName,
    RevokeDelegationKeysRequest revokeDelegationKeysRequest,  // ❌ Long name
    CancellationToken cancellationToken = default);
```

### After

**File: client.tsp**
```typespec
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Storage.Management {
  // PATCH operation
  @@clientName(StorageAccounts.update::parameters.properties, "patch", "csharp");
  
  // POST operations
  @@clientName(StorageAccounts.regenerateKey::parameters.body, "content", "csharp");
  @@clientName(StorageAccounts.revokeUserDelegationKeys::parameters.body, "content", "csharp");
}
```

**Generated C# (After):**
```csharp
public virtual Response<StorageAccount> Update(
    string resourceGroupName,
    string accountName,
    StorageAccountUpdate patch,  // ✅ Consistent
    CancellationToken cancellationToken = default);

public virtual Response<StorageAccountKeys> RegenerateKey(
    string resourceGroupName,
    string accountName,
    RegenerateKeyRequest content,  // ✅ Clear and concise
    CancellationToken cancellationToken = default);

public virtual Response RevokeUserDelegationKeys(
    string resourceGroupName,
    string accountName,
    RevokeDelegationKeysRequest content,  // ✅ Clear and concise
    CancellationToken cancellationToken = default);
```

## Benefits Comparison

| Aspect | Before | After |
|--------|---------|-------|
| PATCH parameter | `storageAccountUpdate`, `widgetUpdate` | `patch` (consistent) |
| POST parameter | `regenerateKeyRequest`, `activateRequest` | `content` (consistent) |
| Code readability | Type name repeated in parameter | Clear, semantic name |
| API consistency | Varies by type name | Consistent across all services |
| Developer experience | Need to remember different names | One pattern for all Azure SDKs |

## Real-World Example from Azure

This pattern is already used in Azure services. Here's from Service Fabric Managed Clusters:

**TypeSpec (client.tsp):**
```typespec
// C#-specific parameter naming
@@clientName(Applications.update::parameters.properties, "patch", "csharp");
@@clientName(Applications.updateUpgrade::parameters.body, "content", "csharp");
@@clientName(Applications.resumeUpgrade::parameters.body, "content", "csharp");
@@clientName(ManagedClusters.update::parameters.properties, "patch", "csharp");
@@clientName(NodeTypes.update::parameters.properties, "patch", "csharp");
@@clientName(NodeTypes.deallocate::parameters.body, "content", "csharp");
@@clientName(NodeTypes.deleteNode::parameters.body, "content", "csharp");
```

**Note**: The file also contains non-language-specific decorators for other purposes. The C#-specific decorators shown above override defaults for C# SDK generation.

**Generated C# SDK:**
```csharp
// PATCH operations use "patch"
ApplicationData Update(string applicationName, ApplicationUpdateParameters patch);
ManagedClusterData Update(string clusterName, ManagedClusterUpdateParameters patch);
NodeTypeData Update(string nodeTypeName, NodeTypeUpdateParameters patch);

// POST operations use "content"
ArmOperation UpdateUpgrade(WaitUntil waitUntil, ApplicationUpgradeUpdateContent content);
ArmOperation ResumeUpgrade(WaitUntil waitUntil, ApplicationUpgradeResumeContent content);
ArmOperation Deallocate(WaitUntil waitUntil, NodeTypeActionContent content);
```

## Quick Reference

| HTTP Method | Parameter Name | TypeSpec Pattern |
|-------------|----------------|------------------|
| PATCH (update) | `patch` | `@@clientName(Resource.update::parameters.properties, "patch", "csharp")` |
| POST (action) | `content` | `@@clientName(Resource.action::parameters.body, "content", "csharp")` |
| PUT (create) | *varies* | Usually not renamed, as it's a full resource creation |
