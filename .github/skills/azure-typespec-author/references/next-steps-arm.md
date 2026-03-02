# TypeSpec ARM Authoring - Next Steps

After authoring is complete, execute the follow-up steps below.

| Sub-step | Applies To | Goal |
|----------|-----------|------|
| [6.1 Verify Examples](#step-61-verify-examples) | All cases | Ensure example files are up-to-date |
| [6.2 Case-Specific Follow-up](#step-62-case-specific-follow-up) | Cases 1 & 2 only | Present targeted next steps |

---

## Step 6.1: Verify Examples

1. Check that example files under `examples/` match the current API version and operations
2. If examples are missing or outdated → **repeat from Step 1** to retrieve a plan for updating examples

---

## Step 6.2: Case-Specific Follow-up

> Only Cases 1 & 2 have follow-up actions. For all other cases, confirm completion and ask if the user has additional requests.

### Case 1: Add New Preview Version

Ask the user what features to add to the new preview version (e.g., new resources, operations, properties, models, enums, or deprecations). If none, confirm done.

### Case 2: Add New Stable Version

1. **Breaking change check** — Compare changes against the latest stable version. Flag removed/renamed properties, changed types, changed required/optional, removed resources/operations, changed response codes, or removed enum members. Breaking changes in stable versions require review and user confirmation.
2. **Preview feature promotion** — List features from the latest preview. Ask user whether to promote all or exclude specific features.
3. **Additional changes** — Ask the user what features to add to the stable version. If none, confirm done.
