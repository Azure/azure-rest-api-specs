---
on:
  pull_request_target:
    types: [labeled]
labels: [spec-architecture-review-needed]
if: github.event.label.name == 'spec-architecture-review-needed'
description: "Spectre: Review a pull request for API specification design issues"
permissions:
  contents: read
  pull-requests: read
  actions: read
tools:
  github:
    toolsets: [context, repos, pull_requests, actions]
    min-integrity: unapproved
  bash: true
  cache-memory:
  repo-memory:
safe-outputs:
  create-pull-request-review-comment:
    max: 20
    side: "RIGHT"
    target: "${{ github.event.pull_request.number || github.event.issue.number }}"
  submit-pull-request-review:
    max: 1
    footer: "if-body"
    target: "${{ github.event.pull_request.number || github.event.issue.number }}"
  messages:
    footer: "> 👻 *Reviewed by [{workflow_name}]({run_url})*"
    run-started: "👻 [{workflow_name}]({run_url}) is reviewing this PR for API spec design issues…"
    run-success: "👻 [{workflow_name}]({run_url}) completed the spec architecture review. ✅"
    run-failure: "👻 [{workflow_name}]({run_url}) {status}. ❌"
timeout-minutes: 15

---

# Spec Architecture Review

Review pull request #${{ github.event.pull_request.number }} for API
specification design issues.

Follow the guidelines in [spec-architecture-review-guidelines.md](../prompts/spec-architecture-review-guidelines.md).

## Important Constraints

- Only review changes to **API specification files** (`.tsp`, `.json`,
  `tspconfig.yaml`). Ignore example files, documentation, CI config,
  and tooling.
- Only flag issues **introduced or worsened** by this pull request. Do not
  flag pre-existing issues in unchanged files.
- Do **not** re-flag issues already caught by automated CI checks
  (lintdiff, breaking-change detection, ARM auto-signoff). Instead,
  focus on design quality issues that automation misses.
- Do **not** comment on style, formatting, or whitespace.

## Step 0 — Context Gathering

1. **Fetch canonical guidelines** — use the `bash` tool to fetch both
   canonical documents. This is mandatory and must complete before any
   review work begins:
   ```bash
   curl -sL "https://raw.githubusercontent.com/microsoft/api-guidelines/vNext/azure/Guidelines.md"
   ```
   ```bash
   curl -sL "https://raw.githubusercontent.com/microsoft/api-guidelines/vNext/azure/ConsiderationsForServiceDesign.md"
   ```
   Read both documents fully. Internalize the DO / DO NOT rules and their
   rule IDs (e.g. `http-url-casing`, `naming-boolean`). You will cite
   these IDs in your review comments.
2. **Check CI status** — use the Actions toolset to check whether CI
   checks are passing on this PR. Note any failing checks (lintdiff,
   breaking-change, avocado) as context but proceed with the review.
3. **Determine spec type** — identify whether this PR changes ARM
   resource-manager specs, data-plane specs, or TypeSpec definitions.
   This determines which rule categories apply.
4. **Recall past context** — use cache-memory to check if this PR,
   service, or resource provider has been reviewed before.

## Step 1 — Identify Changed Spec Surface

1. List the files changed in the pull request using the GitHub API.
2. Categorize changes:
   - **TypeSpec files** (`*.tsp`) — check model definitions, decorators,
     operations, versioning
   - **Swagger/OpenAPI JSON** (`*.json` under `specification/`) — check
     paths, schemas, parameters, responses, common-types usage
   - **Config files** (`tspconfig.yaml`) — check emitter configuration,
     API version settings
3. Ignore files under `examples/` directories and non-specification files.
4. If no specification surface was changed, post a single comment saying
   the spec looks good and stop.

## Step 2 — Check Against Guidelines

For TypeSpec changes:
- Verify proper use of ARM decorators and templates
- Check model inheritance and property design
- Validate versioning decorator usage
- Look for common TypeSpec anti-patterns

For Swagger/OpenAPI changes:
- **Determine the baseline API version** — identify the previous
  stable/preview version to compare against for breaking changes.
- Check ARM resource model requirements (CRUD completeness, path
  structure, common-types inheritance)
- Validate property design (enums vs booleans, mutability, secrets)
- Check pagination, LRO design, and error handling patterns
- Verify naming conventions and operation ID patterns

For both:
- Apply the full checklist from the spec architecture review guidelines
- Focus on issues that linters and automated checks typically miss:
  design patterns, resource modeling choices, API ergonomics

## Step 3 — Submit Review

Submit your findings as a **pull request review** with inline code
comments.

For each finding, create a **review comment** on the specific file and
line using `create-pull-request-review-comment`:

> 🔴 **Breaking** — `VirtualMachines_Get` response removed the
> `provisioningState` property that exists in `2024-01-01` stable.
> **Fix:** Keep the property and mark as deprecated if no longer used.

After all inline comments, **submit the review** using
`submit-pull-request-review` with:

- **event**: `COMMENT` (advisory review, not a blocking gate)
- **body**: A one-paragraph summary (count of findings by severity, or
  "No spec design issues found") followed by:

<pre>
&lt;details&gt;
&lt;summary&gt;📊 Structured Report&lt;/summary&gt;

```json
{"agent":"spectre","pr":NUMBER,"summary":"clean|issues_found","findings":[{"file":"...","line":0,"severity":"critical|medium|low","category":"...","description":"..."}]}
```

&lt;/details&gt;
</pre>

If no issues were found, submit a `COMMENT` review with a one-sentence
body confirming the specification looks good.

## Step 4 — Suggest a Service README

After posting the review, check whether the spec directory already
contains a `README.md` that documents the service and its hero scenarios.

