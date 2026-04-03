# SDK Impact Check

After TypeSpec validation and compilation pass (Steps 5.1–5.3), check whether your changes break SDK generation. This catches breaking changes **before merge**, preventing weeks of back-and-forth.

## When to Run

**Recommended** when your TypeSpec changes involve:
- Model renames, removals, or type changes
- Enum changes (enum → extensible union breaks Java)
- Property type changes or renames
- Operation signature changes (parameters, return types)
- Removing or adding `@removed`/`@added` version decorators
- Any change that modifies the public API surface

**Can skip** for documentation-only changes, example file updates, or suppression changes.

## Procedure

### Step 6.1: Generate SDK

Run `azure-sdk-mcp:azsdk_package_generate_code` for at least one target language SDK.

- Provide the `tspConfigPath` pointing to the TypeSpec project's `tspconfig.yaml`
- Provide the `localSdkRepoPath` pointing to the local SDK repository clone
- If generation fails, the TypeSpec may have structural issues — fix and re-validate

### Step 6.2: Build SDK

Run `azure-sdk-mcp:azsdk_package_build_code` with the generated package path.

- **Build passes** → your TypeSpec changes are SDK-safe. Done.
- **Build fails** → proceed to Step 6.3

### Step 6.3: Apply Customizations

Run `azure-sdk-mcp:azsdk_customized_code_update` with:
- `packagePath`: the SDK package directory
- `tspProjectPath`: the TypeSpec project directory
- `customizationRequest`: the build error output from Step 6.2

The tool handles the full workflow internally:
1. Classifies the issue (TypeSpec decorator fix vs code patch)
2. Applies `client.tsp` decorators (Phase A) — handles ~80% of issues
3. Regenerates and rebuilds
4. If build still fails, applies code patches (Phase B) — handles ~10%
5. Returns summary of changes and any items needing manual intervention

### Step 6.4: Report Results

Report to the user:
- Number of SDK breaking changes detected
- What `client.tsp` customizations were applied (e.g., `@@clientName`, `@@access`)
- Whether the SDK build now passes
- Any items requiring manual intervention

## Common Breaking Change Patterns

| TypeSpec Change | SDK Impact | Typical Fix |
|----------------|-----------|-------------|
| Enum → extensible union | Breaks Java (enum ordinal) | `@@alternateType` or `@@clientName` |
| Model renamed | Breaks all languages | `@@clientName` to preserve old name |
| Property type changed | Breaks return types | `@@alternateType` per language scope |
| Property renamed | Breaks customization code | `@@clientName` + update patch files |
| Property removed in new version | Breaks backward compat | Version gate with `@removed` |
| Operation signature changed | Breaks client methods | `@@clientName` + `@@access` |
| New property conflicts with customization | Breaks Java/Python custom code | Remove manual injection from customization |

## Prerequisites

- Local clone of `azure-sdk-for-{language}` repository
- `azure-sdk-mcp` server running with SDK generation tools available
- Language build tools installed (verified with `azure-sdk-mcp:azsdk_verify_setup`)
