# Prompt 01 — Update reference documents

You are updating the `azure-typespec-author` skill's reference documentation so that
every eval scenario maps to an authoritative TypeSpec document.

## Task

Sync `.github/skills/azure-typespec-author/references/reference-document-links.md`.

Categories (these 9 categories MUST exist, in this order):

1. ARM Resource Types
2. ARM Resource Operations
3. Data-Plane Operations
4. API Versioning
5. Long-Running Operations (LRO)
6. Paging
7. Models and Enums
8. Decorators
9. Warnings

Rules:

- Categorize every document under one of the 9 categories above.
- Do **not** include the "Migrate Swagger to TypeSpec" material.
- Avoid adding a new case/category if the topic fits an existing case. Fold niche ARM
  scenarios (private endpoints/links, network security perimeter, common types, change
  provider namespace, portal defaults, content negotiation) into the closest core case.
- Keep the existing markdown format and table structure.
- Do **not** commit, stage, or push. Leave your edits unstaged in the working tree so
  the user can review them and decide whether to commit.

## Sources (authoritative only)

1. https://azure.github.io/typespec-azure/
2. https://typespec.io/docs/

## Validation

- Every URL you add or keep must return HTTP 200.
- The 9 category headings must be present and non-empty.
