## Step 0 — Identify the Spec Surface

1. List the files changed in the pull request using the GitHub API.
2. Filter to **API specification files** only (`.tsp`, `.json` under
   `specification/`, `tspconfig.yaml`). Ignore files under `examples/`
   directories, CI configuration, and documentation files.
3. Determine the **service name** and **spec directory** from the file
   paths (e.g., `specification/DatabaseWatcher/` → DatabaseWatcher).
   If the PR touches multiple spec directories within the same service
   (e.g., both `resource-manager/` and `data-plane/`), treat them as a
   single service and analyze the combined API surface. If the PR
   touches specs for **different services**, generate separate hero
   scenario suggestions for each service.
4. If no specification surface was changed, post a single message saying
   no hero scenarios are applicable and stop.

## Step 1 — Check for Existing README

Check whether the service already has a `README.md` with hero scenarios.
Look in the top-level service directory (e.g.,
`specification/loadtestservice/README.md`) and in each spec subdirectory
(e.g., `resource-manager/Microsoft.LoadTestService/loadtesting/readme.md`,
`data-plane/loadtesting/readme.md`).

- **If no README with hero scenarios exists** (or all READMEs only
  contain AutoRest configuration), you will generate a full suggested
  `README.md` in Step 3.
- **If a README already exists** with substantive service documentation,
  read it and note the existing hero scenarios. In Step 3, you will only
  suggest new scenarios that cover API surface introduced by this PR and
  not already covered.

## Step 2 — Analyze the API Surface

Read the changed specification files to understand:

- **Resource types** — what resources are defined or modified
- **Operations** — what CRUD operations, actions, and LROs exist
- **Cross-service references** — any references to other Azure services
  (e.g., Azure Monitor, Key Vault, Storage resource IDs)
- **Relationships** — how resources relate to each other (parent/child,
  references, dependencies)

## Step 3 — Generate Hero Scenarios

Compose the API operations into **end-to-end hero scenarios** that show
a developer achieving a real business outcome, not just CRUD operations.

### Scenario Design Principles

- Each scenario should compose multiple API calls into a meaningful
  workflow. Real developer workflows often span multiple Azure services
  — a load test resource needs an App Service to test, a Key Vault for
  encryption keys, Azure Monitor for alerting. **Include calls to other
  Azure service APIs when the changed spec already references them**
  (e.g., resource IDs, linked resource properties, or cross-service
  dependencies visible in the spec files). Do NOT browse the wider
  repository to discover integration points — only use cross-service
  references that are explicit in the changed specification.
- Derive scenarios from the operations and resource types in the spec,
  but frame them as customer goals, not API calls. Bad: "Create, get,
  update, and delete a workspace." Good: "Monitor SQL databases and
  route performance alerts to a Teams channel via Azure Monitor."
- Let the API surface determine how many scenarios you generate — don't
  force a fixed count. A rich API with many resource types may warrant
  several scenarios; a thin management-plane API may only need one or
  two honest ones. Never pad with CRUD-organized filler. Every scenario
  must tell a cohesive story where each step depends on the previous
  one and leads to the next.

### Golden Example — What Good Looks Like

Study this example before generating scenarios. It is from the
DatabaseWatcher service and demonstrates all the principles above:
one cohesive workflow weaving four resource types toward a business
outcome, with cross-service integration baked into every step.

---

#### Scenario: Monitor SQL databases and route performance alerts to a Teams channel

A DBA needs to continuously monitor production SQL databases and get
alerted in a Teams channel when CPU exceeds 80%. She provisions a
database watcher backed by an ADX datastore, adds her SQL databases as
monitoring targets, wires an Azure Monitor alert rule to a Teams action
group, and starts the watcher.

**Prerequisites:** An Azure resource group, an ADX cluster, and an
Azure Monitor action group connected to a Teams channel already exist.

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
Retry-After: 10

