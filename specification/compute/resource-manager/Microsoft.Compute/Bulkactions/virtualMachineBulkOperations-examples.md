# Virtual Machine Bulk Operations example tracker

## Purpose

Use this document to agree on the intended Virtual Machine Bulk Operations
examples before updating the JSON files. The examples must be realistic,
internally consistent, and valid for the API version in which they appear.

Example changes are documentation-only and must not change the API contract.

## Workflow

1. Propose changes in this document.
2. Review the scenario, values, request, and response expectations.
3. Mark the scenario as `Approved`.
4. Update the source example under `examples/<api-version>/`.
5. Run `npx tsp compile .` from the Bulk Actions TypeSpec project directory.
6. Verify that the generated example matches the source.
7. Mark the scenario as `Implemented`.

Do not edit examples under `preview/<api-version>/examples/` directly. They are
generated from the source examples.

## Status values

| Status | Meaning |
| --- | --- |
| Draft | The intended scenario is still being designed. |
| Review | The scenario is ready for review. |
| Approved | The scenario is approved for implementation. |
| Implemented | The source and generated examples match the approved design. |

## Shared conventions

### Identifiers

- Use numeric UUID-style subscription IDs, such as
  `00000000-0000-0000-0000-000000000000`.
- Use letter-only UUID-style Bulk Action Operation Ids, such as
  `aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa`.
- Use a different Bulk Action Operation Id for each virtual machine operation.
- Every operation ID returned by status, cancellation, or error acknowledgment
  must have been included in the corresponding request.
- Use complete Azure resource IDs for virtual machines and related resources.

### Fictional environment

| Value | Convention |
| --- | --- |
| Subscription | `00000000-0000-0000-0000-000000000000` |
| Resource group | `example-rg` |
| Region | `eastus` |
| Virtual machines | `bulk-vm-01`, `bulk-vm-02` |
| Virtual network | `bulk-vnet` |
| Subnet | `compute` |
| Administrator | `azureuser` |
| Time zone | `UTC` |

### Requests and responses

- Give every example a concise name that describes the customer scenario.
- Do not use a set classification such as `MinimumSet` or `MaximumSet` as the
  entire example name.
- Avoid implementation terminology, internal names, and redundant words in
  example names.
- Every endpoint has a simple happy-path example that demonstrates basic usage
  and returns a realistic successful response. It is not intended to be the
  mathematically smallest valid payload.
- Every endpoint has a simple example that demonstrates a realistic common
  error and an actionable response.
- Add more comprehensive examples only when they demonstrate a distinct,
  realistic customer scenario that warrants its own example. Do not add a
  maximum-set example solely to include every optional property.
- A comprehensive example uses only compatible optional properties that
  support one coherent customer scenario.
- Because these are bulk APIs, minimum-set requests should contain two virtual
  machines or two Bulk Action Operation Ids when the operation accepts a
  collection.
- A request containing two virtual machines returns two resource-operation
  results.
- Submit responses return a Bulk Action Operation Id for each virtual machine.
- Submit responses use a nonterminal state such as `PendingScheduling`.
- Status examples may show nonterminal or terminal states when the title clearly
  identifies the scenario.
- A common-error example demonstrates the error customers are most likely to
  encounter and how to correct the request. Prefer a mixed result when the API
  supports independently validating each requested VM or operation.
- Use only externally meaningful error codes and messages. Do not expose
  exception type names, internal components, storage details, or implementation
  behavior.
- Omit optional error properties when no error exists.
- Include error codes and messages only for a failed or canceled operation.
- Use `InitiateAt` for `deadlineType`.
- Use American English in titles, messages, and descriptions.

### Secret placeholders

Maximum-set request examples may include secret-bearing properties when they
help demonstrate the request shape. Use unmistakable nonproduction placeholders
and never include secret-bearing properties in responses.

Examples:

- `<Replace-With-A-Strong-Password1!>`
- `<registration-token>`
- `<sas-token>`

## Proposed examples for review

Use this table to approve, revise, or remove examples before updating the JSON
files. Detailed request and response expectations follow in the scenario
tracker.

