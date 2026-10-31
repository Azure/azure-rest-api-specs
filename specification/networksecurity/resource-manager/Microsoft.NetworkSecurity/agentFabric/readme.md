# Microsoft.NetworkSecurity Agent Fabric

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.NetworkSecurity Agent Fabric management service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## URL filtering rules

Starting with `2026-11-03-preview`, new rules-based `UrlFiltering` configurations name
each host in the rule's `hostname`. The schema keeps `hostname` optional and retains
the deprecated `Fqdns` destination type/model for compatibility.

- The `destination` stays optional. Retaining a destination type in the schema does not
  enable it in the runtime: the current service rejects unsupported destinations with 400
  (`UrlFilteringDestinationNotSupported`, or `PolicyFieldNotSupportedInApiVersion` for an
  `Fqdns` destination). For new configurations, omit it and name each host in a rule.
- Service validation limits new rules-based policies to 1 to 5 rules; the schema does not
  add array bounds to the earlier contract. Rule names and priorities must be unique. Rules are evaluated
  in ascending priority order and the first matching rule decides, so every rule of a policy can take effect.
- Keep all rules for one source and one host in one policy. A policy answers every request from its source to
  the hosts its rules name, so a later policy for the same source never decides those hosts. Within one policy
  group such a split is rejected with 400 (`InvalidUrlFilteringPolicy`).
- A rule's `action` is optional. A rule without `action` uses the policy `defaultAction`.
- `defaultAction` applies when no rule matches a request to a host that one of the policy's rules names.
  Requests to other hosts are not decided by this policy: a later policy decides them, and if none does,
  they are denied. To make `defaultAction` cover every host, add a last rule with `hostname` `*` and no
  `action`.
- Older api-versions keep the `Fqdns` destination and the required rule `action`, with their old meaning and
  without a rule limit.
