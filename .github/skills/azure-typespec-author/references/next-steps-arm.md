# TypeSpec ARM Authoring - Next Steps

After authoring is complete, execute the follow-up steps below.

> For cases other than Cases 1 & 2, confirm completion and ask if the user has additional requests. If the user requests changes, **restart from Step 1**.

---

## Case 1: Add New Preview Version

1. Check that example files under `examples/` match the new API version and operations. If examples are missing or outdated → **repeat from Step 1** to update them.
2. Ask the user what features they want to add to this version (e.g., new resources, operations, properties, models). Use the current service context to suggest relevant examples.

If the user provides a feature request → **restart from Step 1** (full workflow loop). If done → confirm completion.

## Case 2: Add New Stable Version

1. Check that example files under `examples/` match the new API version and operations. If examples are missing or outdated → **repeat from Step 1** to update them.
2. **Breaking change check** — Compare changes against the latest stable version. Flag removed/renamed properties, changed types, changed required/optional, removed resources/operations, changed response codes, or removed enum members. Breaking changes in stable versions require review and user confirmation.
3. **Preview feature promotion** — List features from the latest preview. Ask user whether to promote all or exclude specific features.
4. **Additional changes** — Ask the user what features they want to add to this version. Use the current service context to suggest relevant examples. If the user provides a feature request → **restart from Step 1** (full workflow loop). If done → confirm completion.