| Endpoint | Example name | Kind | Brief description | Status |
| --- | --- | --- | --- | --- |
| Bulk Start | Basic start | Happy path | Start two stopped VMs and return a distinct Bulk Action Operation Id for each VM. | Implemented |
| Bulk Start | Start VMs with retries, health verification, and capacity recommendations | Comprehensive | Start two VMs with tracking context, retries, agent-health verification, and capacity recommendation parameters for later allocation-failure analysis. | Implemented |
| Bulk Start | Start VM in wrong region | Common error | Accept one VM and reject one VM that is not in the endpoint region. | Implemented |
| Bulk Deallocate | Basic deallocation | Happy path | Deallocate two VMs and return a distinct Bulk Action Operation Id for each VM. | Implemented |
| Bulk Deallocate | Deallocation with retries | Comprehensive | Deallocate two batch-processing VMs with retry and execution-optimization settings. | Implemented |
| Bulk Deallocate | Deallocate VM in wrong region | Common error | Accept one VM and reject one VM that is not in the endpoint region. | Implemented |
| Bulk Hibernate | Basic hibernation | Happy path | Hibernate two eligible VMs and return a distinct Bulk Action Operation Id for each VM. | Implemented |
| Bulk Hibernate | Hibernate with deallocation fallback | Comprehensive | Retry failed hibernation and deallocate a VM when its hibernation attempts remain unsuccessful. | Implemented |
| Bulk Hibernate | Hibernate VM in wrong region | Common error | Accept one VM and reject one VM that is not in the endpoint region. | Implemented |
| Bulk Create | Basic VM creation | Happy path | Create two VMs from a basic shared profile. | Implemented |
| Bulk Create | Linux worker creation | Comprehensive | Create two Linux worker VMs with a production-style shared profile and per-VM overrides. | Implemented |
| Bulk Create | Invalid VM size | Common error | Reject a request that specifies a VM size that is not valid for the selected region. | Implemented |
| Bulk VDI Flex Create | Basic VDI creation | Happy path | Create two VDI VMs using simple size and allocation preferences. | Implemented |
| Bulk VDI Flex Create | Ranked VDI allocation | Comprehensive | Create two VDI VMs using ranked sizes, ranked zones, and per-VM overrides. | Implemented |
| Bulk VDI Flex Create | No compatible VM sizes | Common error | Reject a request when no requested size and zone combination can be used. | Implemented |
| Bulk Delete | Basic deletion | Happy path | Delete two VMs and return a distinct Bulk Action Operation Id for each VM. | Implemented |
| Bulk Delete | Forced worker deletion | Comprehensive | Force-delete two disposable worker VMs with retry and optimization settings. | Implemented |
| Bulk Delete | Delete VM in wrong region | Common error | Accept one VM and reject one VM that is not in the endpoint region. | Implemented |
| Bulk Reimage | Basic reimage | Happy path | Reimage two VMs using their current image versions. | Implemented |
| Bulk Reimage | Reimage with override | Comprehensive | Reimage two VMs with shared settings and a specific override for one VM. | Implemented |
| Bulk Reimage | VM in wrong resource group | Common error | Accept one VM and reject one VM that is not in the resource group specified by the route. | Implemented |
| Bulk Get Operations Status | Basic operation status | Happy path | Return the current status for two previously submitted VM operations. | Implemented |
| Bulk Get Operations Status | In-progress start status | Comprehensive | Return detailed status for a start operation that is still in progress. | Implemented |
| Bulk Get Operations Status | Hibernate fallback status | Workflow | Show failed hibernation and the successful Deallocate failure action for the linked Hibernate example. | Implemented |
| Bulk Get Operations Status | Unknown operation status | Common error | Return one known operation and one `OperationNotFound` result. | Implemented |
| Bulk Cancel | Basic cancellation | Happy path | Cancel two eligible VM operations. | Implemented |
| Bulk Cancel | Detailed start cancellation | Comprehensive | Return detailed cancellation results for a previously submitted start operation. | Implemented |
| Bulk Cancel | Unknown operation cancellation | Common error | Cancel one known operation and return `OperationNotFound` for an unknown operation. | Implemented |
| Bulk List Operation Errors | Recent operation errors | Happy path | Return two recent VM operation errors without pagination. | Implemented |
| Bulk List Operation Errors | Paged canceled operation errors | Comprehensive | Return a canceled-operation error and a link to the next page. | Implemented |
| Bulk List Operation Errors | Invalid lookback window | Common error | Reject a request whose error lookback window is outside the supported range. | Implemented |
| Bulk Acknowledge Operation Errors | Basic error acknowledgment | Happy path | Acknowledge errors for two known Bulk Action Operation Ids. | Implemented |
| Bulk Acknowledge Operation Errors | Mixed acknowledgment results | Comprehensive | Show acknowledged, not-found, and skipped outcomes in one response. | Implemented |
| Bulk Acknowledge Operation Errors | Unknown operation acknowledgment | Common error | Acknowledge one known error and report one unknown operation ID in `notFound`. | Implemented |

