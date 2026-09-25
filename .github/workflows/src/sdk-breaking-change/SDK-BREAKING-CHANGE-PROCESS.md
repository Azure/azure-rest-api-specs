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

4. When the analysis workflow completes successfully, the
   `SDK Breaking Change - Publish Results` workflow posts the analysis to the pull request, as
   shown in the following example:

```markdown
## SDK Breaking changes for Go

**Analyzed commit:** `6e9fca19c6df9cf66be7e753255d79251f1d4a91`

**Typespec Project:** specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService

**SDK Package:** armwebpubsub

|     | Breaking change                                                                                                                  | Category                | Suggested fix                                                                                                     |
| --- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | ----------------------------------------------------------------------------------------------------------------- |
| ☐   | Model WebPubSubResource: SDK struct ResourceInfo was renamed to Resource, changing operation parameter and response field types. | conversion-need resolve | Add @@clientName(WebPubSubResource, "ResourceInfo", "go") to replay the legacy Go rename-model directive.         |
| ☐   | Model WebPubSubResourceList: SDK struct ResourceInfoList was renamed to ResourceList, changing list response fields.             | conversion-need resolve | Add @@clientName(WebPubSubResourceList, "ResourceInfoList", "go") to replay the legacy Go rename-model directive. |
| ☐   | Model ResourceSku versioned property set changed the SDK fields Family and Tier to FamiliyNew and TierNew.                       | spec change             | -                                                                                                                 |

[SDK breaking change analysis details](https://github.com/chunyu3/azure-rest-api-specs/actions/runs/35322886769)
```

### Mitigation

1. Completion of the `SDK Breaking Change Analysis - Publish Results` workflow automatically
   triggers the `SDK Breaking Change Mitigation` workflow. The mitigation workflow can also be
   manually dispatched with the completed publisher workflow run ID.

The `SDK breaking change mitigation` workflow then:

- Applies TypeSpec client customizations for breaking changes that can be mitigated.
- Publishes the mitigation result artifact.

2. When mitigation completes successfully, the
   `SDK Breaking Change Mitigation - Publish Results` workflow posts the mitigation results to the
   pull request, as shown in the following example:

```markdown
## SDK breaking-change mitigation result

**Resolved Breaking Changes:**

- **Typespec Project:** specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService

| Breaking change                                                                                                                                             | Resolution                                                                                                          |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Struct ResourceInfo for TypeSpec model WebPubSubResource was renamed to Resource, changing the model used by create, update, get, and their response types. | Add @@clientName(WebPubSubResource, "ResourceInfo", "go") to client.tsp to preserve the legacy Go SDK name.         |
| Struct ResourceInfoList for TypeSpec model WebPubSubResourceList was renamed to ResourceList, changing the embedded list result in list responses.          | Add @@clientName(WebPubSubResourceList, "ResourceInfoList", "go") to client.tsp to preserve the legacy Go SDK name. |

**Mitigation pull request:** https://github.com/chunyu3/azure-rest-api-specs/pull/59
```

3. The specification owner reviews the proposed customization for each breaking change they want
   to resolve. Breaking changes that are intentional and accepted must be suppressed.

### Approval

SDK owner label `Approved-SdkBreakingChange-<language>` to approve the SDK breaking changes.