{
  "id": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}",
  "name": "{name}",
  "type": "Microsoft.DatabaseWatcher/watchers",
  "location": "eastus2",
  "identity": {
    "type": "SystemAssigned",
    "principalId": "{principalId}",
    "tenantId": "{tenantId}"
  },
  "properties": {
    "datastore": {
      "adxClusterResourceId": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Kusto/clusters/{cluster}",
      "kustoClusterUri": "https://{cluster}.eastus2.kusto.windows.net",
      "kustoDatabaseName": "watcher-data",
      "kustoOfferingType": "adx"
    },
    "provisioningState": "Creating"
  }
}
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
Content-Type: application/json

{
  "id": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}/targets/{targetName}",
  "name": "{targetName}",
  "type": "Microsoft.DatabaseWatcher/watchers/targets",
  "properties": {
    "targetType": "SqlDb",
    "connectionServerName": "sql-prod.database.windows.net",
    "targetAuthenticationType": "SystemAssigned",
    "provisioningState": "Succeeded"
  }
}
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
Content-Type: application/json

{
  "id": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}/alertRuleResources/{ruleName}",
  "name": "{ruleName}",
  "type": "Microsoft.DatabaseWatcher/watchers/alertRuleResources",
  "properties": {
    "alertRuleResourceId": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Insights/scheduledQueryRules/{rule}",
    "alertRuleTemplateId": "high-cpu-utilization",
    "createdWithProperties": "CreatedWithActionGroup",
    "provisioningState": "Succeeded"
  }
}
```

```http
### Step 4 — Start the watcher
POST /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.DatabaseWatcher/watchers/{name}/start?api-version=2025-01-02

HTTP/1.1 202 Accepted
Azure-AsyncOperation: https://management.azure.com/subscriptions/{sub}/providers/Microsoft.DatabaseWatcher/locations/eastus2/operationStatuses/{id}
Retry-After: 10

{
  "id": "/subscriptions/{sub}/providers/Microsoft.DatabaseWatcher/locations/eastus2/operationStatuses/{id}",
  "status": "Running"
}
```

---

Notice what makes this good:
- **One business outcome** (monitor DBs, alert in Teams) drives the
  entire scenario — not "create a watcher, then create a target."
- **Four different resource types** (watcher, target, alert rule, action)
  are composed into a single workflow, not separate scenarios.
- **Cross-service references** (ADX cluster, Azure Monitor, SQL Server)
  appear naturally in the request bodies.
- **The scenario ends with value** — the watcher is running and will
  alert the team. Not just "resource created successfully."

Use this as your quality bar. Every scenario you generate should have
this level of cohesion and purpose.

### Scenario Format

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
  and key request/response details. Use `http` fenced code blocks
  (see the golden example above for the exact format).

  Every `http` block MUST show the complete round-trip:
  the request (method, path, headers, body) AND the response
  (status line, key headers like `Operation-Location`, and a
  representative response body showing the fields that matter
  for the next step). Always use full resource paths — never
  abbreviate with `...` or ellipsis. Include cross-service
  resource IDs (e.g., Azure Monitor, Key Vault, Storage) when
  the API references them. For LROs, show the polling header
  in the initial response.

## Step 4 — Post the Suggestion

**If no README exists**, use `add-comment` to post a PR comment with a
full suggested README:

```
## 📖 Suggested README.md

> **Path:** `specification/{service}/{specDir}/README.md`
>
> This service directory has no README documenting the service and its
> hero scenarios. Consider adding one:

<the README content as raw markdown — do NOT wrap it in a code fence>
```

The README should include:
1. **Service name and one-paragraph description** — what the service
   does, who it is for, and what problem it solves.
2. **Hero scenarios** — the scenarios generated in Step 3.

**If a README already exists**, post an inline code suggestion on the
README file using `create-pull-request-review-comment`. Place the
comment at the end of the file and use a GitHub suggestion block so the
author can apply it with one click:

````
```suggestion
<the new scenario section as raw markdown>
```
````

Then submit the review using `submit-pull-request-review` with event
`COMMENT` and a one-sentence body summarizing what was suggested.

If the existing README already covers all the API surface in this PR,
submit a `COMMENT` review with a one-sentence body confirming no new
scenarios are needed.
