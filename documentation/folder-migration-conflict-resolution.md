# Resolving Folder Migration Conflicts: A Guide for PR Authors

## Overview

When folder refactoring PRs (like [#36764](https://github.com/Azure/azure-rest-api-specs/pull/36764)) are merged, they may conflict with ongoing PRs that modify files within the refactored folders. This guide helps PR authors resolve these conflicts efficiently.

## Understanding Folder Migration

Folder migration PRs reorganize the directory structure to align with Azure folder structure guidelines. These changes typically involve:
- Moving files to new directory structures
- Updating path references in configuration files
- Consolidating related specifications
- Maintaining backward compatibility

## Common Conflict Scenarios

### Scenario 1: PR Targeting Latest Main (Post-Migration)
**Situation**: Your PR was created after the folder migration was merged into main.

**Resolution Steps**:
1. **Update your local repository**:
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Create a new branch from the updated main**:
   ```bash
   git checkout -b your-feature-branch-updated
   ```

3. **Cherry-pick your changes**:
   ```bash
   git cherry-pick <your-commit-hash>
   ```

4. **Update file paths in your changes**:
   - Locate the new file paths in the migrated structure
   - Update any references in your code changes
   - Verify all imports and references are correct

5. **Test your changes**:
   ```bash
   npm run test  # or relevant test command
   ```

6. **Create a new PR** targeting the updated main branch

### Scenario 2: PR Targeting Non-Latest Main (Pre-Migration)
**Situation**: Your PR was created before the folder migration and targets an older version of main.

**Resolution Steps**:

#### Option A: Rebase Against Latest Main (Recommended)
1. **Fetch the latest changes**:
   ```bash
   git fetch origin main
   ```

2. **Rebase your branch against the updated main**:
   ```bash
   git checkout your-feature-branch
   git rebase origin/main
   ```

3. **Resolve migration conflicts**:
   - During rebase, Git will show conflicts for moved files
   - For each conflict, determine the new file location
   - Update your changes to use the new file paths
   - Use `git add <file>` after resolving each conflict
   - Continue with `git rebase --continue`

4. **Update path references**:
   - Check for any hardcoded paths in your changes
   - Update import statements and file references
   - Verify configuration file paths

#### Option B: Create Fresh PR Against Latest Main
1. **Note your changes**:
   ```bash
   git diff main..your-feature-branch > my-changes.patch
   ```

2. **Create new branch from latest main**:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b your-feature-branch-migrated
   ```

3. **Apply changes to new structure**:
   - Manually apply changes from your patch file
   - Use the new file paths and directory structure
   - Ensure all references are updated

## File Path Mapping Examples

### App Service Migration Example
Based on PR #36764, here are common path changes:

**Before Migration**:
```
specification/app/resource-manager/Microsoft.App/stable/2024-03-01/ContainerApps.json
specification/app/data-plane/Microsoft.App/stable/2024-02-02-preview/DynamicSessions.json
```

**After Migration**:
```
specification/app/resource-manager/Microsoft.App/ContainerApps/stable/2024-03-01/ContainerApps.json
specification/app/data-plane/DynamicSessions/stable/2024-02-02-preview/DynamicSessions.json
```

### Common Path Updates Needed

1. **Readme.md files**:
   ```yaml
   # Before
   input-file:
     - Microsoft.App/stable/2024-03-01/ContainerApps.json
   
   # After  
   input-file:
     - Microsoft.App/ContainerApps/stable/2024-03-01/ContainerApps.json
   ```

2. **tspconfig.yaml files**:
   ```yaml
   # Before
   emitters:
     "@azure-tools/typespec-autorest":
       output-dir: "../"
   
   # After
   emitters:
     "@azure-tools/typespec-autorest":
       output-dir: "../../"
   ```

3. **Example file references**:
   ```json
   // Before
   "$ref": "../examples/ContainerApps_Get.json"
   
   // After  
   "$ref": "../../examples/ContainerApps_Get.json"
   ```

## Step-by-Step Conflict Resolution

### Step 1: Identify Affected Files
1. Compare your PR's changed files with the migration PR
2. Note which files have been moved or had their paths changed
3. Create a mapping of old paths to new paths

### Step 2: Update File Locations
```bash
# For each moved file in your PR
git mv old/path/file.json new/path/file.json
```

### Step 3: Update Internal References
1. **Search for path references**:
   ```bash
   grep -r "old/path" . --include="*.json" --include="*.md" --include="*.yaml"
   ```

2. **Update references systematically**:
   - Configuration files (readme.md, tspconfig.yaml)
   - JSON $ref references
   - Import statements
   - Example file paths

### Step 4: Validate Changes
1. **Run linting and validation**:
   ```bash
   npm run lint
   npm run validate
   ```

2. **Test compilation** (for TypeSpec):
   ```bash
   tsp compile .
   ```

3. **Verify examples load correctly**

### Step 5: Update PR Description
- Document the path changes made
- Reference the original migration PR
- Explain how conflicts were resolved

## Automation and Tools

### Using Git Helpers
```bash
# Find all renamed files between commits
git diff --name-status HEAD~1 HEAD

# Show file moves
git log --follow --stat -- path/to/file

# Find similar files in new structure
find . -name "*.json" -path "*/ContainerApps/*" -type f
```

### Batch Path Updates
```bash
# Replace paths in multiple files
find . -name "*.md" -exec sed -i 's|old/path|new/path|g' {} +
find . -name "*.json" -exec sed -i 's|old/path|new/path|g' {} +
```

## Best Practices

### Before Starting Resolution
1. **Backup your work**:
   ```bash
   git branch backup-branch your-feature-branch
   ```

2. **Document your original intent** to maintain context during resolution

3. **Review the migration PR** to understand the new structure

### During Resolution
1. **Resolve conflicts incrementally** rather than all at once
2. **Test frequently** to catch issues early
3. **Keep commits atomic** and well-documented
4. **Use descriptive commit messages** that reference the migration

### After Resolution
1. **Verify all CI checks pass**
2. **Update PR description** with resolution details
3. **Add appropriate labels** (e.g., `post-migration-fix`)
4. **Request review** from migration PR authors if needed

## Prevention Strategies

### For Future PRs
1. **Check for ongoing migrations** before starting work
2. **Coordinate with migration authors** on timing
3. **Use relative paths** where possible to reduce impact
4. **Keep PRs focused and small** to minimize conflict surface

### For Teams
1. **Communicate migration timelines** broadly
2. **Provide advance notice** of structural changes
3. **Create migration guides** specific to your service
4. **Consider feature freezes** during major migrations

## Getting Help

### Resources
- [Azure Folder Structure Guidelines](link-to-guidelines)
- [Migration PR #36764](https://github.com/Azure/azure-rest-api-specs/pull/36764)
- [Git Conflict Resolution Guide](link-to-git-guide)

### Support Channels
- **Azure SDK Support**: [aka.ms/azsdk/support](https://aka.ms/azsdk/support)
- **Spec Review Channel**: [aka.ms/azsdk/support/specreview-channel](https://aka.ms/azsdk/support/specreview-channel)
- **Migration Questions**: Tag migration PR authors in comments

### Escalation
If you encounter complex conflicts that can't be resolved using this guide:
1. Comment on the migration PR with your specific issue
2. Tag the migration authors for assistance
3. Provide details about your use case and constraints
4. Consider scheduling a sync meeting for complex scenarios

## Examples from Real PRs

### Example 1: Logic Apps Extension (PR #34804)
**Original Path**: `specification/app/resource-manager/Microsoft.App/stable/2025-07-01/LogicAppsExtension.json`
**New Path**: `specification/app/resource-manager/Microsoft.App/ContainerApps/stable/2025-07-01/LogicAppsExtension.json`

**Resolution**:
```bash
# Move the file
git mv specification/app/resource-manager/Microsoft.App/stable/2025-07-01/LogicAppsExtension.json \
       specification/app/resource-manager/Microsoft.App/ContainerApps/stable/2025-07-01/LogicAppsExtension.json

# Update readme.md references
sed -i 's|Microsoft.App/stable/2025-07-01/LogicAppsExtension.json|Microsoft.App/ContainerApps/stable/2025-07-01/LogicAppsExtension.json|g' specification/app/resource-manager/readme.md
```

### Example 2: Web API Version (PR #26646)
**Note**: This PR affects a different service area, so migration impact is minimal. However, if there were shared dependencies:

**Resolution Strategy**:
1. Identify any cross-service references
2. Update shared configuration files
3. Verify no breaking changes to dependent services

## Troubleshooting Common Issues

### Issue: "File not found" errors after migration
**Solution**: 
1. Verify the new file path exists
2. Check for typos in path updates
3. Ensure relative path calculations are correct

### Issue: CI checks failing after path updates
**Solution**:
1. Review CI logs for specific failures
2. Check that all example files are accessible
3. Verify configuration file syntax is correct
4. Run local validation before pushing

### Issue: Merge conflicts persist after resolution
**Solution**:
1. Ensure you're rebasing against the latest main
2. Verify all moved files are properly tracked by Git
3. Check for hidden files or directories that were moved
4. Consider using `git status` to see untracked changes

### Issue: Breaking changes detected in SDK generation
**Solution**:
1. Review if the migration changed any API contracts
2. Update SDK generation configuration files
3. Verify that only paths changed, not API definitions
4. Consult with SDK team if contracts were affected

---

*This guide is maintained by the Azure REST API Specs team. Please contribute improvements and real-world examples as you encounter them.*