**If no README exists** (or it only contains AutoRest configuration),
post an **additional review comment** on the PR with a full suggested
`README.md`.

**If a README already exists** with substantive service documentation,
read it and compare its hero scenarios against the API surface changed
in this PR. If the PR introduces new resources, operations, or
cross-service integrations that enable a meaningful new end-to-end
scenario not already covered, suggest **only the new scenario** as an
addition — do not rewrite or duplicate existing content.

The README should include:

1. **Service name and one-paragraph description** — what the service
   does, who it is for, and what problem it solves.

2. **Hero scenarios** — detailed end-to-end scenarios that show a
   developer achieving a real business outcome, not just CRUD
   operations. Each scenario should compose multiple API calls into
   a meaningful workflow — and where the service naturally integrates
   with other Azure services (e.g., a database watcher sending alerts
   via Azure Monitor, or a container app pulling secrets from Key
   Vault), include those cross-service interactions to show how the
   API fits into the broader Azure ecosystem. Look at other service
   specs in the repository to discover integration points.

   Derive scenarios from the operations and resource types in the spec,
   but frame them as customer goals, not API calls. Bad: "Create, get,
   update, and delete a workspace." Good: "Monitor SQL databases and
   route performance alerts to a Teams channel via Azure Monitor."

   For each scenario, include:
   - **Title**: a short outcome-oriented name (e.g., "Monitor SQL
     databases and route performance alerts to a Teams channel")
   - **Scenario**: a one-paragraph description of who is doing what
     and why — frame it as a real-world use case, not an API exercise
     (e.g., "A DBA needs to continuously monitor production SQL
     databases and get alerted in Teams when CPU exceeds 80%.")
   - **Prerequisites**: a one-liner stating what must already exist
     before the scenario begins — previously provisioned resources,
     required permissions, or system state (e.g., "An Azure resource
     group, an ADX cluster, and an Azure Monitor action group
     connected to a Teams channel already exist.")
   - **API call sequence**: the ordered HTTP flow showing method, path,
     and key request/response details. Use `http` fenced code blocks:

     ```http
     ### Step 1 — Create a database watcher with an ADX datastore
     PUT /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}?api-version=2025-01-02
     Content-Type: application/json

     {
       "location": "eastus2",
       "identity": { "type": "SystemAssigned" },
       "properties": {
         "datastore": {
           "adxClusterResourceId": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Kusto/clusters/{cluster}",
           "kustoClusterUri": "https://{cluster}.eastus2.kusto.windows.net",
           "kustoDatabaseName": "watcher-data",
           "kustoOfferingType": "adx"
         }
       }
     }

     HTTP/1.1 201 Created
     Azure-AsyncOperation: https://management.azure.com/subscriptions/{sub}/providers/Microsoft.DatabaseWatcher/locations/eastus2/operationStatuses/{id}
     ```

     ```http
     ### Step 2 — Add a SQL Database target to monitor
     PUT /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}/targets/{targetName}?api-version=2025-01-02
     Content-Type: application/json

     {
       "properties": {
         "targetType": "SqlDb",
         "connectionServerName": "sql-prod.database.windows.net",
         "targetAuthenticationType": "SystemAssigned"
       }
     }

     HTTP/1.1 200 OK
     ```

     ```http
     ### Step 3 — Create an alert rule linked to an Azure Monitor action group
     PUT /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}/alertRuleResources/{ruleName}?api-version=2025-01-02
     Content-Type: application/json

     {
       "properties": {
         "alertRuleResourceId": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Insights/scheduledQueryRules/{rule}",
         "alertRuleTemplateId": "high-cpu-utilization",
         "createdWithProperties": "CreatedWithActionGroup"
       }
     }

     HTTP/1.1 200 OK
     ```

     ```http
     ### Step 4 — Start the watcher
     POST /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}/start?api-version=2025-01-02

     HTTP/1.1 202 Accepted
     Azure-AsyncOperation: https://management.azure.com/subscriptions/{sub}/providers/Microsoft.DatabaseWatcher/locations/eastus2/operationStatuses/{id}
     ```

     Every `http` block MUST show the complete round-trip:
     the request (method, path, headers, body) AND the response
     (status line, key headers like `Operation-Location`, and a
     representative response body showing the fields that matter
     for the next step). Always use full resource paths — never
     abbreviate with `...` or ellipsis. Include cross-service
     resource IDs (e.g., Azure Monitor, Key Vault, Storage) when
     the API references them. For LROs, show the polling header
     in the initial response.

   Cover the full breadth of the API surface through the scenarios —
   not by listing CRUD per resource, but by weaving resources together
   into workflows. Aim for 3–5 scenarios with progressive complexity:
   start with the core "happy path," then show cross-service
   integration, security/private networking, and diagnostics/recovery.

Post the README suggestion as a **separate PR comment** (not an inline
review comment). Format it as:

```
## 📖 Suggested README.md

> **Path:** `specification/{service}/{specDir}/README.md`
>
> This service directory has no README documenting the service and its
> hero scenarios. Consider adding one:

<the README content as raw markdown — do NOT wrap it in a code fence>
```

When **adding a scenario to an existing README**, use this format instead:

```
## 📖 Suggested README addition

> **Path:** `specification/{service}/{specDir}/README.md`
>
> This PR introduces new API surface that enables an additional hero
> scenario not covered in the existing README. Consider appending:

<the new scenario as raw markdown — same format as above>
```

Since the README is markdown and the PR comment renders markdown, the
content will display correctly including the `http` code blocks. The
author can copy it into a new or existing README.md file.

## Step 5 — Update Memory

After posting, store a brief summary in cache-memory (PR number,
service/RP namespace, spec type, outcome) so future runs can detect
repeat patterns across the same service.
