- DO NOT use MCP tool from azure-sdk-mcp
- Prefer to use MCP tool from java-sdk-tools

When asked to "fix typespec migration for <service>".
1. Find the service folder under "specification/<service>".
2. Find the "tspconfig.yaml", should be under a "resource-manager" sub-folder, or a "<Serivce>.Management" sub-folder.
3. Cd into the folder of "tspconfig.yaml"
4. Create a "mgmt_java_mitigate-typespec-<service>" branch from local "main" branch. (If this branch already exists in local, just switch to it)
5. Apply "migitigateMigrationTypeSpec" MCP tool
6. When done, only commit "tspconfig.yaml" and .tsp files
7. Create a draft PR, open in browser
8. Add label "PublishToCustomers", "ARMSignedOff", "BreakingChange-Go-Sdk-Approved", "BreakingChange-JavaScript-Sdk-Approved", "BreakingChange-Python-Sdk-Approved" to the draft PR

- When generate SDK fails with "duplicate-client-name" error, use `@@clientName(, "java")` to rename a model.
