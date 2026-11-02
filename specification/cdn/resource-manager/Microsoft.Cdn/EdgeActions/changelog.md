# EdgeActions API changelog

## 2027-01-01-preview

- Add an opt-in preview API based on current main, retaining the merged stable fixes from #46715 and #47326 and leaving all three published API-version projections unchanged.
- Replace writable `isDefaultVersion` with required, read-only `versionExecutionState`: extensible `Default`, `Active`, or `Inactive`; a default version may also execute through a filter, and `swapDefault` selects the default.
- Add required, read-only Version `deploymentStatus`: extensible `NotStarted`, `InProgress`, `Succeeded`, `Failed`, or `Canceled`; accepting a deployment is distinct from completing it.
- Make Edge Action PATCH accept optional tags only, removing the misleading SKU and empty properties inputs while retaining omitted/present/empty/null tag semantics.
- Make Version PATCH accept optional tags only; version properties are not PATCH inputs, and tag persistence still requires resource-provider support.
- Preserve optional execution-filter PATCH inputs for `versionId` and both identifier-header fields, together with tags.
- Correct all three resource `properties` wrappers to use consistent Read/Create/Update visibility in the new preview, retaining SDK flattening without the conflicting handwritten create-only `x-ms-mutability` override.
- Restore execution-filter field reachability in update-oriented PUT generation: azure-cli-extensions' published `edge-action execution-filter update` uses GET then PUT, but its instance-update builder exposes only tags because the parent `properties` allowed read/create while the nested version/header fields allowed read/update/create; finding those fields in GET, PATCH, or shared definitions did not make them writable through that PUT update path.
- Use create-or-replace PUT templates for all three resources while retaining their operation IDs, resource request bodies, 200 replacement/201 creation responses, and merged polling headers.
- Remove required `VersionCode.name`; deployment and retrieval share a content-only payload.
- Make `getVersionCode` synchronous POST with a direct content-only 200 result, removing its LRO metadata and unnecessary Content-Type input without changing the route or HTTP method.
- Retain the merged full `EdgeActionVersion` deploy result and matching LRO logical result instead of restoring the closed PR's properties-only response.
- Remove the unnecessary Content-Type input from bodyless `swapDefault`, retaining asynchronous 202 and no-content 204 behavior.
- Add `Deleting` to provisioning state without removing `Provisioning` or `Upgrading`.
- Add the resource-group-scoped operation-status GET and preview monitor from the closed PR, with `id`/`name` replacing `resourceId`/`operationId`, optional success snapshots, and standard structured errors; a failed operation remains HTTP 200 at this status endpoint.
- Add the separate subscription-scoped operation-result GET from the closed PR, with an unconstrained JSON object 200 result, bodyless terminal 204, and bodyless pending 202 that repeats Location; reference a shared named result payload so generators do not discard it or create anonymous models, and use HTTP error responses rather than status envelopes for failures.
- Align preview status-monitor types, final-result types, canonical polling headers, 10-to-600-second Retry-After bounds, and example polling routes without adding Location to resource PUT.
- Add preview examples for resource creation/replacement, updates, deployment states, execution states, synchronous code retrieval, status polling, and pending/content/no-content result polling.
- Add generic schema-path regression tests for ancestor/child mutability, GET-to-PUT update reachability, optional writable PATCH fields, read-only filtering, references/composition, polling metadata, source/generated examples, and preview configuration selection.
- Scope preview Swagger lint exceptions to the non-resource status monitor, heterogeneous result/snapshot responses, terminal 204 result polling, and deliberately tags-only PATCH; retain API-review approval as a release gate.
- Make resource-provider discovery tests use isolated fixtures and cover partial specification checkouts, avoiding assumptions that the new EdgeActions/common-types sparse checkout contains Storage and Compute.

### SDK evidence and release boundary

The CLI symptom is visible in the published
[update implementation](https://github.com/Azure/azure-cli-extensions/blob/e59a3ad7072600f56739d7bf1a016e22cdf0eb3d/src/edge-action/azext_edge_action/aaz/latest/edge_action/execution_filter/_update.py):
the transport is PUT, but `InstanceUpdateByJson` builds only tags.
The [create implementation](https://github.com/Azure/azure-cli-extensions/blob/e59a3ad7072600f56739d7bf1a016e22cdf0eb3d/src/edge-action/azext_edge_action/aaz/latest/edge_action/execution_filter/_create.py)
does serialize the three filter fields. The new tests reproduce the parent
mutability restriction and check effective writable request paths. No SDK or CLI
package is regenerated or released by this specification change.

The preview date, new status/result routes, state fields, and PATCH behavior need
service implementation and API-review agreement before release. Local schema
and example validation do not establish live service behavior.
