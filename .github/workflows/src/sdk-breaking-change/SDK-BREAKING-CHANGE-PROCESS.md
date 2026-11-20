# SDK Breaking Change Detection, Analysis, and Mitigation

## Overview

SDK breaking changes must be detected and addressed before a specification pull request can
merge. This process identifies breaking changes early and prevents them from propagating to
downstream SDK repositories, avoid back-and-forth across repos and stages

## How It Works

### Detection

1. When a specification pull request is opened or updated, the `SDK Validation pipeline - <language>` pipeline:

- Generates and builds the SDK.
- Compares the generated SDK with the previous version to detect breaking changes.
- Publishes the package artifacts.

2. After the validation pipeline completes, the `SDK breaking changes labels` workflow:

- Adds the `BreakingChange-<language>-Sdk` label.
- Publishes artifacts identifying the pull request, commit, and SDK breaking-change label action.

3. When the `SDK Breaking Change Labels` workflow completes successfully, the
   `SDK breaking change analysis` workflow:

- Analyzes the detected SDK breaking changes.
- Publishes the analysis result artifact.
- posts the analysis to the pull request, as
  shown in the following example:

```markdown
## SDK Breaking changes for Go

**Analyzed commit:** `00850ca596599f280dc140fa4cc14dc613e9192b`

**Typespec Project:** specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService

**SDK Package:** armwebpubsub

| ID       | Breaking change                                                                                                                                                                                                                                                     | Category                | Suggested fix                                                                                                                                                                |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 82589366 | \[Model WebPubSubResource renamed\] SDK struct ResourceInfo renamed to Resource, changing the parameters of Client.BeginCreateOrUpdate and Client.BeginUpdate and the embedded fields of ClientCreateOrUpdateResponse, ClientGetResponse, and ClientUpdateResponse. | conversion-need resolve | Restore the legacy readme.go.md rename-model directive in client.tsp with &#64;&#64;clientName\(Microsoft.SignalRService.WebPubSubResource, "ResourceInfo", "go"\);.         |
| 00974410 | \[Model WebPubSubResourceList renamed\] SDK struct ResourceInfoList renamed to ResourceList, changing the embedded fields of ClientListByResourceGroupResponse and ClientListBySubscriptionResponse.                                                                | conversion-need resolve | Restore the legacy readme.go.md rename-model directive in client.tsp with &#64;&#64;clientName\(Microsoft.SignalRService.WebPubSubResourceList, "ResourceInfoList", "go"\);. |
| 57811240 | Field &#96;Family&#96;, &#96;Tier&#96; of struct &#96;ResourceSKU&#96; has been removed                                                                                                                                                                             | spec change             |                                                                                                                                                                              |

[View SDK Breaking Change Analysis Details](https://github.com/azure/azure-rest-api-specs/actions/runs/39435734973#armwebpubsub-breaking-change)
```

### Mitigation

1. Completion of the `SDK Breaking Change Analysis` workflow automatically
   triggers the `SDK Breaking Change Mitigation` workflow.

The `SDK breaking change mitigation` workflow then:

- Applies TypeSpec client customizations for breaking changes that can be mitigated.
- Publishes the mitigation result artifact.
- posts the mitigation results to the
  pull request, as shown in the following example:

````markdown
## SDK Breaking Change Mitigation for Go

**Mitigation upon commit:** `00850ca596599f280dc140fa4cc14dc613e9192b`

**TypeSpec project:** specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService

**SDK package:** armwebpubsub

**Breaking Changes:**

<details open><summary>View breaking changes</summary>

