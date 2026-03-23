# API Version Evolution — Reference

**MUST NOT** call `azsdk_typespec_generate_authoring_plan` for API Version Evolution tasks.

---

## Step 2: Intake

Search using [agentic search](agentic-search.md) in below documents to determine information needed from user.

- MUST collect information from user rather than making assumptions.
- MUST use a user friendly way to collect information.
  e.g. you MUST List features from latest version and let user select which to carry over vs exclude, rather than assume user wants to carry over all features.

  | Doc                      | Guide URL                                                                                     |
  | ------------------------ | --------------------------------------------------------------------------------------------- |
  | Preview version overview | `https://azure.github.io/typespec-azure/docs/howtos/versioning/01-preview-version`            |
  | preview > preview        | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/02-preview-after-preview/` |
  | preview > stable         | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/03-stable-after-preview/`  |
  | stable > preview         | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/04-preview-after-stable/`  |
  | stable > stable          | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/05-stable-after-stable/`   |

---

## Step 3: Retrieve Authoring Plan

1. Build an authoring plan from the fetched guide. Follow its rules for carried-over features and excluded features. Note there should be only one preview version and the preview version should be decorated with `@previewVersion`.

2. Set up example folder: Copy all `.json` files from the latest version's `examples/` folder into new version's `examples/` folder. Create folder if necessary and update example content if necessary, e.g. api-version should be updated.

3. update readme.md.
