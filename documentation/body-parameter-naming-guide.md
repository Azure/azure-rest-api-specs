# Body Parameter Naming Convention for TypeSpec

## Overview

This guide explains the recommended naming conventions for request body parameters in TypeSpec specifications, specifically for PATCH and POST operations. These conventions ensure consistent and intuitive parameter names in generated SDKs.

## Naming Conventions

### PATCH Operations

For PATCH operations (updates), the request body parameter should be named **`patch`** in the generated C# SDK.

**Pattern:**
```typespec
@@clientName(ResourceName.update::parameters.properties, "patch", "csharp");
```

**Example:**
```typespec
// In client.tsp
@@clientName(Applications.update::parameters.properties, "patch", "csharp");
@@clientName(NodeTypes.update::parameters.properties, "patch", "csharp");
@@clientName(Services.update::parameters.properties, "patch", "csharp");
```

### POST Operations

For POST operations with a request body, the body parameter should be named **`content`** in the generated C# SDK.

**Pattern:**
```typespec
@@clientName(ResourceName.action::parameters.body, "content", "csharp");
```

**Example:**
```typespec
// In client.tsp
@@clientName(Applications.updateUpgrade::parameters.body, "content", "csharp");
@@clientName(Applications.resumeUpgrade::parameters.body, "content", "csharp");
@@clientName(NodeTypes.deallocate::parameters.body, "content", "csharp");
@@clientName(NodeTypes.deleteNode::parameters.body, "content", "csharp");
```

## Implementation Steps

### 1. Identify Operations

First, identify all PATCH and POST operations in your TypeSpec specification that have request bodies.

### 2. Create or Update client.tsp

If you don't already have a `client.tsp` file in your specification directory, create one:

```typespec
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace YourService {
  // Add @@clientName decorators here
}
```

### 3. Add @@clientName Decorators

Add the appropriate `@@clientName` decorators for each operation:

```typespec
namespace YourService {
  // PATCH operations
  @@clientName(ResourceName.update::parameters.properties, "patch", "csharp");
  
  // POST operations
  @@clientName(ResourceName.create::parameters.body, "content", "csharp");
  @@clientName(ResourceName.action::parameters.body, "content", "csharp");
}
```

## Complete Example

Here's a complete example for a hypothetical Widget service:

**File: specification/widgets/Widget.Management/client.tsp**
```typespec
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Widget.Management {
  // PATCH operations - use "patch" for update body parameters
  @@clientName(Widgets.update::parameters.properties, "patch", "csharp");
  @@clientName(WidgetGroups.update::parameters.properties, "patch", "csharp");
  
  // POST operations - use "content" for body parameters
  @@clientName(Widgets.activate::parameters.body, "content", "csharp");
  @@clientName(Widgets.validate::parameters.body, "content", "csharp");
  @@clientName(WidgetGroups.migrate::parameters.body, "content", "csharp");
}
```

## Why This Matters

### Consistency

Using consistent parameter names across all Azure SDKs makes it easier for developers to:
- Learn and use Azure SDKs
- Switch between different Azure services
- Write generic code that works across services

### Clarity

- **`patch`**: Clearly indicates this is an update/patch operation with partial resource data
- **`content`**: Clearly indicates this is the main content/payload for an action

### SDK Generation

The `@@clientName` decorator directly influences SDK generation, ensuring that:
- C# SDK methods have appropriate parameter names
- IntelliSense and documentation are clear and helpful
- The SDK API surface is intuitive

## Reference Examples

### ServiceFabric Managed Clusters

See [ServiceFabricManagedClusters/client.tsp](../specification/servicefabricmanagedclusters/resource-manager/Microsoft.ServiceFabric/ServiceFabricManagedClusters/client.tsp) for comprehensive examples:

```typespec
// C#-specific parameter naming (recommended pattern)
@@clientName(Applications.update::parameters.properties, "patch", "csharp");
@@clientName(Applications.updateUpgrade::parameters.body, "content", "csharp");
@@clientName(ManagedClusters.update::parameters.properties, "patch", "csharp");
@@clientName(NodeTypes.update::parameters.properties, "patch", "csharp");
```

**Note**: This file also contains decorators without language specification (for backward compatibility or other languages). The C#-specific decorators override those defaults.

### Health Data AI Services

See [HealthDataAIServices.DeidServices/client.tsp](../specification/healthdataaiservices/HealthDataAIServices.DeidServices/client.tsp) for a simple example:

```typespec
@@clientName(DeidentifyTextRequest.body, "content", "csharp");
```

## Common Mistakes to Avoid

### ❌ Don't use generic parameter names
```typespec
// Wrong - too generic
@@clientName(Widgets.update::parameters.properties, "parameters", "csharp");
```

### ❌ Don't mix conventions
```typespec
// Wrong - inconsistent naming
@@clientName(Widgets.update::parameters.properties, "updateRequest", "csharp");
@@clientName(WidgetGroups.update::parameters.properties, "patch", "csharp");
```

### ✅ Do follow the conventions consistently
```typespec
// Correct - consistent use of "patch" for PATCH operations
@@clientName(Widgets.update::parameters.properties, "patch", "csharp");
@@clientName(WidgetGroups.update::parameters.properties, "patch", "csharp");
```

## Multi-Language Support

While this guide focuses on C#, you can apply the same conventions to other languages by including them in the language list:

```typespec
// Apply to multiple languages
@@clientName(Widgets.update::parameters.properties, "patch", "csharp,java,python");
@@clientName(Widgets.action::parameters.body, "content", "csharp,java,python");
```

## Related Documentation

- [TypeSpec Client Generator Core](https://github.com/Azure/typespec-azure/tree/main/packages/typespec-client-generator-core)
- [TypeSpec Decorators Reference](https://typespec.io/docs/decorators/)
- [Azure TypeSpec Style Guide](https://azure.github.io/typespec-azure/docs/reference/azure-style-guide)

## Questions and Support

If you have questions about implementing these conventions, please:
1. Review the reference examples linked above
2. Check existing TypeSpec specifications for similar patterns
3. Reach out to the Azure SDK team for guidance