| Resolvable | ID                                                                                                                                            | Breaking change                                                                                                                                                                                                                                                     | Resolution                                                                                                                                                                   | TypeSpec changes                                                                                                                                                                                      |
| ---------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔️         | [82589366](https://github.com/azure/azure-rest-api-specs/actions/runs/39435734973#breaking-change-82589366-breaking-change "How to Suppress") | \[Model WebPubSubResource renamed\] SDK struct ResourceInfo renamed to Resource, changing the parameters of Client.BeginCreateOrUpdate and Client.BeginUpdate and the embedded fields of ClientCreateOrUpdateResponse, ClientGetResponse, and ClientUpdateResponse. | Restore the legacy readme.go.md rename-model directive in client.tsp with &#64;&#64;clientName\(Microsoft.SignalRService.WebPubSubResource, "ResourceInfo", "go"\);.         | Added &#64;&#64;clientName\(Microsoft.SignalRService.WebPubSubResource, "ResourceInfo", "go"\); to client.tsp, restoring the legacy Go model name without affecting other languages.                  |
| ✔️         | [00974410](https://github.com/azure/azure-rest-api-specs/actions/runs/39435734973#breaking-change-00974410-breaking-change "How to Suppress") | \[Model WebPubSubResourceList renamed\] SDK struct ResourceInfoList renamed to ResourceList, changing the embedded fields of ClientListByResourceGroupResponse and ClientListBySubscriptionResponse.                                                                | Restore the legacy readme.go.md rename-model directive in client.tsp with &#64;&#64;clientName\(Microsoft.SignalRService.WebPubSubResourceList, "ResourceInfoList", "go"\);. | Added Go-only &#64;&#64;clientName\(Microsoft.SignalRService.WebPubSubResourceList, "ResourceInfoList", "go"\) in client.tsp to restore the legacy list-model name without affecting other languages. |
| ❌         | [57811240](https://github.com/azure/azure-rest-api-specs/actions/runs/39435734973#breaking-change-57811240-breaking-change "How to Suppress") | Field &#96;Family&#96;, &#96;Tier&#96; of struct &#96;ResourceSKU&#96; has been removed                                                                                                                                                                             |                                                                                                                                                                              |                                                                                                                                                                                                       |

</details>

**Customization Code:**

<details><summary>View customization Code</summary>

```diff
diff --git a/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/client.tsp b/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/client.tsp
index 7048e05f8c..d414f06b52 100644
--- a/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/client.tsp
+++ b/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/client.tsp
@@ -7,6 +7,9 @@ using Azure.Core;
 using Microsoft.SignalRService;
 using Http;

+@@clientName(Microsoft.SignalRService.WebPubSubResource, "ResourceInfo", "go");
+@@clientName(Microsoft.SignalRService.WebPubSubResourceList, "ResourceInfoList", "go");
+
 @@clientName(
   Microsoft.SignalRService,
   "WebPubSubManagementClient",
```
````

</details>

[View customization code in the workflow summary](https://github.com/azure/azure-rest-api-specs/actions/runs/39435734973)

## Next Steps

<p>💡 Apply Mitigation: Apply the customization code to mitigate the breaking changes.</p>

<p>💡 Suppress Breaking Changes: For accepted breaking changes, click the breaking change ID link to view suppression instructions and follow the suppression process.</p>
````

[View customization code in the workflow summary](https://github.com/azure/azure-rest-api-specs/actions/runs/35964045609)

```

3. The PR owner reviews the mitigation results and applies the proposed customization for each
   breaking change they want to resolve. Intentional, accepted breaking changes must be suppressed.

### Next Steps to Merge

When SDK breaking-change labels are present, the **Next Steps to Merge** comment includes
one summary row per affected language: detection status, links to analysis and
mitigation reports for the PR's current commit, and the next action.

The summary refreshes after `SDK breaking changes labels` workflow, `SDK Breaking Change Analysis` workflow and `SDK Breaking Change Mitigation` workflow complete.
Reports from older commits are not linked as current results. If a current report is not
available, the table says so; inspect the corresponding workflow for pending or failed runs.
Mitigation reports propose customizations for the PR owner to review and apply. They do not
indicate that the PR has been fixed or revalidated, and do not replace required approvals.

#### Mitigation and Suppression

The SDK owner reviews and applies the proposed customization code to mitigate breaking changes,
or suppresses accepted breaking changes for the affected language. Once all breaking changes for
that language have been mitigated or suppressed and the checks confirm that none remain, the
language's row is removed from the **Next Steps to Merge** summary on its next refresh.
```