## Scenario tracker

### Bulk Start

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic start | Minimum | Start two stopped virtual machines using basic settings. | Two virtual machine IDs and empty execution settings. | Two `PendingScheduling` results with distinct operation IDs and matching resource IDs. | Implemented |
| Start VMs with retries, health verification, and capacity recommendations | Maximum | Start two virtual machines with reliability and allocation-failure settings. | Two resources with tracking context, retry settings, agent-health verification, optimization preference, and capacity recommendation parameters. | One `PendingScheduling` result per VM with matching context and retry settings. Omit `capacityRecommendation` because Bulk Actions computes it later only if a VM fails to start because of an allocation failure. | Implemented |
| Start VM in wrong region | Common error | Start two VMs when one VM is in a different region than the Bulk Actions endpoint. | One VM in `eastus` and one VM in another region. | One `PendingScheduling` result and one `ResourceNotInLocation` result that identifies the mismatched VM and explains that it must be in `eastus`. | Implemented |

### Bulk Deallocate

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic deallocation | Minimum | Deallocate two virtual machines using basic settings. | Two virtual machine IDs and empty execution settings. | Two `PendingScheduling` results with distinct operation IDs and matching resource IDs. | Implemented |
| Deallocation with retries | Maximum | Deallocate two batch-processing virtual machines with retries. | Two virtual machine IDs, retry settings, and optimization preference. | Two nonterminal results with distinct operation IDs. | Implemented |
| Deallocate VM in wrong region | Common error | Deallocate two VMs when one VM is in a different region than the Bulk Actions endpoint. | One VM in `eastus` and one VM in another region. | One `PendingScheduling` result and one `ResourceNotInLocation` result that identifies the mismatched VM and explains that it must be in `eastus`. | Implemented |

### Bulk Hibernate

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic hibernation | Minimum | Hibernate two eligible virtual machines using basic settings. | Two virtual machine IDs and empty execution settings. | Two `PendingScheduling` results with distinct operation IDs and matching resource IDs. | Implemented |
| Hibernate with deallocation fallback | Maximum | Hibernate two virtual machines and deallocate either VM if its hibernation attempts fail. | Two resources with context, `retryCount` of 2, `retryWindowInMinutes` of 30, `onFailureAction` set to `Deallocate`, and an optimization preference. | Two `PendingScheduling` results with distinct operation IDs, matching context, and the submitted retry policy. The immediate response must not claim that hibernation or fallback has completed. | Implemented |
| Hibernate VM in wrong region | Common error | Hibernate two VMs when one VM is in a different region than the Bulk Actions endpoint. | One VM in `eastus` and one VM in another region. | One `PendingScheduling` result and one `ResourceNotInLocation` result that identifies the mismatched VM and explains that it must be in `eastus`. | Implemented |

### Bulk Create

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic VM creation | Minimum | Create two virtual machines using basic settings. | `resourceCount` of 2 and empty execution settings. | Two nonterminal create results with distinct operation IDs and generated VM resource IDs. | Implemented |
| Linux worker creation | Maximum | Create two production Linux worker VMs with a shared profile and per-VM overrides. | Identity, placement, tags, image, disks, OS profile, network profile, Trusted Launch, diagnostics, extension settings, safe secret placeholders, Compute API version, and two overrides. | Two nonterminal create results with distinct IDs, matching VM names, selected sizes, and zones. | Implemented |
| Invalid VM size | Common error | Request two VMs with a VM size that is not valid in the selected region. | `resourceCount` of 2 and a nonexistent or unavailable VM size in the shared profile. | A standard ARM `400 Bad Request` error that identifies the VM size and explains that it is not valid for the request. | Implemented |

Do not add a marketplace `plan` unless the selected image requires a matching
plan.

### Bulk VDI Flex Create

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic VDI creation | Minimum | Create two virtual desktop infrastructure VMs with basic allocation preferences. | Resource count of 2, supported VM sizes, OS type, and required priority profile. | Two nonterminal create results with distinct operation IDs. | Implemented |
| Ranked VDI allocation | Maximum | Create two virtual desktop infrastructure VMs with ranked sizes and zones. | Shared profile, two overrides, ranked VM sizes, priority and allocation strategy, ranked zones, minimum capacity, retry settings, and optimization preference. | Two nonterminal results showing the selected size and zone for each VM. | Implemented |
| No compatible VM sizes | Common error | Request two VDI VMs when none of the ranked size and zone combinations can be used. | `resourceCount` of 2 with realistic ranked sizes and zones that produce no compatible allocation choice. | A standard ARM `400 Bad Request` response with `NoAvailableVMSizes` and an actionable message to change the requested sizes, zones, or allocation settings. | Implemented |

