# Table of Contents
- [Overview](#overview)
- [Suppressing Failures](#suppressing-failures)
- [Renaming Specs](#renaming-specs)

# Overview
Check `TypeSpec Requirement` enforces the rule that all "new" specs must use TypeSpec (instead of hand-written Swagger).  A "new" spec is defined as any spec that does **not** have a `stable` version in `main`.

# Suppressing Failures
If you need to suppress this check (instead of converting to TypeSpec), add entries to the `suppressions.yaml` for your spec.  Example:

```
# specification/widget/resource-manager/Microsoft.Widget/Widget/suppressions.yaml
- tool: TypeSpecRequirement
  paths:
    - preview/2022-08-01-preview/**/*.json
    - preview/2023-02-01-preview/**/*.json
```

More examples: https://github.com/search?q=TypeSpecRequirement+repo%3Aazure%2Fazure-rest-api-specs+path%3A**%2Fsuppressions.yaml&type=code

# Renaming Specs
The check may return a "false positive" if you rename an existing spec folder in a PR, since the new name doesn't exist in `main`.  You can use a suppression in these cases.
