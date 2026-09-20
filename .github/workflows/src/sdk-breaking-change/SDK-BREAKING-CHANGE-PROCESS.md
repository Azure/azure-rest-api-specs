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
- Posts the `/azsdk sdk-breaking-analysis <language>` command as a comment.
if any SDK breaking changes are detected.

3. When that command comment is created or edited, the `SDK breaking change analysis` workflow:

- Analyzes the detected SDK breaking changes.
- Updates the command comment with the analysis, as shown in the following example:

```markdown
## SDK Breaking changes for Go

**Analyzed commit:** `6e9fca19c6df9cf66be7e753255d79251f1d4a91`

**Typespec Project:** specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService

**SDK Package:** armwebpubsub

|  | Breaking change | Category | Suggested fix |
| --- | --- | --- | --- |
| ☐ | Model WebPubSubResource: SDK struct ResourceInfo was renamed to Resource, changing operation parameter and response field types. | conversion-need resolve | Add @@clientName(WebPubSubResource, "ResourceInfo", "go") to replay the legacy Go rename-model directive. |
| ☐ | Model WebPubSubResourceList: SDK struct ResourceInfoList was renamed to ResourceList, changing list response fields. | conversion-need resolve | Add @@clientName(WebPubSubResourceList, "ResourceInfoList", "go") to replay the legacy Go rename-model directive. |
| ☐ | Model ResourceSku versioned property set changed the SDK fields Family and Tier to FamiliyNew and TierNew. | spec change | - |

[SDK breaking change details (armwebpubsub/breaking-changes.json)](https://github.com/chunyu3/azure-rest-api-specs/actions/runs/35322886769#summary-105529151679)

```

### Mitigation

1. The specification pull request owner starts mitigation by posting the following command:

`/azsdk sdk-breaking-mitigate <language>`

The `SDK breaking change mitigation` workflow then:

- Applies TypeSpec client customizations for breaking changes that can be mitigated.
- Creates a pull request containing the proposed customizations.
- Updates the command comment with the mitigation results, as shown in the following example:

```markdown
/azsdk sdk-breaking-mitigate Go

## SDK breaking-change mitigation result

**Resolved Breaking Changes:**
* **Typespec Project:** specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService

| Breaking change | Resolution |
| --- | --- |
| Struct ResourceInfo for TypeSpec model WebPubSubResource was renamed to Resource, changing the model used by create, update, get, and their response types. | Add @@clientName(WebPubSubResource, "ResourceInfo", "go") to client.tsp to preserve the legacy Go SDK name. |
| Struct ResourceInfoList for TypeSpec model WebPubSubResourceList was renamed to ResourceList, changing the embedded list result in list responses. | Add @@clientName(WebPubSubResourceList, "ResourceInfoList", "go") to client.tsp to preserve the legacy Go SDK name. |

**Mitigation pull request:** https://github.com/chunyu3/azure-rest-api-specs/pull/59

```

2. The specification owner reviews the mitigation pull request and applies the proposed customization for each breaking change they want to resolve. Breaking changes that are intentional and accepted must be suppressed.

### Approval

SDK owner label `Approved-SdkBreakingChange-<language>` to approve the SDK breaking changes.