### Bulk Delete

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic deletion | Minimum | Delete two virtual machines using basic settings. | Two virtual machine IDs and empty execution settings. | Two `PendingScheduling` delete results with distinct operation IDs. | Implemented |
| Forced worker deletion | Maximum | Force-delete two disposable worker VMs. | Two IDs, forced deletion, retry settings, and optimization preference. | Two nonterminal delete results with distinct operation IDs. | Implemented |
| Delete VM in wrong region | Common error | Delete two VMs when one VM is in a different region than the Bulk Actions endpoint. | One VM in `eastus` and one VM in another region. | One `PendingScheduling` result and one `ResourceNotInLocation` result that identifies the mismatched VM and explains that it must be in `eastus`. | Implemented |

### Bulk Reimage

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic reimage | Minimum | Reimage two virtual machines using their current image versions. | Two VM IDs, empty execution settings, and no optional profile overrides. | Two nonterminal reimage results with distinct operation IDs. | Implemented |
| Reimage with override | Maximum | Reimage two VMs with a shared profile and an override for the second VM. | Two VM IDs, shared reimage settings, one matching resource override, retry settings, and optimization preference. | Two nonterminal results with distinct IDs. | Implemented |
| VM in wrong resource group | Common error | Reimage two VMs when one VM belongs to a different resource group than the route. | One VM in `example-rg` and one VM in another resource group. | One nonterminal result and one `InvalidResourceGroupInResource` result that identifies the mismatched VM and explains that all VMs must belong to `example-rg`. | Implemented |

### Bulk Get Operations Status

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic operation status | Minimum | Get the status of two VM operations. | Two previously returned Bulk Action Operation Ids. | Two results containing the requested operation IDs and their matching VM resource IDs. | Implemented |
| In-progress start status | Maximum | Get detailed status for an in-progress start operation. | One or more previously returned operation IDs. | A matching result for every requested ID, including realistic status details and no completion timestamp while in progress. | Implemented |
| Hibernate fallback status | Workflow | Get the final status of the two operations submitted by **Hibernate with deallocation fallback**. | The two Bulk Action Operation Ids returned by the linked Hibernate example. | The first VM shows successful hibernation. The second shows the Hibernate operation in `Failed`, an actionable `resourceOperationError`, and `fallbackOperationInfo` with `lastOpType` set to `Deallocate` and `status` set to `Succeeded`. | Implemented |
| Unknown operation status | Common error | Get status for one known operation and one unknown operation. | One previously returned operation ID and one well-formed operation ID that does not exist. | One normal status result and one `OperationNotFound` result containing the unknown operation ID; omit VM-specific fields that are not known. | Implemented |

#### Hibernate deallocation fallback workflow

The linked Hibernate and status examples should demonstrate this sequence:

1. Bulk Hibernate accepts two VMs and returns a distinct Bulk Action Operation
   Id for each VM in `PendingScheduling`.
2. The first VM hibernates successfully.
3. Hibernation fails for the second VM and remains unsuccessful after the
   configured retries.
4. Bulk Actions deallocates the second VM as the configured failure action.
5. Bulk Get Operations Status reports the original Hibernate operation as
   `Failed` even though the Deallocate failure action succeeded.

For the second VM, use a customer-actionable Hibernate error such as:

```json
"resourceOperationError": {
  "errorCode": "OperationNotAllowed",
  "errorDetails": "The virtual machine is not configured to support hibernation."
},
"fallbackOperationInfo": {
  "lastOpType": "Deallocate",
  "status": "Succeeded"
}
```

Also include `completedAt` and echo the retry policy with
`onFailureAction: "Deallocate"`. Omit `fallbackOperationInfo.error` because the
Deallocate action succeeded. Do not describe the overall operation as
successful: Kronox preserves the failed Hibernate result and reports the
successful failure action separately.

