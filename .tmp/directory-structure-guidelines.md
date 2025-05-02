# Directory Structure Guidelines

This document outlines the current and future directory structure guidelines for Azure REST API specifications.

## Current Structure (Default)

The current structure is organized as follows:

```
specification/
└── <orgName>/
    └── <resourceType>/  (e.g. 'resource-manager' or 'data-plane')
        └── <providerNamespace>/
            └── <ServiceName>/
                ├── tspconfig.yaml
                ├── main.tsp
                ├── readme.md
                └── examples/
```

## Future Structure

The future structure will be organized as follows:

```
specification/
└── <rpNamespace>/
    ├── cspell.yaml
    └── resource-manager/
        ├── readme.md
        ├── operations/
        └── <ServiceName1>/
            ├── tspconfig.yaml
            ├── main.tsp
            ├── models.tsp
            ├── readme.md
            └── examples/
                └── <api-version>/
            └── preview/ and stable/
                └── <api-version>/
                    ├── <swagger .json files>
                    └── examples/
    └── data-plane/
        └── <ServiceName2>/
            // Similar structure to above
```

## Validation Configuration

Validation mode is configurable via one mechanism:

### 1. Options-based Configuration (Optional parameters)

When instantiating the `FolderStructureRule` class, you can provide options to control which structure to validate:

```typescript
// Default: validate old structure only
const rule = new FolderStructureRule();

// Validate new structure only
const rule = new FolderStructureRule({
  validateOldStructure: false,
  validateNewStructure: true
});

// Validate both structures (passes if at least one validation passes)
const rule = new FolderStructureRule({
  validateOldStructure: true,
  validateNewStructure: true
});
```

## Validation Behavior

When validating both structures:
- If any validation mode passes, the overall validation is considered successful
- If all validation modes fail, the overall validation fails

This allows for a smooth transition between structures, as PRs can adhere to either the current or future structure during the transition period. If no options are provided, the default should be to test the current structure. The implementation should allow for an easy change of the default to the new directory structure as the transition project progresses.

Furthemore, the changes should be structured in a way that will allow us to remove the old structure checks once the transition is complete.