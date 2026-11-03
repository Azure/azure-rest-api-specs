# Azure TypeSpec Assessment

Use `azure-typespec-assessment` with your coding agent to review TypeSpec
changes and generate an assessment report without modifying your source.
Make sure the skill is available to your agent.

## 1. Assess local code

Open your TypeSpec repository and ask:

```text
Use azure-typespec-assessment to assess the current TypeSpec changes in the Microsoft.ServiceNetworking/ServiceNetworking specification.
```

Replace the specification name with the one you are working on. Local assessment
is the primary experience; you do not need to open a PR first.

If you omit the baseline, the agent asks you to confirm `origin/main` or provide
another ref or commit ID before starting. You can specify a commit ID directly
to skip the question:

```text
Use azure-typespec-assessment to assess the current TypeSpec changes in the Microsoft.ServiceNetworking/ServiceNetworking specification against commit <commit-id>.
```

## 2. Assess a PR

Provide the PR URL:

```text
Use azure-typespec-assessment to assess the TypeSpec changes for PR https://github.com/Azure/azure-rest-api-specs/pull/44988.
```

The skill does not require a separate PR checkout or manual project lookup. PR
assessment requires authenticated `gh` and `git` commands. The skill identifies
the changed TypeSpec scope, compares the relevant API versions, and produces a
validated report.

## 3. Assess after authoring

When both skills are installed, `azure-typespec-author` offers
**"Would you like to quickly assess your changes?"** after successful authoring
and validation. Choose **Run fast assessment (Recommended)** or **Skip**.
An earlier assessment decision for those changes is respected without another
prompt. Accepting still requires a confirmed baseline for local assessment.

The handoff uses fast mode: Semantic intents, REST and downstream SDK
compatibility, and Documentation Completeness remain assessed in the existing
report layout. Azure Guidelines search and judgment are skipped; its card and
section show `0 findings` and `Skipped`, not passed. Assessment is read-only
and does not automatically fix findings.

## Results

The agent starts a local-only report server after rendering and returns a
clickable `http://127.0.0.1:<port>/assessment.html` link. Keep the assessment
session running while viewing the report. Structured results remain available
at the absolute `assessment.json` path returned by the agent.

[Browse reports for 13 existing PRs](https://wonderful-coast-0b5cc5a00.3.azurestaticapps.net)
or read the [high-level design spec](https://github.com/Azure/azure-sdk-tools/blob/main/tools/azsdk-cli/docs/specs/typespec-assessment.spec.md)
and [detailed design](design.md).
