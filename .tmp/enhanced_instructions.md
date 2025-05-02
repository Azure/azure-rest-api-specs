# Enhanced Instructions for Restructuring Directories to Align with TypeSpec Guidelines

## Original Instructions
The TypeSpec team is implementing new directory structure guidelines for all Azure services using TypeSpec. The new directory structure guidelines are described in this document:
`C:\Users\marioguerra\Work\azure-rest-api-specs\.tmp\new_directory_structure.md`

Your mission is to restructure existing service directories to adhere to the new guidelines. We are going to work on just one service as a test. The service is here:
`C:\Users\marioguerra\Work\azure-rest-api-specs\specification\liftrneon`

Review the new directory structure rules and thoroughly understand them. Then review the existing structure of the `liftrneon` directory and its contents. Produce a plan for updating the `liftrneon` directory and its contents to conform to the new directory structure guidance defined in `new_directory_structure.md`.

Examine the project carefully, since the TypeSpec files within include import statements that will need to be modified to adhere to the new directory structure. There may be other aspects of the project that also require modification, so be diligent in your analysis. Beyond moving content and updating aspects of the content that depend on the directory structure, *you are not allowed to modify the contents of the directory*, nor can you add or delete contents. This effort is a reorganization of existing content, *not* a redesign.

*DO NOT MAKE ASSUMPTIONS.* If anything requires clarification, ask questions. The TypeSpec team is more than happy to help you!

---

## Enhanced Guidelines

### 1. Directory Structure Guidelines
- **Visual Representation**: Include a diagram or example of the expected directory structure to provide clarity.
- **Mapping to Configuration**: Clearly specify how each directory maps to the `tspconfig.yaml` configuration.

### 2. Configuration Best Practices
- **Relative Paths**: Always use relative paths in `tspconfig.yaml` to ensure compatibility across multiple environments.
- **Examples**:
  - Correct: `{project-root}/resource-manager/Neon.Postgres.Management/examples`
  - Incorrect: Absolute paths like `C:/Users/...`

### 3. Common Issues and Resolutions
- **Path Concatenation Warnings**:
  - Cause: Incorrect `examples-dir` configuration in `tspconfig.yaml`.
  - Resolution: Ensure the path aligns with the new directory structure and uses relative paths.
- **Missing Directories or Files**:
  - Cause: Directories or files expected by the TypeSpec compiler are missing.
  - Resolution: Verify the directory structure matches the guidelines. Do not create placeholders unless explicitly instructed.

### 4. Troubleshooting Checklist
- Verify the directory structure matches the new guidelines.
- Ensure all paths in `tspconfig.yaml` are relative and correctly configured.
- Recompile the project and analyze warnings or errors.
- Cross-check the `examples-dir` configuration against the expected structure.

### 5. Iterative Process Acknowledgment
- Acknowledge that some iteration may be required but provide a checklist to minimize unnecessary steps.

---

By following these enhanced instructions, future efforts to align with the new directory structure guidelines can be more efficient and less error-prone.
