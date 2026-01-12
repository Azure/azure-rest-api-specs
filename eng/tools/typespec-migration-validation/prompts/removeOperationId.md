# Remove Operation Id Decorator from TypeSpec Files

## Input Parameters

- `tspFolder`: Required. The folder path containing TypeSpec files to be processed. This folder should contain:
  - All .tsp files that need to be migrated
  - The back-compatible.tsp file (will be created if it doesn't exist)
    Examples:
  - Relative path: "specification/healthbot/Healthbot.Management"

## Context

You will help users migrate from using `@operationId` decorators to using `@clientLocation` and `@clientName` decorators in TypeSpec files.

## Instructions

### Step 1: Process TypeSpec Files in {tspFolder}

1. Scan all .tsp files in the specified {tspFolder}
2. For each file:
   - Find operations marked with `@operationId` decorator
   - Parse decorator content which follows format: `{clientLocation}_{clientName}`
   - Identify the interface containing each operation

### Step 2: Handle Client Location in {tspFolder}

For each operation found in {tspFolder} files, check if the interface that contains the operation has a name that exactly matches `{clientLocation}` (case-sensitive):

- If the containing interface name is exactly the same as `{clientLocation}`: No clientLocation decorator needed
- If the containing interface name doesn't match exactly (e.g., operation in "Operations" interface but `{clientLocation}` is "Widgets"):
  - Check if `{clientLocation}` exists as an interface in any .tsp file within {tspFolder} (case-sensitive match)
    - If it exists: Add to {tspFolder}/back-compatible.tsp:
      ```typespec
      @@clientLocation({interface name}.{operation name}, {clientLocation})
      ```
    - If it doesn't exist: Add to {tspFolder}/back-compatible.tsp:
      ```typespec
      @@clientLocation({interface name}.{operation name}, "{clientLocation}")
      ```

### Step 3: Handle Client Name

Capitalize the first character of the operation name, then check if it matches `{clientName}` (case sensitive):

- Capitalize the first character of the operation name (e.g., "list" becomes "List", "create" becomes "Create")
- Compare the capitalized operation name with `{clientName}` using exact case-sensitive matching
- If they don't match exactly: Add to {tspFolder}/back-compatible.tsp:
  ```typespec
  @@clientName({interface name}.{operation name}, "{clientName}")
  ```

### Step 4: Clean Up TypeSpec Files

1. In each .tsp file within {tspFolder}:
   - Remove the `@operationId` decorator
   - Remove any corresponding `#suppress` statement above it

### Step 5: Clean Up back-compatible.tsp

After generating all the decorators, review the back-compatible.tsp file to remove any unnecessary decorators:

1. **Remove redundant @clientLocation decorators**:

   - If an operation is already in an interface with the same name as the target client location, the @clientLocation decorator is not needed
   - Example: If `Widgets.list` has `@@clientLocation(Widgets.list, Widgets)`, this can be removed since the operation is already in the Widgets interface

2. **Remove redundant @clientName decorators**:

   - If the operation name (with first letter capitalized) already matches the target client name, the @clientName decorator is not needed
   - Example: If `Operations.create` has `@@clientName(Operations.create, "Create")`, this can be removed since "create" capitalized is "Create"

3. **Clean up empty back-compatible.tsp**:
   - If after removing redundant decorators the back-compatible.tsp file is empty or only contains imports, consider removing the file entirely

## Examples

### Example 1: New ClientLocation doesn't exist

Before:

```typespec
interface Operations {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration in progress"
  @operationId("Widgets_AnotherList")
  list(): Widget[];

  // ...other operations...
}
```

After:

- Remove decorators from original file:

```typespec
interface Operations {
  list(): Widget[];

  // ...other operations...
}
```

- Add to back-compatible.tsp:

```typespec
@@clientLocation(Operations.list, "Widgets")
@@clientName(Operations.list, "AnotherList")
```

### Example 2: New ClientLocation exists as interface

Before:

```typespec
interface Widgets {
  create(): Widget;
}

interface Operations {
  #suppress "@azure-tools/typespec-azure-core/operation-id" "Migration in progress"
  @operationId("Widgets_AnotherList")
  list(): Widget[];

  // ...other operations...
}
```

After:

- Remove decorators from original file:

```typespec
interface Widgets {
  create(): Widget;
}

interface Operations {
  list(): Widget[];

  // ...other operations...
}
```

- Add to back-compatible.tsp since the target interface "Widgets" exists:

```typespec
@@clientLocation(Operations.list, Widgets)
@@clientName(Operations.list, "AnotherList")
```

### Example 3: Operation already in correct interface

Before:

```typespec
interface Widgets {
  #suppress "@azure-tools/typespec-azure-core/operation-id" "Migration in progress"
  @operationId("Widgets_AnotherList")
  list(): Widget[];
}
```

After:

- Remove decorators from original file:

```typespec
interface Widgets {
  list(): Widget[];
}
```

- Add to back-compatible.tsp (only clientName needed since operation is already in Widgets interface):

```typespec
@@clientName(Widgets.list, "AnotherList")
```

### Example 4: Operation name matches clientName

Before:

```typespec
interface Operations {
  #suppress "@azure-tools/typespec-azure-core/operation-id" "Migration in progress"
  @operationId("Widgets_Create")
  create(): Widget[];
}
```

After:

- Remove decorators from original file:

```typespec
interface Operations {
  create(): Widget[];
}
```

- Add to back-compatible.tsp (only clientLocation needed since operation name "create" matches clientName part):

```typespec
@@clientLocation(Operations.create, "Widgets")
```
