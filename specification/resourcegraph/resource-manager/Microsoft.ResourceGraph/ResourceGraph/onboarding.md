# ResourceGraph onboarding implementation alignment

> see https://aka.ms/autorest

Onboarding is part of the existing `Microsoft.ResourceGraph/ResourceGraph` service.
The [ResourceGraph configuration](readme.md) separates the stable default AutoRest
package from the explicit onboarding preview package:

- Default `package-2024-04-stable` selects only the original published
  `stable/2024-04-01/resourcegraph.json` and `graphquery.json`: query, saved queries
  and their original Operations discovery.
- Explicit `package-preview-2026-05` selects only onboarding at 2026-05-01-preview,
  including its single provider-wide Operations definition. It is not in the default
  AutoRest SDK inventory.
- Changes and History remain available through the unchanged `2024-04` and earlier
  named tags; Copilot remains available through `package-preview-2023-09`. All earlier
  named tags, published API files and examples are unchanged.

`OnboardingApi/main.tsp`, its local `tspconfig.yaml`, `service.yaml` and 27 authored
examples form an independently compiled module, matching the existing nested projects.
Run `tsp compile ./OnboardingApi` from this service root to emit only onboarding into
`preview/2026-05-01-preview/OnboardingApi-aggregate.json` and its published examples.
The four duplicate legacy aggregate Swagger files and their 23 copied source examples
are removed; original module-local examples and standalone TypeSpec entry points remain
intact. The root returns to the original SDK-only layout, without `main.tsp` or a root
manifest. Its `client.tsp` entry point still aggregates the preexisting Changes, Query,
History and saved-query modules plus onboarding at their own API versions. Its
query-only module avoids a
duplicate Operations definition; no legacy HTTP operation gains 2026 support.
Copilot remains available via its existing Swagger tag, not this TypeSpec aggregate.

The aggregate SDK client uses ARM common types v5. The onboarding schemas reachable
through its common-type references are identical in v5 and v6; this common dependency
alignment does not change the onboarding wire contract.

## Implementation alignment

This preview is based on [ResourceCache PR 16179135](https://dev.azure.com/msazure/One/_git/Mgmt-Governance-ResourcesCache/pullrequest/16179135),
at commit `f187f9f34542192a3596726fd95a61dbd80f191c`, with the intentional
proxy-envelope and PUT-response differences described below.

- Node identities use `resourceType`. The service accepts `azureResourceType` only as a
  deserialization compatibility alias; the alias is not part of the published schema.
- Ontology references on query endpoints are full Azure resource identifiers. Global references
  are immutable and scoped to the same subscription and offering; regional references and
  engine preferences are copied from the parent rather than provided by the caller.
- All public onboarding PUTs advertise HTTP 200, HTTP 201 and a default error response.
  This intentionally retains the standard Azure Resource Manager response contract ahead of
  a separate ResourceCache implementation update. At the referenced commit, global offering,
  ontology and query-endpoint PUTs, and regional query-endpoint PUTs, return HTTP 200 only;
  ontology activation supports HTTP 200 for terminal states and HTTP 201 for nonterminal
  states. No asynchronous-operation headers are advertised.
- Offering, Ontology, OntologyActivation, DataOnboardingActivation and QueryEndpointActivation
  use the standard proxy-resource envelope without a root `location` property. Regional
  routing through `/locations/{location}`, location parent resources and read-only
  `properties.region` are unchanged. These are not tracked resources with tags.
- ResourceCache follow-up is required on exactly those five DTO surfaces: the referenced
  backend still serializes root `location` (`global` on Offering/Ontology and route-derived
  on the three activations). Coordinate response serialization and the Offering/Ontology
  request/default handling before exposing this contract; preserve internal global defaults,
  route-derived regional selection and persisted-snapshot readability. This Swagger change
  does not update the backend or claim current wire parity.
- Global and regional data-onboarding resources are public GET/LIST only. New unmet supply is
  grouped by publisher namespace per generation batch, and relationships use their own type's
  namespace. Approval, type availability, regional activation and operator execution close-out
  are distinct; an `Active` aggregate does not establish completed ingestion.
- Regional singleton item URLs end in `/locations/{location}/activation/default`. Collection
  GETs omit `/default`. The service's legacy bare activation PUT alias is not advertised as a
  second Azure Resource Manager resource operation. Location lists report existing activation
  records, not every region available for deployment. Public lists currently return no continuation.

## Review status

Reusing the existing service scope is a packaging choice, not final design approval.
The five invalid-envelope suppressions are removed. Five narrowly justified
`no-resource-delete-operation` suppressions remain because the public PUT resources
have no supported DELETE; no lifecycle operations are invented to silence validation.
The existing `FolderStructure` exception gains only the exact `OnboardingApi` project
path, alongside the four existing nested modules. This structural exception preserves
the independently versioned aggregate layout and requires normal review; it is not
approval of the API design. No new API-rule or SDK-config suppression is added.
The standard proxy envelopes and five standard PUT response contracts intentionally
remain ahead of the coordinated ResourceCache implementation updates described above.

The stable-only default intentionally changes the default SDK/API inventory rather
than mixing preview API versions to represent every published surface. Consumers
needing preview operations must select the appropriate explicit tag or, for the
modules listed above, use the TypeSpec SDK aggregate entry point.
The common-types v5 alignment also produces `LatestVersionOfCommonTypesMustBeUsed`
warnings. Neither limitation is suppressed or treated as design approval.
