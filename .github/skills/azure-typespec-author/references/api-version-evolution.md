# API Version Evolution — Reference

**MUST NOT** call `azsdk_typespec_generate_authoring_plan` for API Version Evolution tasks.

---

## Step 2: Intake

Search using [agentic search](agentic-search.md) in below documents to determine intake details. List features from latest version in a table and ask the user which to carry over vs exclude.

   | Latest > Target   | Guide URL                                                                                     |
   | ----------------- | --------------------------------------------------------------------------------------------- |
   | preview > preview | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/02-preview-after-preview/` |
   | preview > stable  | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/03-stable-after-preview/`  |
   | stable  > preview | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/04-preview-after-stable/`  |
   | stable  > stable  | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/05-stable-after-stable/`   |


---

## Step 3: Retrieve Authoring Plan


1. Build an authoring plan from the fetched guide. Follow its rules for carried-over features and excluded features.

2. Set up example folder: Copy all `.json` files from the latest version's `examples/` folder into `{project-root}/{version-status}/{target-version}/examples/`, e.g. from 
`stable/2021-11-01/examples` to `preview/2024-02-01-preview/examples`. Create folder if necessary and update example content if necessary, e.g. api-version should be updated.

3. update readme.md.