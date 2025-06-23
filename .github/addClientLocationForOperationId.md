# Add @@clientLocation for operations with @operationId

As a GitHub Copilot assistant, follow this guide to add `@@clientLocation` decorators for all operations
that use `@operationId` in TypeSpec specifications.

## Understanding User Input

When users request help with adding `@@clientLocation` decorators for operations that have `@operationId`
decorators, they typically provide a {TypeSpec-folder} in the format `{ServiceName}.Management` (where
ServiceName examples include: `Compute`, `Network`, `Storage`, `Dashboard`) or a specific TypeSpec project path.

When the user provides a service folder name, look for the TypeSpec files under that folder and locate the
`back-compatible.tsp` file where client customizations should be added.

If the user does not provide this information, be sure to ask. Use this information to customize your
guidance, especially in the following cases:

- Locating the correct back-compatible.tsp file
- Identifying the correct operation interfaces and namespaces

## Migration Steps

## Step 1: Locate TypeSpec files and identify operations with @operationId

1. **Find the TypeSpec project structure**
   - Location: `{ServiceName}.Management/` folder
   - Key files to examine: `*.tsp` files (especially operation definition files)
   - Target file for modifications: `back-compatible.tsp`

2. **Search for operations with @operationId decorators**
   - Use grep or similar tools to find all `@operationId` usages:

   ```bash
   grep -r "@operationId" *.tsp
   ```

   - Example findings:

   ```typespec
   @operationId("Dashboards_Get")
   get is ArmResourceRead<ManagedDashboard>;
   
   @operationId("Grafanas_Create")
   create is ArmResourceCreateOrReplaceAsync<ManagedGrafana>;
   ```

## Step 2: Extract operation information

For each operation with `@operationId`, identify:

1. **Operation ID pattern**: Extract the prefix from the operationId
   - Example: `"Dashboards_Get"` → prefix is `"Dashboards"`
   - Example: `"Grafanas_Create"` → prefix is `"Grafanas"`

2. **Operation location**: Identify the interface and operation name
   - Example: `ManagedDashboards.get` for a get operation in ManagedDashboards interface
   - Example: `ManagedGrafanas.create` for a create operation in ManagedGrafanas interface

3. **Operation mapping pattern**:

   ```text
   @operationId("Dashboards_Get") → @@clientLocation(ManagedDashboards.get, "Dashboards")
   @operationId("Grafanas_Create") → @@clientLocation(ManagedGrafanas.create, "Grafanas")
   ```

## Step 3: Add @@clientLocation decorators in back-compatible.tsp

1. **Open the back-compatible.tsp file**
   - Location: `{ServiceName}.Management/back-compatible.tsp`
   - Ensure it imports the client generator core:

   ```typespec
   import "@azure-tools/typespec-client-generator-core";
   using Azure.ClientGenerator.Core;
   ```

2. **Add @@clientLocation decorators**
   - Add them in a logical grouping, typically after existing `@@clientName` decorators   - Follow the pattern: `@@clientLocation(Interface.operation, "Prefix")`
   - When the prefix matches an existing interface name exactly, use interface reference instead: `@@clientLocation(Interface.operation, InterfaceName)`
   - Example additions:

   ```typespec
   // Client location customizations for operations with @operationId
   @@clientLocation(ManagedDashboards.get, "Dashboards");
   @@clientLocation(ManagedGrafanas.create, "Grafanas");
   
   // Use interface reference when prefix matches existing interface name
   @@clientLocation(RecordSets.listByType, RecordSets);
   ```

3. **Organize the additions**
   - Group by interface or logical operation categories
   - Add comments to explain the purpose:

   ```typespec
   // @@clientLocation decorators for operations with custom @operationId
   // These ensure consistent operationId generation in the output
   @@clientLocation(ManagedDashboards.get, "Dashboards");
   @@clientLocation(ManagedDashboards.create, "Dashboards");
   @@clientLocation(ManagedDashboards.update, "Dashboards");
   @@clientLocation(ManagedDashboards.delete, "Dashboards");
   
   @@clientLocation(ManagedGrafanas.get, "Grafanas");
   @@clientLocation(ManagedGrafanas.create, "Grafanas");
   @@clientLocation(ManagedGrafanas.update, "Grafanas");
   @@clientLocation(ManagedGrafanas.delete, "Grafanas");
   ```

## Step 4: Validation and Testing

1. **Validate the additions**:
   - Ensure all operations with `@operationId` have corresponding `@@clientLocation` entries
   - Check that the interface.operation references are correct
   - Verify that the prefix strings match the operationId patterns

2. **Compile and test**:

   ```bash
   cd {TypeSpec-folder}
   npx tsp compile .
   ```

3. **Verify the output**:
   - Check that the generated Swagger/OpenAPI files have the expected operationId values
   - Ensure no compilation errors were introduced
   - Verify that client SDK generation works correctly with the new decorators

## Step 5: Handle client-location-duplicate warnings

If you encounter a warning like this during compilation:

```text
warning @azure-tools/typespec-client-generator-core/client-location-duplicate: 
`@clientLocation`'s target should not duplicate with defined namespace or interface under `@service` namespace.
```

This occurs when the prefix in `@@clientLocation` matches an existing interface name under the service namespace.

### Preferred Solution: Use interface reference instead of string

When the prefix matches an existing interface name exactly, remove the quotes to reference the interface directly:

1. **Identify the conflicting @@clientLocation**:
   - Example: `@@clientLocation(RecordSets.listByType, "RecordSets")` conflicts with existing `RecordSets` interface

2. **Remove quotes to reference the interface directly**:

   ```typespec
   // Instead of using string (causes warning)
   @@clientLocation(RecordSets.listByType, "RecordSets");
   
   // Use interface reference (no warning)
   @@clientLocation(RecordSets.listByType, RecordSets);
   ```

3. **Real-world example from DNS service**:

   **Problem**:
   - `@operationId("RecordSets_ListByType")` requires prefix "RecordSets"
   - But "RecordSets" conflicts with existing `RecordSets` interface

   **Solution applied**:

   ```typespec
   // In back-compatible.tsp - Use interface references for matching names
   @@clientLocation(RecordSets.listByType, RecordSets);
   @@clientLocation(Zones.listByDnsZone, RecordSets);
   @@clientLocation(Zones.listAllByDnsZone, RecordSets);
   
   // Keep string for non-matching interface names
   @@clientLocation(DnsResourceReferenceOperationGroup.getByTargetResources, "DnsResourceReference");
   ```

   **Result**: Compilation succeeds without warnings, maintains type safety, and preserves original operationId patterns.

## Common Patterns and Examples

### Pattern Recognition

- `@operationId("Dashboards_Get")` → `@@clientLocation(ManagedDashboards.get, "Dashboards")`
- `@operationId("Grafanas_Create")` → `@@clientLocation(ManagedGrafanas.create, "Grafanas")`
- `@operationId("PrivateEndpoints_List")` → `@@clientLocation(PrivateEndpointConnections.list, "PrivateEndpoints")`

This process ensures that all operations with custom `@operationId` decorators have corresponding
`@@clientLocation` decorators for consistent client SDK generation.