- A policy group with a `UrlFiltering` policy stays with the api-version family it was written with. A PUT with
  `2026-11-03-preview` over such a group written with an older api-version is rejected with 409, and so is a PUT
  with an older api-version over such a group last written with `2026-11-03-preview` or later. To move a group
  to `2026-11-03-preview`, create a new policy group with that version (put the destination's host in each
  rule's `hostname`), then replace the old group with the new one in the fabric's `defaultPolicyGroups` in one
  AgentFabric PUT. Do not remove the destination with an older api-version first: that makes the policy apply
  to every host its source calls.

## TLS inspection by destination

Starting with `2026-11-03-preview`, a `TlsInspection` policy can choose which destinations to
inspect:

- `defaultAction` (`Inspect` or `Bypass`) applies when no rule matches. If omitted, `Inspect`.
  A policy with neither `defaultAction` nor `rules` inspects every TLS connection of its
  sources, as in earlier api-versions.
- `rules` holds at most one rule. A rule has a `name`, a `priority` (ascending, first match
  wins), an optional `action` and `destinations` (at most one, of type `Fqdns`). The FQDNs are
  matched against the TLS server name (SNI): an exact name, or one leading `*.` that matches the
  name and its subdomains.
- A rule without an `action` takes the policy's `defaultAction`, so it only matters for rule
  ordering. With one rule, it gives the same result as no rule: `defaultAction: Bypass` with a
  rule for `google.com` and no `action` inspects nothing.
- `Bypass` skips TLS interception only, for TLS on port 443. FQDN filtering still applies by
  SNI, and policies that need the HTTP request (URL filtering, MCP, content inspection) cannot
  apply to bypassed connections. TLS on other ports is always inspected.
- A source that an MCP policy targets is always inspected, for every connection: a bypassed
  connection can carry any HTTP host behind its SNI, so inspecting only the MCP host would not
  keep the MCP tool rules. For the sources of a URL filtering policy, the hosts it names are
  always inspected: each rule `hostname`, and an `Fqdns` destination written with an earlier
  api-version. A rule with `hostname` `*` names every host, so its sources are inspected for
  every connection.
- The inspect or bypass decision uses the SNI the client sends. A client that sends a bypassed
  SNI to a front end that also serves another host (domain fronting) reaches that host without
  inspection. Use `defaultAction: Inspect` without `Bypass` rules where that matters.
- When several TLS inspection policies select a source, the connection is inspected if any of
  them inspects it.
- A request at an earlier api-version that sets `defaultAction` or `rules` is rejected, and so
  is a request at an earlier api-version that would replace a policy group that uses them.
  Earlier api-versions cannot represent these fields: read and update such a group with
  `2026-11-03-preview` or later.
- Until TLS inspection by destination is enabled in a region, a request there that sets
  `defaultAction` or `rules` is rejected; the same policy without them is accepted.

## MCP policy rules

Starting with `2026-11-03-preview`, an `Mcp` policy can use named rules with a unique
`priority`, an optional `action` (omitted means `defaultAction`) and `matchingConditions`
containing `destinations` (`serverFqdns`, `protocolVersions`, `toolMatching`,
`promptMatching`). These new fields remain optional in the schema to preserve legacy
request shapes. The legacy `tools` property is retained as optional and deprecated;
use `matchingConditions.destinations.toolMatching.names` for new rules.
Sources are selected by the policy-level `source` (`WorkloadIdPatterns` or
`AddressPrefixes`), and every rule applies to those sources. Rules are tried in ascending
priority order and the first match decides. Service validation limits new rules-based
policies to 1 to 5 rules. See `PolicyGroups_CreateOrUpdate_McpRules.json`.

The contract includes tool and prompt `titles` and `descriptions` matching in list responses,
and `responseContents` matching on tool-call result text (`result.content[].text`) and
prompt-get response text (`result.messages[].content.text`). These optional fields remain in
the API specification even where runtime support is not yet available. The resource provider
must reject unsupported response-matching conditions until enforcement is implemented.
The examples illustrate the API contract, not the availability of response inspection in a deployment.

A request at an earlier api-version that sets `name`, `priority` or `matchingConditions` on a rule is rejected,
and so is a request at an earlier api-version that would replace a policy group with such rules. Earlier
api-versions cannot represent these rules: read and update such a group with `2026-11-03-preview` or later.

## 2026-11-03-preview compatibility declarations

`AciWorkload.agentIdentity` and `AgentIdentity.blueprintId` remain normal optional
identity fields, not deprecated fields. The fabric and member GUID fields retain
the UUID type from earlier public API definitions.

The optional legacy MCP `tools` property and URL FQDN destination are retained as
deprecated declarations. Keeping an API shape declared does not enable its use
in the service or make rejection of previously accepted input automatically
compatible. Unsupported input must be handled explicitly by RP validation.

## Customer-owned Content Safety connection

In the `2026-10-07-preview` contract, supply the customer's Azure Content Safety
account endpoint and API key together when configuring, replacing, or rotating a connection:

```json
{
  "properties": {
    "contentInspectionProfile": {
      "endpoint": "https://contoso.cognitiveservices.azure.com/",
      "apiKey": "<content-safety-api-key>"
    }
  }
}
```

The endpoint routes the Content Safety request; the key alone does not identify the account
endpoint. Supplying the key directly avoids granting the service Azure Resource Manager
`listKeys/action` permission. The customer owns, pays for, and operates the account; the
service does not create, reserve, manage, or delete it. The profile exclusively describes
customer-supplied connections, without platform-owned accounts or shared-key fallback.

The API key is write-only and never appears in GET, list, PUT, or long-running operation
responses. A nonempty request profile requires both endpoint and nonempty key, even when the
endpoint is unchanged. PUT can rotate the key or replace the endpoint using that complete pair.
An omitted profile or `{}` is a connection no-op: preserve an existing customer-owned connection,
legacy regional connection, or absence of connection. Do not persist `{}` over stored credentials,
create or remove a connection, probe it, or cancel a pending connection update.
Other Fabric fields, authorization, policy compatibility, and ordinary pending-operation rules
still apply. Tags- or identity-only PATCH does not change the connection.
Null profiles and supplied empty, null, or wrong-type fields are rejected, not treated as removal.
Both model fields are schema-optional so `{}` is representable; the resource provider must enforce
the paired-input requirement. Swagger field optionality alone does not reject partial profiles.
Unchanged saved connections do not trigger a new Content Safety validation request.
The service validates a proposed replacement before activating it; a failed replacement
preserves the existing connection and credential.
While a connection update is in progress for a fabric, a PUT requesting a different connection
is rejected with HTTP 409 Conflict without changing the update already in progress. A retry of
the same requested connection is not a conflicting change. Later key rotations and endpoint
replacements remain allowed.

Fabric PUT rejects definite invalid connection input before acceptance with HTTP 400: a nonempty
profile missing endpoint or key; malformed, untrusted, or unsupported endpoint/cloud; a null or
nonobject profile; or supplied empty, null, or wrong-type fields. Reject partial input before
connection validation, without retrieving a saved key or comparing with the saved endpoint to
permit omission. Only a truly empty object qualifies for the no-op; partial objects or objects
containing only unrecognized fields must not be treated as `{}`.
An omitted profile or `{}` is not bad connection input.
Service-level semantic rejection uses `ContentInspectionConnectionValidationFailed`
in the standard error response, with target `properties.contentInspectionProfile` or the specific
`endpoint`/`apiKey` field. Ordinary schema/model validation retains its standard HTTP 400 mappings.
The connection code also covers definitively rejected credentials or confirmed account/access
settings or required API capability that prevent use of the connection. Interpret ACS 401/403
before classifying the cause; they are not authentication/authorization failures of the Fabric caller.
ACS 429/5xx, DNS/TLS failures, timeouts, and inconclusive availability are not definitive bad input.
A DNS timeout or arbitrary upstream 404 does not prove the account is absent. After PUT acceptance,
a definite rejection appears as terminal `Failed` with the corresponding error in the existing
long-running operation status response, not a retroactive PUT 400. Errors never echo key values or
raw upstream bodies. These are specification requirements for runtime implementation, not a claim
that the resource provider already emits this code.

The only deployed legacy inspection configuration is the regional Content Safety endpoint
and its existing authentication path, without a `contentInspectionProfile`. Existing fabrics
that omit the profile or supply `{}` preserve that regional configuration without a new connection probe,
account-management call, key retrieval, or requirement to supply credentials. Supplying the
complete profile explicitly configures a customer-owned account; validate that proposed connection
before switching, and preserve the regional connection if validation fails. Do not fall back
to regional credentials to validate or use a failed customer-owned connection.

New fabrics created without the profile or with `{}` have no inspection capability or regional fallback.
An existing fabric with no connection remains without a configured connection on the same input. Keep
`defaultPolicyGroups`, ContentInspection policies, and the Fabric and PolicyGroup PUT
compatibility guards: a new fabric without an inspection connection cannot be associated with
a group containing ContentInspection policies. A PolicyGroup PUT introducing ContentInspection
checks all associated fabrics, because groups can be shared. Unattached groups and changes that do not introduce
ContentInspection do not need this connection check. Validation uses the stored or proposed
configuration, not a fresh connectivity probe for every PolicyGroup PUT; a transient outage
does not make a configured connection absent. An existing legacy fabric's regional connection
satisfies the inspection prerequisite; absence of the new profile does not disable it.
No automatic regional-to-customer-owned conversion occurs. Configuration does not imply
readiness: the service must validate the required Content Safety API from its runtime before
reporting a new or changed connection usable. GET, list, and PolicyGroup PUT do not run live
Content Safety probes. This specification does not implement those runtime behaviors.

Preserving an omitted or empty mutable profile on PUT differs from the standard Azure Resource Manager
full-replacement rule. This intentional compatibility requirement still needs explicit
API-owner review; this specification does not claim an approved exception.

### Preservation examples: existing-fabric updates only

Both examples below require an existing fabric with the stored customer-owned endpoint
`https://contoso.cognitiveservices.azure.com/` and a stored key. They illustrate completed
updates returning HTTP 200, not new-fabric creation returning HTTP 201.

To preserve the entire connection, supply an empty profile:

```json
{
  "location": "westus3",
  "properties": {
    "trustDomain": "contoso.agentfabric",
    "contentInspectionProfile": {}
  }
}
```

Alternatively, omit `contentInspectionProfile`:

```json
{
  "location": "westus3",
  "properties": {
    "trustDomain": "contoso.agentfabric"
  }
}
```

The completed HTTP 200 response for either update contains the stored endpoint but no key:

```json
{
  "id": "/subscriptions/11809CA1-E126-4017-945E-AA795CD5C5A9/resourceGroups/rgnetworksecurity/providers/Microsoft.NetworkSecurity/agentFabrics/testAIFabric",
  "name": "testAIFabric",
  "type": "Microsoft.NetworkSecurity/agentFabrics",
  "location": "westus3",
  "properties": {
    "trustDomain": "contoso.agentfabric",
    "contentInspectionProfile": {
      "endpoint": "https://contoso.cognitiveservices.azure.com/"
    },
    "provisioningState": "Succeeded"
  }
}
```

These update-only scenarios are inline documentation, not
external PUT `x-ms-examples`: the example validator requires both declared success
statuses in each external PUT example, but HTTP 201 would contradict preservation.
The external `AgentFabrics_CreateOrUpdate_EmptyContentInspectionProfile` example instead
illustrates two legitimate outcomes: HTTP 200 preserves an existing customer connection;
HTTP 201 creates a new fabric with no connection. Neither response returns a key.

### Client updates

Readable responses contain the endpoint but no key. Do not blindly copy that endpoint-only
profile from GET into PUT: it is incomplete connection input and must be rejected with HTTP 400.
When no connection change is requested, omit the readback profile or send `{}`.
When any connection field is explicitly supplied, require the complete endpoint/key pair;
do not recover a key from GET or storage, or silently drop an incomplete user request.
Use the existing PATCH shape for supported tags/identity-only updates.
Future CLI integration must implement paired-input validation and secret/log handling explicitly;
this specification does not implement CLI commands or runtime credential storage.

## Configuration

### Basic Information

These are the global settings for the networksecurity.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2026-11-03
```

### Tag: package-preview-2026-11-03

These settings apply only when `--tag=package-preview-2026-11-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-11-03'
input-file:
  - preview/2026-11-03-preview/agentFabric.json
```

```yaml $(tag) == 'package-preview-2026-11-03'
directive:
  - suppress: PatchBodyParametersSchema
    from: agentFabric.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/agentFabrics/{agentFabricName}/clusterAssociations/{clusterAssociationName}"].patch.parameters[5].schema
    reason: The ClusterAssociation PATCH body keeps its required properties envelope, unchanged from earlier previews. Its clusterResourceId is optional in this version so internal gateway-IP updates can omit it; the resource provider still requires it for sku and tags updates.
  - suppress: ArmResourcePropertiesBag
    from: agentFabric.json
    where:
      - $.definitions.ClusterAssociation
      - $.definitions.ClusterAssociationUpdate
    reason: ClusterAssociation's sku property has shipped unchanged under properties since preview/2026-09-10-preview. Renaming or relocating it to the top-level ARM envelope sku would be a breaking change to the existing contract already adopted by callers of earlier previews of this resource.
```

### Tag: package-preview-2026-11-02

These settings apply only when `--tag=package-preview-2026-11-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-11-02'
input-file:
  - preview/2026-11-02-preview/agentFabric.json
```

```yaml $(tag) == 'package-preview-2026-11-02'
directive:
  - suppress: PatchBodyParametersSchema
    from: agentFabric.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/agentFabrics/{agentFabricName}/clusterAssociations/{clusterAssociationName}"].patch.parameters[5].schema
    reason: The ClusterAssociation PATCH body keeps its required properties envelope, unchanged from earlier previews. Its clusterResourceId is optional in this version so internal gateway-IP updates can omit it; the resource provider still requires it for sku and tags updates.
  - suppress: ArmResourcePropertiesBag
    from: agentFabric.json
    where:
      - $.definitions.ClusterAssociation
      - $.definitions.ClusterAssociationUpdate
    reason: ClusterAssociation's sku property has shipped unchanged under properties since preview/2026-09-10-preview. Renaming or relocating it to the top-level ARM envelope sku would be a breaking change to the existing contract already adopted by callers of earlier previews of this resource.
```

### Tag: package-preview-2026-11-01

These settings apply only when `--tag=package-preview-2026-11-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-11-01'
input-file:
  - preview/2026-11-01-preview/agentFabric.json
```

```yaml $(tag) == 'package-preview-2026-11-01'
directive:
  - suppress: PatchBodyParametersSchema
    from: agentFabric.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/agentFabrics/{agentFabricName}/clusterAssociations/{clusterAssociationName}"].patch.parameters[5].schema
    reason: The ClusterAssociation PATCH body keeps its required properties envelope, unchanged from earlier previews. Its clusterResourceId is optional in this version so internal gateway-IP updates can omit it; the resource provider still requires it for sku and tags updates.
  - suppress: ArmResourcePropertiesBag
    from: agentFabric.json
    where:
      - $.definitions.ClusterAssociation
      - $.definitions.ClusterAssociationUpdate
    reason: ClusterAssociation's sku property has shipped unchanged under properties since preview/2026-09-10-preview. Renaming or relocating it to the top-level ARM envelope sku would be a breaking change to the existing contract already adopted by callers of earlier previews of this resource.
```

### Tag: package-preview-2026-10-07

These settings apply only when `--tag=package-preview-2026-10-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-10-07'
input-file:
  - preview/2026-10-07-preview/agentFabric.json
```

```yaml $(tag) == 'package-preview-2026-10-07'
directive:
  - suppress: PatchBodyParametersSchema
    from: agentFabric.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/agentFabrics/{agentFabricName}/clusterAssociations/{clusterAssociationName}"].patch.parameters[5].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/agentFabrics/{agentFabricName}/clusterAssociations/{clusterAssociationName}"].patch.parameters[5].schema.properties.properties
    reason: The immutable clusterResourceId and its properties envelope are required authorization metadata so ARM executes the configured linked-access check. The runtime verifies the value matches the persisted association and does not modify it; the patchable sku remains optional.
  - suppress: ArmResourcePropertiesBag
    from: agentFabric.json
    where:
      - $.definitions.ClusterAssociation
      - $.definitions.ClusterAssociationUpdate
    reason: ClusterAssociation's sku property has shipped unchanged under properties since preview/2026-09-10-preview. Renaming or relocating it to the top-level ARM envelope sku would be a breaking change to the existing contract already adopted by callers of earlier previews of this resource.
```

### Tag: package-preview-2026-07-21

These settings apply only when `--tag=package-preview-2026-07-21` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-07-21'
input-file:
  - preview/2026-07-21-preview/agentFabric.json
```

### Tag: package-preview-2026-04-16

These settings apply only when `--tag=package-preview-2026-04-16` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-04-16'
input-file:
  - preview/2026-04-16-preview/agentFabric.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-net
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
