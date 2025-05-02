# Plan for Updating Tests to Support the New Directory Structure

This document outlines a plan for updating tests in the Azure REST API specifications repository to support both the new and old directory structures during the transition period.

## Overview of Changes

Based on the new directory structure document, we need to update several test files that currently validate or depend on the existing directory structure in the `specifications/` folder. The key changes include:

1. Replacing the `orgName` folder under `specifications/` with the `RPNamespace` name
2. Enforcing strict rules for the `resource-manager` and `data-plane` folders
3. Clear structure for service folders with specific requirements for examples, preview, and stable versions
4. Special handling for the "operations" service folder

## Key Requirements

**Use Existing Framework Only**: All updates must use the existing test framework and dependencies. No new packages or tools should be added without significant justification. This ensures minimal disruption to the current CI/CD pipeline and keeps the solution maintainable.

## Detailed Plan

### 1. Update `eng/tools/typespec-validation/test/folder-structure.test.ts`

This file already has a framework for validating both old and new structures, using the `validateOldStructure` and `validateNewStructure` options. We need to enhance these tests to properly validate the new structure requirements.

**Action Items:**

- **Support for both paths**: Modify tests to recognize both old paths (e.g., `/gitroot/specification/orgName/Foo.Management`) and new paths (e.g., `/gitroot/specification/RPNamespace/resource-manager/ServiceName`).
- **New structure validation**: Enhance the existing "new-folder-structure" tests to validate:
  - The "operations" service folder requirement (rule #10 in the new structure document)
  - Strict naming conventions for version folders (YYYY-MM-DD-preview or YYYY-MM-DD)
  - Rule #9 prohibiting a preview and stable version with the same date
- **Helper functions**: Create helper functions for generating old and new paths to be used across tests
- **Mixed validation**: Enhance the "mixed-validation" tests to ensure that during the transition period, paths in both structures can pass validation

### 2. Update `eng/tools/spec-gen-sdk-runner/test/utils/searchRelatedParentFolders.test.ts`

This file tests the functionality to find related parent folders for files in the repository.

**Action Items:**

- **Test data update**: Modify the test data to include paths that follow both old and new directory structures
- **Fixture update**: Create test fixtures that mirror both the old and new structures
- **Validation adaptations**: Update the expectations to recognize paths in both structures
- **New tests**: Add test cases specifically for the new structure to ensure compatibility

### 3. Update `eng/tools/spec-gen-sdk-runner/test/utils/utils.test.ts`

This file tests utility functions that deal with file paths and directory structure.

**Action Items:**

- **findFilesRecursive**: Update test cases to recognize and validate files in both structures
- **findReadmeFiles**: Modify to account for the new placement of readme files according to the new structure
- **getRelativePathFromSpecification**: Ensure this function correctly handles paths in both the old and new structures
- **New directory constants**: Create constants for both old and new directory structures to avoid duplication in tests

### 4. Update `eng/tools/typespec-validation/test/sdk-tspconfig-validation.test.ts`

This file validates configuration options for different languages.

**Action Items:**

- **Path validation**: Update the validation logic to recognize paths in both structures
- **Configuration expectations**: Modify test expectations to accept configurations from both structures
- **New structure tests**: Add test cases to explicitly validate configurations in the new structure
- **Shared helpers**: Create helper functions for generating valid paths in both structures

## Implementation Strategy

For a smooth transition that supports both structures, we will follow these strategies while adhering strictly to the existing framework and dependencies:

### 1. Leverage Existing Configuration Options

The `FolderStructureRule` class already contains configuration options that allow us to validate either or both directory structures:

```typescript
// Use existing options for conditional validation
const rule = new FolderStructureRule({ 
  validateOldStructure: true, // Enable validation for the old structure
  validateNewStructure: true  // Enable validation for the new structure
});
```

We'll utilize these existing parameters rather than creating new configuration systems.

### 2. Utilize Existing Mocking Framework

The test files already use Vitest's mocking capabilities extensively, particularly for file system operations:

```typescript
// Example of using the existing mocking framework
vi.mocked(globby.globby).mockImplementation(async (patterns: string | readonly string[]) => {
  const patternStr = typeof patterns === "string" ? patterns : patterns.join(",");
  if (patternStr.includes("/*")) {
    return ["tspconfig.yaml", "main.tsp", "examples/", "preview/", "stable/"];
  }
  return [];
});
```

We'll continue to use these existing mocking patterns to simulate both directory structures.

### 3. Extend Existing Helper Functions

Instead of creating new utility libraries, we'll extend the existing helper functions in `mocks.js` and other utility files:

```typescript
// Extend existing mock functions rather than creating new ones
function mockFileSystem(structureType: "old" | "new") {
  if (structureType === "old") {
    return mockOldFileStructure();
  } else {
    return mockNewFileStructure();
  }
}
```

### 4. Re-use Existing Testing Patterns

We'll adapt the existing testing patterns to validate both old and new directory structures without introducing new frameworks or dependencies.

## Detailed Test Case Updates

### For folder-structure.test.ts:

1. **Add tests for "operations" service folder**:
   ```typescript
   it("should validate a valid operations folder in resource-manager", async function () {
     mockResourceManagerRoot(true, true); // Second parameter indicates valid operations folder
     const rule = new FolderStructureRule({ validateOldStructure: false });
     const result = await rule.execute("/gitroot/specification/foo/resource-manager/operations");
     assert(result.success);
   });

   it("should fail when operations folder missing required files", async function () {
     // Test implementation here
   });
   ```

2. **Add tests for version folder date validation**:
   ```typescript
   it("should fail when preview and stable have same date", async function () {
     mockPreviewVersionWithMatchingStable();
     const rule = new FolderStructureRule({ validateOldStructure: false });
     const result = await rule.execute("/gitroot/specification/foo/resource-manager/myservice");
     assert(!result.success);
     assert(result.errorOutput && result.errorOutput.includes("same date"));
   });
   ```

### For searchRelatedParentFolders.test.ts:

Add tests for the new structure:

```typescript
test("finds readme files in new structure", () => {
  const files = [
    "specification/Microsoft.Contoso/resource-manager/myservice/preview/2022-01-01-preview/examples/Widget_Get.json",
    "specification/Microsoft.Contoso/data-plane/myservice/preview/2022-11-01-preview/widgets.json",
  ];

  const result = searchRelatedParentFolders(files, {
    searchFileRegex: readmeMdRegex,
    specRepoFolder: repoRoot,
    stopAtFolder: "specification",
  });

  expect(Object.keys(result)).toHaveLength(2);
  expect(result["specification/Microsoft.Contoso/resource-manager"]).toBeDefined();
  expect(result["specification/Microsoft.Contoso/data-plane"]).toBeDefined();
});
```

## Timeline and Validation

1. **Phase 1 (Week 1)**: Update the helper functions and test fixtures to support both structures
2. **Phase 2 (Week 2)**: Update the validation logic in all test files
3. **Phase 3 (Week 3)**: Add new test cases specifically for the new structure
4. **Phase 4 (Week 4)**: Final validation and cleanup

After each phase, run the full test suite to ensure that both structures are properly supported.

## Conclusion

This plan provides a comprehensive approach to updating the tests to support both directory structures during the transition period. By following this plan, we will ensure that the tests validate specifications in both the old and new directory structures, allowing for a smooth migration.
