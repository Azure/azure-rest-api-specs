# Instructions for Restructuring Directories to Align with TypeSpec Guidelines

## Objective
The TypeSpec team is implementing new directory structure guidelines for all Azure services using TypeSpec. The goal is to restructure existing service directories to adhere to these new guidelines.

## Instructions

### 1. Review the New Directory Structure Guidelines
- The new directory structure guidelines are described in this document:
  `C:\Users\marioguerra\Work\azure-rest-api-specs\.tmp\new_directory_structure.md`
- Thoroughly understand the guidelines before proceeding.

### 2. Analyze the Existing Directory
- The service to be restructured is located here:
  `C:\Users\marioguerra\Work\azure-rest-api-specs\specification\liftrneon`
- Review the existing structure of the `liftrneon` directory and its contents.

### 3. Plan the Restructuring
- Produce a plan for updating the `liftrneon` directory and its contents to conform to the new directory structure guidance.
- Ensure the plan includes updates to TypeSpec files, such as import statements, to align with the new structure.
- Ensure the plan includes steps to move *all* content from the existing directory structure to the new directory structure.
- Ensure the plan includes steps to remove all artifacts and remnants of the old directory structure.
- Ensure the plan includes a thorough review and update of documentation like README files to accurately align with the new directory structure.
- Ensure the plan includes steps to update relative paths in `tspconfig.yaml` to align with the new directory structure.

### 4. Configuration Best Practices
- **Relative Paths**: Always use relative paths in `tspconfig.yaml` to ensure compatibility across multiple environments.
- **Examples**:
  - Correct: `{project-root}/resource-manager/Neon.Postgres.Management/examples`
  - Incorrect: Absolute paths like `C:/Users/...`

### 5. Common Issues and Resolutions
- **Path Concatenation Warnings**:
  - Cause: Incorrect `examples-dir` configuration in `tspconfig.yaml`.
  - Resolution: Ensure the path aligns with the new directory structure and uses relative paths.
- **Missing Directories or Files**:
  - Cause: Directories or files expected by the TypeSpec compiler are missing.
  - Resolution: Verify the directory structure matches the guidelines. Do not create placeholders unless explicitly instructed.

### 6. Troubleshooting Checklist
- Verify the directory structure matches the new guidelines.
- Ensure all paths in `tspconfig.yaml` are relative and correctly configured.
- Recompile the project and analyze warnings or errors.
- Cross-check the `examples-dir` configuration against the expected structure.

### 7. Iterative Process Acknowledgment
- Acknowledge that some iteration may be required but provide a checklist to minimize unnecessary steps.

### 8. Restrictions
- Beyond moving content and updating aspects of the content that depend on the directory structure, *you are not allowed to modify the contents of the new directory structure*, nor can you add or delete contents. Once the new directory structure is in place and all content within the new directory structure is intact and successfully updated, you are to remove the old directory structure and any artifacts related to it.
- *DO NOT MAKE ASSUMPTIONS.* If anything requires clarification, ask questions. The TypeSpec team is more than happy to help you!

