## How do I onboard my API to publish docs?

Follow instructions at [Publish REST API reference docs
](https://eng.ms/docs/products/azure-developer-experience/design/api-docs)

## How do I troubleshoot docs build problems?

Follow instructions at [Troubleshooting REST API documentation
](https://eng.ms/docs/products/azure-developer-experience/design/api-docs-troubleshooting)

## How does it work?

When a user opens a PR to a specs repo, the [`spec - api-doc-preview`](https://dev.azure.com/azure-sdk/internal/_build?definitionId=7767&_a=summary) pipeline launches, selects and onboards swaggers into the [preview repo](https://github.com/MicrosoftDocs/AzureRestPreview), then launches a pipeline in the Learn org to generate an API preview. The `spec - api-doc-preview` pipeline waits for the Learn org's pipeline to complete, then reports the status back to the PR in the form of a commit status.

<img width="573" height="38" alt="image" src="https://github.com/user-attachments/assets/3cb006b6-cbb5-44e9-a57b-e2e483f09acb" />


```mermaid

 sequenceDiagram
    participant User
    participant spec_api_doc_preview as spec - api-doc-preview (Azure SDK Org)
    participant REST_Preview as REST-Preview-AzureRestPreview (Learn's DevOps Org)

    User->>spec_api_doc_preview: Opens a Pull Request
    spec_api_doc_preview->>spec_api_doc_preview: Generates onboarding info for changed files
    spec_api_doc_preview->>REST_Preview: Launches REST-Preview-AzureRestPreview pipeline
    spec_api_doc_preview->>REST_Preview: Waits for completion
    REST_Preview-->>spec_api_doc_preview: Pipeline completes
    spec_api_doc_preview->>User: Interprets results and sets PR status
```
