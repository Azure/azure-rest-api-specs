# Downstream Candidate Rules

Apply these rules to supplied candidates only. Rule IDs describe deterministic
comparisons; broad comparisons still require a caller-visible incompatibility.

## Direct method candidates

| Rule | Evidence to compare and decision |
| --- | --- |
| `method-removed` | Confirm the existing public method is absent, not merely paired under another identity. |
| `method-location-changed` | Compare client ownership and the existing invocation path. Approve an incompatible move. |
| `method-access-changed` | Approve loss of public method access. |
| `method-parameters-changed` | Compare names, order, types, optionality, and method/client placement. Explain removal, rename, requiredness, or positional impact; an optional addition is not automatically compatible or breaking. |
| `method-response-changed` | Compare SDK result types and caller access; apply the response-wrapper exception below. |
| `method-kind-changed` | Compare `basic`, `paging`, `lro`, and `lropaging`; explain the changed invocation/result consumption. |
| `method-paging-changed` | Compare item/continuation behavior, not incidental serialized differences. |
| `method-lro-changed` | Compare polling, completion, and result behavior. Do not infer incompatibility from URI-template spelling alone. |

Parameter comparison excludes constant values. The report omits client-owned
parameters from numbered inputs, but their placement remains judgment evidence.
HTTP metadata supplies location, not a language-specific method signature.

## Type candidates and propagated method impact

| Rule | Evidence to compare and decision |
| --- | --- |
| `model-property-removed` | Identify the exact missing SDK member and affected caller access; apply the wrapper exception. |
| `model-property-changed` | Inspect the actual changed property fields: type, optionality, flattening, access, or serialized identity. Not every normalized property difference is breaking. |
| `model-property-added-required` | Approve request/input and bidirectional usage; reject response/output-only addition. Establish direction from supplied evidence, not the model name. |
| `enum-values-removed` | Compare SDK member names and wire values separately. A member rename with unchanged wire value can break SDK source use. |
| `enum-extensibility-changed` | Preserve the current policy: approve public/reachable fixed-to-extensible and extensible-to-fixed transitions. Explain generated type/consumption changes; also inspect `isUnionAsEnum`. |
| `public-surface-changed` | Distinguish actual removal, access/reachability loss, and incompatible union shape from usage-only metadata changes. Numeric usage differences alone do not prove lost availability. |

Inspect represented enum/union members, collection elements, dictionary values,
inheritance, discriminators, and nullable shapes where relevant. These are not
additional emitted rule IDs; never manufacture candidates to fill a checklist.

An unchanged method can expose any confirmed type incompatibility through its
supplied reference graph. Reachability identifies consumers; it does not by
itself prove incompatibility or a changed top-level signature.

## Client and customization candidates

| Rule | Evidence to compare and decision |
| --- | --- |
| `client-location-changed` | Compare client name, owner, and parent; require a changed public construction/access path. |
| `customization-changed` | Inspect changed `@clientName`, `@flattenProperty`, `@clientLocation`, or `@override` and supplied SDK facts. A decorator edit alone is not proof of breakage. |

These may have no method facts despite being grouped with method roots.
Do not invent method identities to fit presentation.

## Compatibility exceptions and evidence limits

- Reject implicit-to-explicit response-model candidates when the same generated
  SDK member remains available with the same type and optionality.
- Reject purely additive changes preserving existing signatures/runtime
  behavior, internal/unreachable changes, and candidates lacking a source-linked
  cause.
- Ignore YAML order, aliases, duplicate namespace views, artifact paths, and raw
  serialization noise.
- Do not equate "public type availability" with service/region availability.
  If both facts say public and reachable, do not describe the type as removed.