### Bulk Cancel

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic cancellation | Minimum | Cancel two eligible operations. | Two previously returned Bulk Action Operation Ids. | Two results containing the requested IDs and canceled states. | Implemented |
| Detailed start cancellation | Maximum | Cancel an eligible start operation with detailed status. | One or more previously returned start, deallocate, or hibernate operation IDs. | One result per requested ID with consistent operation type, resource ID, and cancellation details. | Implemented |
| Unknown operation cancellation | Common error | Cancel one eligible operation and one unknown operation. | One previously returned operation ID and one well-formed operation ID that does not exist. | One canceled or canceling result and one `OperationNotFound` result containing the unknown operation ID. | Implemented |

### Bulk List Operation Errors

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Recent operation errors | Minimum | List recent operation errors using basic settings. | Standard scope parameters and no optional paging state. | Two realistic error results without a `nextLink`. | Implemented |
| Paged canceled operation errors | Maximum | List a recent canceled operation and continue to another page. | Standard scope parameters and applicable lookback settings. | A realistic error result and a valid `management.azure.com` `nextLink`. | Implemented |
| Invalid lookback window | Common error | List operation errors with an invalid lookback window. | Set `lookbackInMinutes` to `0`. | A standard ARM `400 Bad Request` error explaining that `lookbackInMinutes` must be within the supported positive range. | Implemented |

### Bulk Acknowledge Operation Errors

| Example name | Set | Intended scenario | Request expectations | Response expectations | Status |
| --- | --- | --- | --- | --- | --- |
| Basic error acknowledgment | Minimum | Acknowledge two operation errors successfully. | Two Bulk Action Operation Ids. | Both IDs in `acknowledged`; empty `notFound` and `skipped` arrays. | Implemented |
| Mixed acknowledgment results | Maximum | Acknowledge three errors with mixed outcomes. | Three distinct Bulk Action Operation Ids. | Every requested ID appears exactly once across `acknowledged`, `notFound`, and `skipped`. | Implemented |
| Unknown operation acknowledgment | Common error | Acknowledge one known operation error and one unknown operation ID. | One operation ID returned by the list-errors endpoint and one well-formed operation ID that does not exist. | The known ID appears in `acknowledged`, the unknown ID appears in `notFound`, and `skipped` is empty. | Implemented |

## Cross-example workflow

Use shared IDs where examples form a connected workflow:

1. Bulk Start returns operation IDs for `bulk-vm-01` and `bulk-vm-02`.
2. Bulk Get Operations Status requests both IDs and shows the operations in
   progress.
3. Bulk Cancel requests both IDs and shows the operations canceled.
4. Bulk List Operation Errors returns both canceled operations.
5. Bulk Acknowledge Operation Errors acknowledges both operation IDs.

Other operation types may use their own letter-only operation IDs. IDs only
need to be shared when the examples intentionally represent the same workflow.

## Version rollout

| API version | Intended action | Status |
| --- | --- | --- |
| `2026-04-06-preview` | Preserve existing examples unless explicitly approved for update. | Not planned |
| `2026-06-06` | Preserve existing examples unless explicitly approved for update. | Not planned |
| `2026-07-06-preview` | Preserve existing examples unless explicitly approved for update. | Not planned |
| `2026-08-06-preview` | Use as the current baseline for reviewing and implementing this tracker. | Implemented |
| Later versions | Carry forward approved scenarios and adapt version-specific fields. | Planned |

## Review checklist

- [ ] Every example has a specific, understandable scenario.
- [ ] Every example has a concise, descriptive name.
- [ ] Every endpoint has a simple happy-path example with a realistic
      successful response.
- [ ] Every endpoint has a simple, realistic common-error example.
- [ ] Common-error examples use externally meaningful codes and actionable
      messages without internal implementation details.
- [ ] Every additional comprehensive example demonstrates a distinct,
      realistic customer scenario that warrants its own example.
- [ ] No example exists solely to show every optional property.
- [ ] Every bulk minimum request contains two VMs or two operation IDs when the
      operation accepts a collection.
- [ ] Every maximum example is comprehensive but internally compatible.
- [ ] Request and response resource counts match.
- [ ] Request and response operation IDs match where required.
- [ ] Each resource operation has a distinct Bulk Action Operation Id.
- [ ] Submit responses use nonterminal states.
- [ ] Error properties appear only when an error exists.
- [ ] Secret values are unmistakable placeholders and never appear in responses.
- [ ] URLs and Azure resource IDs use realistic structures.
- [ ] Version-specific properties are preserved.
- [ ] `deadlineType` uses an implemented value.
- [ ] Source and generated examples match after compilation.
- [ ] Older API-version examples remain unchanged unless explicitly approved.
