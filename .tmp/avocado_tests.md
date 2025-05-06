Below is a comprehensive list of the tests in the Azure/azure-rest-api-specs repository that rely on the directory structure under the `specifications` folder. I have included the file names, line numbers, and a detailed explanation of the portions of each test that depend on the directory structure. This list is intended to be clear and actionable for you to update these tests to support both the new and old directory structures.

The new directory structure is defined in this document:
C:\Users\marioguerra\Work\azure-rest-api-specs\.tmp\new_directory_structure.md
---

### **File: `eng/tools/typespec-validation/test/folder-structure.test.ts`**

#### 1. **Test: Folder must follow capitalization rules**
- **Line Numbers**: 27–51
- **Description**: This test ensures that folders under `specifications/` are not capitalized. It explicitly checks for paths like `/gitroot/specification/Foo/Foo/`.
- **Directory Dependency**: The test assumes a specific folder structure under `specifications/`. Any changes to the directory naming conventions (e.g., capitalization rules) will require updates here.

#### 2. **Test: Folder must not exceed 3 levels of depth**
- **Line Numbers**: 52–77
- **Description**: This test validates that folders under `specifications/` do not nest deeper than three levels. For instance, it checks paths like `/gitroot/specification/foo/Foo/Foo/Foo`.
- **Directory Dependency**: The test explicitly enforces restrictions on folder depth within `specifications/`.

#### 3. **Test: Second-level folders must have proper capitalization**
- **Line Numbers**: 78–104
- **Description**: This test ensures that second-level folders (e.g., `data-plane`, `resource-manager`) are capitalized correctly.
- **Directory Dependency**: It assumes that specific subfolders exist in a predefined structure, such as `/gitroot/specification/foo/data-plane`.

#### 4. **Test: Folder must contain specific configuration files**
- **Line Numbers**: 106–134
- **Description**: This test validates that folders under `specifications/` contain required files like `main.tsp` or `client.tsp`. If these files are missing, the test fails.
- **Directory Dependency**: Assumes a fixed directory layout with configuration files located within specific folders.

#### 5. **Test: Shared folders must follow management conventions**
- **Line Numbers**: 106–166
- **Description**: This test verifies that shared folders are correctly named and positioned within the directory structure.
- **Directory Dependency**: Assumes that shared folders follow a specific naming and placement convention.

#### 6. **Test: Folder must contain examples**
- **Line Numbers**: 167–201
- **Description**: This test ensures that folders containing `main.tsp` files also include an `examples/` directory.
- **Directory Dependency**: Assumes that examples are always under specific subdirectories.

#### 7. **Test: Resource manager folders must follow naming conventions**
- **Line Numbers**: 203–234
- **Description**: This test checks that folders like `resource-manager` and `data-plane` adhere to specific naming conventions.
- **Directory Dependency**: Relies on the presence of these subfolders in specific locations within `specifications/`.

#### 8. **Test: Data-plane management rules**
- **Line Numbers**: 235–263
- **Description**: This test validates that folders like `data-plane` conform to specific rules regarding naming and contents.
- **Directory Dependency**: Assumes that `data-plane` folders are organized in a specific manner.

---

### **File: `eng/tools/spec-gen-sdk-runner/test/utils/searchRelatedParentFolders.test.ts`**

#### 1. **Test: Finds readme files for multiple paths**
- **Line Numbers**: 1–20
- **Description**: This test searches for `readme.md` files in folders under `specifications/` for validation purposes.
- **Directory Dependency**: Assumes that `readme.md` files are located in specific subdirectories like `resource-manager` or `data-plane`.

#### 2. **Test: Handles files from the same parent directory**
- **Line Numbers**: 21–41
- **Description**: This test verifies that files from the same parent directory are correctly identified.
- **Directory Dependency**: Relies on a fixed folder structure under `specifications/`.

#### 3. **Test: Stops at folder boundary**
- **Line Numbers**: 42–68
- **Description**: This test ensures that the search does not go beyond the specified folder boundary, such as `specifications/`.
- **Directory Dependency**: Assumes that folders have clear boundaries within the directory structure.

#### 4. **Test: Finds `tspconfig.yaml`**
- **Line Numbers**: 70–83
- **Description**: This test searches for `tspconfig.yaml` files within `specifications/`.
- **Directory Dependency**: Assumes that configuration files are located in specific subdirectories.

---

### **File: `eng/tools/spec-gen-sdk-runner/test/utils/utils.test.ts`**

#### 1. **Test: Finds all `tspconfig.yaml` files recursively**
- **Line Numbers**: 1–24
- **Description**: This test verifies that all `tspconfig.yaml` files in the `specifications/` directory can be located recursively.
- **Directory Dependency**: Assumes a specific folder structure for locating configuration files.

#### 2. **Test: Extracts path from `specifications` folder**
- **Line Numbers**: 55–83
- **Description**: This test extracts relative paths for files located within the `specifications/` folder.
- **Directory Dependency**: Relies on the assumption that files are located in predefined subdirectories.

---

### **File: `eng/tools/typespec-validation/test/sdk-tspconfig-validation.test.ts`**

#### 1. **Test: Validates configuration options for languages**
- **Line Numbers**: 231–259, 329–361, 397–433, 458–484
- **Description**: These tests validate options like `package-dir`, `service-dir`, and other configurations for languages such as Python, Java, Go, and C#.
- **Directory Dependency**: Assumes that these options are defined in configuration files located in specific subdirectories under `specifications/`.

---

### Action Plan for Updating Tests

1. **Identify the changes in the directory structure**:
   - Determine how the new structure differs from the old one.
   - Document the new paths and folder naming conventions.

2. **Update the tests**:
   - Modify test cases to handle both the old and new directory structures.
   - For each test, add logic to check for files in both the old and new paths.
   - Ensure that the tests still enforce the required rules for the new structure.

3. **Add comments**:
   - Clearly document the changes made to each test.
   - Explain how the new structure is supported.

4. **Test thoroughly**:
   - Run all updated tests to verify that they work with both the old and new structures.
   - Fix any issues that arise during testing.
