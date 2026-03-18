# API Version Evolution — Reference

**MUST NOT** call `azsdk_typespec_generate_authoring_plan` for version evolution tasks.

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

## Step 3: Retrieve Solution

Build an implementation plan from the fetched guide. Follow its rules for carried-over features and excluded features.